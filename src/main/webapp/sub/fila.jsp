<%@ page import="Dados.*" %>
<%@ page import="Controle.*" %>
<% 
	response.setIntHeader("Refresh", 5);

	GerenciaLogin gl = (GerenciaLogin) pageContext.getAttribute("gerenciaLogin", pageContext.APPLICATION_SCOPE);
	controleSenhas cs = (controleSenhas) pageContext.getAttribute("controleSenhas", pageContext.APPLICATION_SCOPE);
		
	Login sl =(Login)session.getAttribute("login");	
	boolean Logado = (sl != null);
	
	if(Logado)
	{
		int maxProxima = 10;
		Senha[] sp = cs.getFilaPreferencial(), 
		        sn = cs.getFilaNormal(),
		        st = cs.getProximas(maxProxima);
%>	
<table >
	<tr>
		<td width="20%">
        	<table>
        		<tr>
			       <td style="text-align: center;">
			          Fila de Senhas     
			        </td>			                         
				</tr>
				<tr>
			       <td>
			         <div class="CSSTableGenerator" id="filanorm">
					     <table >
					         <tr>
					             <td>
					                 Senha
					             </td>
					             <td >
					                 Cliente
					             </td>            
					         </tr>
					         <%for(int i = 0; i < maxProxima; i++){
					        	 if(st[i] != null){ %>
					         <tr>
					             <td >
					                <%=st[i].getSenha() %>
					             </td>
					             <td>
					                 <%=st[i].getUsuario().getNome() %>
					             </td>            
					         </tr>  
					         <% }}%>                
					     </table>
					 </div>       
			        </td>			                         
				</tr>
        	</table>                  
        </td>
	 	<td width="40%">
           <div class="CSSTableGenerator" id="filapref">
			     <table >
			         <tr>
			             <td>
			                 Senha (Preferencial)
			             </td>
			             <td >
			                 Info
			             </td>            
			         </tr>
			         <%for(int i = 0; i < cs.getUltimaSenhaP(); i++)
			         {
			        	 if(!sp[i].getAtrasada() && !sp[i].getCancelada() && !sp[i].getChamada()){ %>
			         <tr>
			             <td >
			                <%=sp[i].getSenha() %>
			             </td>
			             <td>
			                 <%=sp[i].getInfo() %>
			             </td>            
			         </tr>  
			         <% }}%>                
			     </table>
			</div>     
        </td>
        <td width="40%">
             <div class="CSSTableGenerator" id="filanorm">
			     <table >
			         <tr>
			             <td>
			                 Senha (Normal)
			             </td>
			             <td >
			                 Info
			             </td>            
			         </tr>
			         <%for(int i = 0; i < cs.getUltimaSenhaN(); i++)
			         {
			        	 if(!sn[i].getAtrasada() && !sn[i].getCancelada() && !sn[i].getChamada()){ %>
			         <tr>
			             <td >
			                <%=sn[i].getSenha() %>
			             </td>
			             <td>
			                 <%=sn[i].getInfo() %>
			             </td>            
			         </tr>  
			         <% }}%>                
			     </table>
			 </div>   
        </td>        
	</tr>
</table> </div>

 <%
 }
	else
		out.print("Voce não esta Logado"); 
%>