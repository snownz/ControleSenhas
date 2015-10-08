<%@page import="java.util.Iterator"%>
<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>

<%
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	String cadastrado = request.getParameter("cadastroOk");
	if(cadastrado != null)
	{
		Login l = new Login();
		l.setEstado(false);
		l.setNome(request.getParameter("inLogin"));
		l.setSenha(request.getParameter("inSenha"));
		l.setGerente(false);
		gl.addLogin(l);
		request.removeAttribute("cadastroOk");
	}
%>
<div id="frmUsuarioSenha">
<br><h1>Criar uma Conta</h1>
<form method="post" action="index.jsp?page=Cadastro" >
	<br>
	<label>[Usuario]:</label>&emsp;
	<input type="text" name="inLogin"><br><br>
	<label>[Senha]:</label>&emsp;
	<input type="password" name="inSenha"><br><br>
	<input type="hidden" name="cadastroOk" value="true">
	<input type="submit" name="cadastrar" value="Cadastrar">
</form>
</div>
