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
		}
		else if(request.getParameter("actc")!= null)
		{
			session.setAttribute("senhaChamada", cs.chamarProximaSenha(sl));
			cs.InserirSenhaGerente(sl.getNome(),(Senha)session.getAttribute("senhaChamada"));
		}
		else if(request.getParameter("actm") != null)
		{
			cs.atrasarSenha((Senha)session.getAttribute("senhaChamada"));	
		}
%>
<form method="post" action="index.jsp?page=GerenciamentoSistema">
<input type="submit" value="Reiniciar Contagem de Senhas">
<input name="actr" type="hidden" value="r">
</form>
<% 
	if(session.getAttribute("senhaChamada") != null)
	{
		
	}
	else
	{
		out.print("<h2>Não ha senhas registradas</h2>");
	}
%>
<form method="post" action="index.jsp?page=GerenciamentoSistema"><input name="actc" type="hidden" value="c"><input type="submit" value="Proxima Senha"></form>
<form method="post" action="index.jsp?page=GerenciamentoSistema"><input name="actm" type="hidden" value="m"><input type="submit" value="Marcar como senha Atrasada"></form>

<%}else{ %>
<h1>Voce não esta logado!</h1>
<%}%>