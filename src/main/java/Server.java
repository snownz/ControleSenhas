import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import Controle.GerenciaLogin;
import Controle.Login;
import Controle.SalvarRecuperarDados;
import Controle.controleSenhas;
import Dados.Senha;

@WebServlet("/Server")
public class Server extends HttpServlet
{
	GerenciaLogin gl ;
	controleSenhas cs;
	Login sl;
	Senha s;
	
	HttpSession pageSession;	
	PageContext pageContext;
	
	String path = "";
	
	private void initVar(HttpServletRequest request, HttpServletResponse response)
	{
		pageSession = request.getSession();
	    pageContext = JspFactory.getDefaultFactory().getPageContext(this,	request, response,	null, false, JspWriter.DEFAULT_BUFFER,	true );
	    path = (String)pageSession.getAttribute("startUpPath");
	    sl = (Login)pageSession.getAttribute("Login");
	    s  = (Senha)pageSession.getAttribute("Senha");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
        initVar(request, response);
        try {checkGerenciaLogin();} 
        catch (ClassNotFoundException e) 
        {
        	e.printStackTrace();
        	return;
		}
        try {checkControleSenhas();}
        catch (ClassNotFoundException e) 
        {
			e.printStackTrace();
			return;
		}       
        
        String cadastrado = request.getParameter("cadastroOk");
        String login = request.getParameter("loginOk");
        
        if(cadastrado != null)
        {
    		cadastrar(request.getParameter("inLogin"), request.getParameter("inSenha"));
    		request.removeAttribute("cadastroOk");
        }
        if(login != null)
        {
        	login(request.getParameter("inLogin"), request.getParameter("inSenha"));
    		request.removeAttribute("loginOk");
        }        
        if(sl != null)
		{
			if(!sl.getGerente())
			{
				if(request.getParameter("gerarOk")!= null)
				{
					gerarSenha(request.getParameter("Preferencial"));
					request.removeAttribute("gerarOk");
				}
				if(request.getParameter("cancelarOk")!= null && cs.getSenhaUsuario(sl) != null)
				{
					cancelarSenha();
					request.removeAttribute("cancelarOk");
				}
				if(request.getParameter("renovarOk")!= null)
				{
					renovarSenha();
					request.removeAttribute("renovarOk");
				}
			}
		}          
        
        
        pageSession.setAttribute("RetServer", "");
        if (!response.isCommitted())
        {  
        	   RequestDispatcher dispatcher = request.getRequestDispatcher("Cliente");   
        	   dispatcher.forward(request, response);   
        }  
	}

	/*Logica do Servidor*/		
	private void checkGerenciaLogin() throws ClassNotFoundException, IOException
	{
		gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
		if(gl == null)
		{
			File f = new File(path + "controleUsuarios.ser");
			if(!f.exists())
				gl = GerenciaLogin.getInstancia();
			else
				gl = (GerenciaLogin) SalvarRecuperarDados.Recuperar(path + "controleUsuarios.ser");
			pageContext.setAttribute("gerenciaLogin", gl, pageContext.APPLICATION_SCOPE);
		}
		SalvarRecuperarDados.Salvar(path+"controleUsuarios.ser", gl);
			
	}
	private void checkControleSenhas() throws ClassNotFoundException, IOException
	{
		cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
		
		if(cs == null)
		{
			File f = new File(path+"controleSenhas.ser");
			if(!f.exists())
				cs = controleSenhas.getInstancia();
			else
				cs = (controleSenhas) SalvarRecuperarDados.Recuperar(path+"dados.ser");
			pageContext.setAttribute("controleSenhas", cs, pageContext.APPLICATION_SCOPE);
		}
		SalvarRecuperarDados.Salvar(path+"controleSenhas.ser", cs);			
	}
	
	private void cadastrar(String Login, String Senha)
	{
		Login l = new Login();
		l.setEstado(false);
		l.setNome(Login);
		l.setSenha(Senha);
		l.setGerente(false);
		gl.addLogin(l);		
		pageSession.setAttribute("PaginaAtual", "Login");
	}
	private void login(String Login, String Senha)
	{
		Login l = new Login();
		l.setNome(Login);
		l.setSenha(Senha);
		Login laux = gl.existeLogin(l);
		if(laux != null)
		{
			gl.alterarEstado(laux, true);
			laux.setEstado(true);
			pageSession.setAttribute("Login", laux);
			if(laux.getGerente())
				cs.inserirGerente(laux);
			pageSession.setAttribute("PaginaAtual", "Inicio");
		}
		else		
			pageSession.setAttribute("PaginaAtual", "Login");
	}
	private void gerarSenha(String Preferencial)
	{
		boolean p = Preferencial == null ? false : true;
		cs.GerarSenha(sl, p);		
		pageSession.setAttribute("PaginaAtual", "Senha");
	}
	private void cancelarSenha()
	{
		cs.cancelarSenha(cs.getSenhaUsuario(sl));
		pageSession.setAttribute("PaginaAtual", "Senha");
	}
	private void renovarSenha()
	{
		cs.renovarSenha(cs.getSenhaUsuario(sl));	
		pageSession.setAttribute("PaginaAtual", "Senha");
	}
	
}
