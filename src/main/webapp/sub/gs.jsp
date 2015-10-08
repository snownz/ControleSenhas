<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>

<% 
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);	
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
	
	Login sl =(Login)session.getAttribute("login");	
	boolean Logado = (sl != null);
	
	if(Logado)
	{
		if(request.getParameter("actr") != null)
		{
			cs.ResetarSenha();
			request.setAttribute("actr", null);
		}
		else if(request.getParameter("actc")!= null)
		{
			session.setAttribute("senhaChamada", cs.chamarProximaSenha(sl));
			cs.InserirSenhaGerente(sl.getNome(),(Senha)session.getAttribute("senhaChamada"));
			request.setAttribute("actc", null);
		}
		else if(request.getParameter("actm") != null)
		{
			cs.atrasarSenha((Senha)session.getAttribute("senhaChamada"));
			request.setAttribute("actm", null);
		}
		else if(request.getParameter("actrt") != null)
		{
			cs = controleSenhas.getInstancia();
			pageContext.setAttribute("controleSenhas", cs, pageContext.APPLICATION_SCOPE);
			SalvarRecuperarDados.Salvar(pageContext.getAttribute("startUpPath")+"dados.ser", cs);
			request.setAttribute("actrt", null);
		}
%>
<form method="post" action="index.jsp?page=GerenciamentoSistema"><input name="actrt" type="hidden" value="rt"><input type="submit" value="Reiniciar Sistema"></form>
<form method="post" action="index.jsp?page=GerenciamentoSistema"><input type="submit" value="Reiniciar Contagem de Senhas"><input name="actr" type="hidden" value="r"></form>
<% 
	if(session.getAttribute("senhaChamada") != null)
	{
		Senha satual = (Senha)session.getAttribute("senhaChamada");
		out.print("<h3>Senha: "+satual.getSenha()+" Info: " +satual.getInfo()+"</h3>");
		out.print("<form method='post' action='index.jsp?page=GerenciamentoSistema'><input name='actm' type='hidden' value='m'><input type='submit' value='Cliente ausente'></form>");
	}
	else
	{
		out.print("<h2>Não ha senhas registradas</h2>");
	}
%>
<form method="post" action="index.jsp?page=GerenciamentoSistema"><input name="actc" type="hidden" value="c"><input type="submit" value="Chamar Proxima Senha"></form>
<%}else{ %>
<h1>Voce não esta logado!</h1>
<%}%>