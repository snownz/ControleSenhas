<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>
<% 	
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	if(gl == null)
	{
		gl = GerenciaLogin.getInstancia();
		pageContext.setAttribute("gerenciaLogin", gl, pageContext.APPLICATION_SCOPE);
	}
	
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
	if(cs == null)
	{
		cs = controleSenhas.getInstancia();
		pageContext.setAttribute("controleSenhas", cs, pageContext.APPLICATION_SCOPE);
	}
	
	Login sl =(Login)session.getAttribute("login");	
	boolean Logado = (sl != null);
		
	if(request.getParameter("sair") != null && Logado)
	{
		gl.alterarEstado(sl, false);
		if(sl.getGerente())
			cs.removerGerente(sl.getNome());
		session.setAttribute("login", null);
		pageContext.forward("index.jsp");
	}	
	
	String startUpPath = getServletContext().getRealPath("/");
	String pageGet = "";
	if (request.getParameter("page") != null) 
		pageGet = request.getParameter("page")+".dat" ;
	final controlePagina cp = new controlePagina(startUpPath+"/confPage/"+pageGet, startUpPath);	
%>
<html> 
	<head>
		<link rel="stylesheet" type="text/css" href="tema.css">		
	</head>
<body>

	<div id="header">
		<h1>Fila de espera para consulta com gerentes do banco</h1>
		<h3><%out.print(cp.TituloPagina());%></h3>
	</div>
	
	<div id="nav">
		<a href="index.jsp">Inicio</a><br>
		<% if(Logado){ %>		
			<% if(sl.getGerente()){ %>
			<a href="index.jsp?page=GerenciamentoSistema">Sistema</a><br>
			<%}else{ %>
			<a href="index.jsp?page=GerarSenha">Senhas</a><br>
			<%}%>
		<a href="index.jsp?page=Fila">Fila</a><br>
		<a href="index.jsp?sair=y">Sair</a><br>
		<%}else{ %>
		<a href="index.jsp?page=Login">Entrar</a><br>
		<a href="index.jsp?page=Cadastro">Cadastrar</a><br>
		<%}%>
	</div>
		
	<div id="section">
		<jsp:include page="<%=cp.Pagina()%>"/>
	</div>
	
	<div id="footer">
		Copyright © Desenv Fernandes
	</div>
	
</body>
</html>
