<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>
<%@page import="java.util.Iterator"%>

<% 
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
		
	try
	{
		Iterator it = cs.getGerentes().iterator();
		while(it.hasNext())
		{
			Gerente g = (Gerente) it.next();
			out.print("<div><label>Senha Atual</label><br>"+g.getUsuario().getNome()+":"+((Senha)g.getSenhas().get(g.getSenhas().size()-1)).getSenha()+"<label></label></div>");
		}
	}
	catch(Exception e)
	{
		
	}
	
	
%>

