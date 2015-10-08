<%@page import="java.util.Iterator"%>
<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>

<%	
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
	String msg = "";
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
			msg = "Usuario ou senha invalidos"; 			
	}		
%>

<% if(session.getAttribute("login") == null){ %>	
<div id="frmUsuarioSenha">
<br><h1>Logar no Site</h1>
<form method="post" action="index.jsp?page=Login" id="frUsuarioSenha">
	<br>
	<label>[Usuario]:</label>&emsp;
	<input type="text" name="inLogin"><br><br>
	<label>[Senha]:</label>&emsp;
	<input type="password" name="inSenha"><br><br>
	<input type="hidden" name="loginOk" value="true">
	<input type="submit" name="logar" value="Login">
</form>
</div>
<h3 style='color:red; margin-left: 6.5%;'><%=msg %></h3>
<%}else{ %>
<h1>Voce já esta logado</h1>
<%}%>
