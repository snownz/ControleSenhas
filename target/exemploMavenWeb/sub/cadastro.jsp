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
<form method="post" action="index.jsp?page=Cadastro">
	<input type="text" name="inLogin">
	<input type="password" name="inSenha">
	<input type="hidden" name="cadastroOk" value="true">
	<input type="submit" name="cadastrar" value="Cadastrar">
</form>

<%
	Iterator it = gl.getListaLogin().iterator();
	while(it.hasNext())
	{
		Login l = (Login) it.next();
		out.print(l.getNome()+"<br/>");
	}
%>