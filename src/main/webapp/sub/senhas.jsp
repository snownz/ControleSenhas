<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>

<% 
	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
	
	Login sl =(Login)session.getAttribute("login");	
	boolean Logado = (sl != null);
	out.print("<h2>Bem vindo "+sl.getNome()+"</h2>");
	if(Logado)
	{	
		Senha s = cs.getSenhaUsuario(sl);
		if(request.getParameter("gerarOk")!= null)
		{
			boolean p = request.getParameter("Preferencial") == null ? false : true;
			cs.GerarSenha(sl, p);
			request.removeAttribute("gerarOk");
		}
		if(request.getParameter("cancelarOk")!= null && s != null)
		{
			cs.cancelarSenha(cs.getSenhaUsuario(sl));
			request.removeAttribute("cancelarOk");
		}
		if(request.getParameter("renovarOk")!= null)
		{
			cs.renovarSenha(cs.getSenhaUsuario(sl));
			request.removeAttribute("renovarOk");
		}		
		if(s == null)
		{
%>

<h3>Voce ainda não solicitou uma senha para o atendimento!</h3>
<h3>Para solicitar a senha utilize o formulario abaixo</h3>
<form method="post" action="index.jsp?page=GerarSenha">
	<input type="hidden" name="gerarOk" value="true">
	<input type="checkbox" name="Preferencial" value="disabled"><label>Atendimento Preferencial</label><br><br>
	<input type="submit"  value="Gerar Senha">
</form>
<%}else if(s.getCancelada() || s.getChamada()){%>
<h3>Voce ainda não solicitou uma senha para o atendimento!</h3>
<h3>Para solicitar a senha utilize o formulario abaixo</h3>
<form method="post" action="index.jsp?page=GerarSenha">
	<input type="hidden" name="gerarOk" value="true">
	<input type="checkbox" name="Preferencial" value="disabled"><label>Atendimento Preferencial</label><br><br>
	<input type="submit"  value="Gerar Senha">
</form>
<%}else if(s.getAtrasada()){%>
<h3>Sua senha ja foi chamada!</h3>
<h3>Para entra na fila novamente renove sua senha</h3>
<form method="post" action="index.jsp?page=GerarSenha">
	<input type="hidden" name="renovarOk" value="true">
	<input type="submit" value="Renovar senha">
</form>
<h3>ou Para cancelar senha utilize o link abaixo</h3>
<form method="post" action="index.jsp?page=GerarSenha">
	<input type="hidden" name="cancelarOk" value="true">
	<input type="submit" value="Cancelar Senha">
</form>
<%}else{ %>
<h3>Voce já solicitou uma senha para o atendimento!</h3>
<h3>Para cancelar senha utilize o link abaixo</h3>
<form method="post" action="index.jsp?page=GerarSenha">
	<input type="hidden" name="cancelarOk" value="true">
	<input type="submit" value="Cancelar Senha">
</form>
<%}%>
<%}else{ %>
<h1>Voce não esta logado!</h1>
<%}%>