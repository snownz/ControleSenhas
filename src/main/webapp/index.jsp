<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<% 
	if(session.getAttribute("startUpPath") == null)
		session.setAttribute("startUpPath", getServletContext().getRealPath("/"));
	//if(session.getAttribute("Pagina") == null)
	//{
		
	//}
	//if(session.getAttribute("TimeToRefresh") != null)
		//response.setIntHeader("Refresh", Integer.parseInt((String)session.getAttribute("TimeToRefresh")));
	//else
		//response.setIntHeader("Refresh", 99999);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> 
	<head>
		<link rel="stylesheet" type="text/css" href="tema.css">			
	</head>
<body>	
	<div id="header">
		<h1>Fila de espera para consulta com gerentes do banco</h1>
		<h3><%=session.getAttribute("Titulo")%></h3>
	</div>
	
	<div id="nav">
		<%=session.getAttribute("Menu")%>
	</div>
		
	<div id="section">
		<%=session.getAttribute("Pagina")%>
	</div>
	
	<div id="footer">
		Copyright © Desenv Fernandes
	</div>
	<div><%=session.getAttribute("SereverError")%></div>
</body>	
<html> 	
<form action="Cliente" method="post">    
    <input type="submit" value="Utilizar Aplicativo"/>
</form>