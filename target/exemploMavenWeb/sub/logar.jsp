<%@page import="java.util.Iterator"%>
<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>

<%	
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
	
	String login = request.getParameter("loginOk");
	if(login != null)
	{
		Login l = new Login();
		l.setNome(request.getParameter("inLogin"));
		l.setSenha(request.getParameter("inSenha"));
		Login laux = gl.existeLogin(l);
		
		request.removeAttribute("loginOk");
		
		if(laux != null)
		{
			gl.alterarEstado(laux, true);
			laux.setEstado(true);
			session.setAttribute("login", laux);
			if(laux.getGerente())
				cs.inserirGerente(laux);
			pageContext.forward("\\..\\index.jsp?page=index");
		}
		else		
			out.print("<h3>Usuario ou senha invalidos</h3>");			
	}		
%>

<% if(session.getAttribute("login") == null){ %>	
<form method="post" action="index.jsp?page=Login">
	<input type="text" name="inLogin">
	<input type="password" name="inSenha">
	<input type="hidden" name="loginOk" value="true">
	<input type="submit" name="logar" value="Login">
</form>
<%}else{ %>
<h1>Voce já esta logado</h1>
<%}%>
