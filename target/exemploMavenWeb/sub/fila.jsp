<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>
<% 
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
		
	Login sl =(Login)session.getAttribute("login");	
	boolean Logado = (sl != null);
	
	if(Logado)
	{
		Senha[] sp = cs.getFilaPreferencial(), 
		        sn = cs.getFilaNormal();
		for(int i = 0; i < cs.getUltimaSenhaP(); i++)
		{
			if(!sp[i].getCancelada())
				out.print(sp[i].getSenha()+"<br>");
		}
		
		for(int i = 0; i < cs.getUltimaSenhaN(); i++)
		{
			if(!sn[i].getCancelada())
				out.print(sn[i].getSenha()+"<br>");
		}
	}
	else
		out.print("Voce não esta Logado");
%>		