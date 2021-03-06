<%@page import="domain.CreditCard"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="/segaDental/css/styleAdmin.css" />
	<title>Editar Solicitudes y Renovaciones</title>
	<script type="text/javascript" language="javascript" src="/segaDental/js/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/segaDental/js/jquery.dataTables.js"></script>
	<script type="text/javascript" language="javascript" src="/segaDental/js/jquery.leanModal.min.js"></script>
	<script type="text/javascript" language="javascript" src="/segaDental/js/messages.js"></script>
	<script type="text/javascript">
			$(function() {
    			$('a[rel*=leanModal]').leanModal({ top : 200, closeButton: ".close_x" });	
								
			});
	</script>
	<script>
		function mostrardiv(div1, div2) {
			cerrar(div1);
			div = document.getElementById(div2);
			div.style.display = "block";
		};
		function cerrar(div) {
			div = document.getElementById(div);
			div.style.display="none";
		};
		function getValueRadioButton(div1, div2){
			var elements = document.getElementsByName("agree");
			for (var x = 0; x < elements.length; x++){
				if(elements[x].checked){
					if (elements[x].value == 0){
						$("#goHidden").click();
					}
					else{
						mostrardiv(div1,div2);
					}
						
				}
			}
		};
		function steps(selected){
			var step3 = document.getElementById("step3");
			var step4 = document.getElementById("step4");
			if (selected){
				step3.removeAttribute("disabled");
				step4.removeAttribute("disabled");
			}
			else{
				step3.setAttribute("disabled", true);
				step4.setAttribute("disabled", true);
			}
		}
		
	</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	<img alt="logo" src="/segaDental/images/loguito.png"/>
        </div>           
        <div id="menu">
        	<div class="menuitemHome"><a href="UserLoginServlet">Home</a></div>	
	  		<div class="menuitemSalir"><a href="index.jsp">Salir</a></div>	
	 	</div>        
    	<div id="leftmenu">
        	<div id="leftmenu_top"></div>
			<div id="leftmenu_main">                    
            	<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
			</div>
            <div id="leftmenu_bottom"></div>
        </div>  
		<div id="content">
        		<h2>Verificar <%=request.getAttribute("type")%>:</h2>
	        	<p>&nbsp;</p>
           		<jsp:useBean id="client" type="domain.Client" scope="request"/> 
           		<jsp:useBean id="user" type="domain.User" scope="request"/> 
				<jsp:useBean id="statusJustification" type="java.util.ArrayList<domain.StatusJustification>" scope="request"/>  	
        		<jsp:useBean id="cardType" type="java.util.ArrayList<domain.CreditCard>" scope="request"/>  	
        		<%@page import="domain.ClientAddress"%>
				<%@page import="domain.ClientCreditCard"%>
				
				<div id="requestInfo1" style="display:block;">
				<div style="text-align:center;">
				    <input type="image" src="/segaDental/images/paso1_orange.png" name="paso1" height="auto" width="76">
				    <input type="image" src="/segaDental/images/paso2_gray.png" name="paso2" height="auto" width="76" onClick="mostrardiv('requestInfo1','requestInfo2');">
					<input type="image" src="/segaDental/images/paso3_gray.png" name="paso2" height="auto" width="76" onClick="mostrardiv('requestInfo1','requestInfo3');">
					<input type="image" src="/segaDental/images/paso4_gray.png" name="paso2" height="auto" width="76" onClick="mostrardiv('requestInfo1','requestInfo4');">
				<br><br>
				</div>
				<p >
				<%
					String adj = "el";
					   String pers = "Sr.";
					   if (client.getSex().equalsIgnoreCase("f"))	{
						   adj ="la";
						   pers = "Sra.";
					   }
						   
						   String plan = "";
						   if (client.getProduct().getId() == 1)
							   plan = "PLAN DE SEGURIDAD";
						   else if (client.getProduct().getId() == 2)
							   plan = "PLAN ODONTOL�GICO";
						   else 
							   plan = "PLAN DE DESCUENTO M�DICO";
				%>
				Buenos d�as/tardes, por favor con <%=adj  + " " + pers + " " + client.getFirstName()%> , mi nombre es 
				<%=user.getFirstName() + " " + user.getLastName()%> le estoy llamando del departamento de verificaci�n
				de <%=client.getProduct().getName()%>.</p><br>
				
				<p>Por controles de calidad y seguridad <%=pers  + " " +client.getFirstName()%>, su llamada a partir
				de este momento ser�  grabada. Mi llamada es para confirmar la informaci�n que usted le suministr� a nuestro ejecutivo
				de venta.</p><br>
				
				<p>�Su n�mero de c�dula es? <span style="font-weight: bold;">Esperamos respuesta del cliente. </span>	
					<a id="go" rel="leanModal" href="#signupCed" style="color: #f7941e; font-weight: bold;">(Modificar)</a><br>
					<span style="margin-left: 20px; color: gray;"> <%=client.getIdentityCard()%>	
					</span><br><br>
			
				�Su direcciones completa es? <span style="font-weight: bold;">Esperamos respuesta del cliente.</span>
				<%
					ClientAddress address = client.getAddress();
				%>
					<a id="go" rel="leanModal" href="#signupAddress" style="color: #f7941e; font-weight: bold;">(Modificar)</a><br>
					<span style="margin-left: 20px; color: gray;"> 
					<%=address.getDirection()%> 
					</span><br><br>

				
				�Su correo electr�nico es? <span style="font-weight: bold;">Esperamos respuesta del cliente.</span>
					<a id="go" rel="leanModal" href="#signupEmail" style="color: #f7941e; font-weight: bold;">(Modificar)</a><br>
					<span style="margin-left: 20px; color: gray;"> <%=client.getEmail()%> 
					</span><br><br>

				
				�Sus instrumentos de cr�ditos son: visa � mastercard, del banco? <span style="font-weight: bold;">Esperamos respuesta del cliente.</span>
					<a id="go" rel="leanModal" href="#signupCard" style="color: #f7941e; font-weight: bold;">(Modificar)</a><br>
					<span style="margin-left: 20px; color: gray;"> 
					<%
 						ClientCreditCard card = client.getCard();
 					%>
					Tipo: <%= card.getCardType() + ". Banco: " + card.getBank() %>
					</span><br><br>
					
				</p>	
					<br>
					
					<div class="buttonCenterVerif">
						<input type="button" class="button" value="Siguiente"  onClick="mostrardiv('requestInfo1','requestInfo2');"/>
					</div>
				</div>
				
				
				
				<div id="requestInfo2" style="display:none">
				<div style="text-align:center;">
					<input type="image" src="/segaDental/images/paso1_gray.png" name="paso1" height="auto" width="76" onClick="mostrardiv('requestInfo2','requestInfo1');">
				    <input type="image" src="/segaDental/images/paso2_orange.png" name="paso2" height="auto" width="76" >
					<input type="image" id="step3" src="/segaDental/images/paso3_gray.png" name="paso3" height="auto" width="76" onClick="mostrardiv('requestInfo2','requestInfo3');">
					<input type="image" id="step4" src="/segaDental/images/paso4_gray.png" name="paso4" height="auto" width="76" onClick="mostrardiv('requestInfo2','requestInfo4');">
					<br><br>
				</div>
				
					<%= pers + " " + client.getFirstName() %>, le recordamos que la afiliaci�n al <%= client.getProduct().getScriptStep2() %> tiene un costo anual
					de  <%= client.getProduct().getPrice() %>Bs, el cual ser� debitado de sus tarjetas de cr�dito, �Est� usted de acuerdo?<br><br>
					<form action="#verificarRadio"  method="post">
						<input type="radio" name="agree" value="0" onClick="steps(false)"> No<br>
						<input type="radio" name="agree" value="1" onClick="steps(true)" checked> Si<br>
				
						<div class="buttonCenterVerif">
							<input type="button" class="button" value="Volver"  onClick="mostrardiv('requestInfo2','requestInfo1');"/>
							<input type="button" class="button" value="Siguiente" style="margin-left:20px;" onClick="getValueRadioButton('requestInfo2','requestInfo3');" />
						</div>
						<a id="goHidden" rel="leanModal" href="#noAgree" style="color: #f7941e; font-weight: bold;"></a><br>
					
					</form>	
						
				</div>
				
				<div id="requestInfo3" style="display:none">
					<div style="text-align:center;">
						<input type="image" src="/segaDental/images/paso1_gray.png" name="paso1" height="auto" width="76" onClick="mostrardiv('requestInfo3','requestInfo1');">
						<input type="image" src="/segaDental/images/paso2_gray.png" name="paso2" height="auto" width="76" onClick="mostrardiv('requestInfo3','requestInfo2');">
						<input type="image" src="/segaDental/images/paso3_orange.png" name="paso3" height="auto" width="76" >
						<input type="image" src="/segaDental/images/paso4_gray.png" name="paso4" height="auto" width="76" onClick="mostrardiv('requestInfo3','requestInfo4');">
						<br><br>
					</div>
					
					<h2> Bienvenida al Cliente </h2><br>
					
					<p>Esta operaci�n la podr� verificar en sus estados de cuenta, bajo la raz�n social de Sega Dental C.A
					�Correcto  <%= pers + " " + client.getFirstName() %>?</p><br><br>
					
					<p>Por �ltimo, <%= pers + " " + client.getFirstName() %> le damos la m�s cordial bienvenida a lo que ser� desde este momento,
					su <%= client.getProduct().getScriptStep3() %>, en un lapso de 24 horas, ya usted podr� disfrutar de nuestros servicios.</p>
				
					<div class="buttonCenterVerif">
						<input type="button" class="button" value="Volver"  onClick="mostrardiv('requestInfo3','requestInfo2');"/>
						<input type="button" class="button" value="Siguiente"  style="margin-left:20px;" onClick="mostrardiv('requestInfo3','requestInfo4');" />
					</div>
							
						
				</div>
				
				<div id="requestInfo4" style="display:none">
				<div style="text-align:center;">
					<input type="image" src="/segaDental/images/paso1_gray.png" name="paso1" height="auto" width="76" onClick="mostrardiv('requestInfo4','requestInfo1');">
				    <input type="image" src="/segaDental/images/paso2_gray.png" name="paso2" height="auto" width="76" onClick="mostrardiv('requestInfo4','requestInfo2');">
					<input type="image" src="/segaDental/images/paso3_gray.png" name="paso3" height="auto" width="76" onClick="mostrardiv('requestInfo4','requestInfo3');">
					<input type="image" src="/segaDental/images/paso4_orange.png" name="paso4" height="auto" width="76" >
					<br><br>
				</div>
				
					<h2> Registrar el pago </h2><br>
					<form name="form" action="/segaDental/RegisterPaymentServlet" onsubmit="return validatePayment(this)" method="post">
					<input type="hidden" id="txtName" class="good_input" name="txtName"  value="<%= client.getFirstName() + " " + client.getLastName() %>"/>
					<input type="hidden" id="clientEmail" class="good_input" name="clientEmail"  value="<%= client.getEmail() %>"/>
					<input type="hidden" id="clientProductId" class="good_input" name="clientProductId"  value="<%= client.getClientProductId() %>"/>
					<input type="hidden" id="txtAmount" class="good_input" name="txtAmount"  value="<%= client.getProduct().getPrice() %>"/>
					<input type="hidden" id="txtCardId" class="good_input" name="txtCardId"  value="<%= client.getCard().getId() %>"/>
					<input type="hidden" id="type" class="good_input" name="type"  value="<%= request.getParameter("type") %>"/>
					
					<fieldset>
						<label for="nameCard">Tipo de Tarjeta:</label>
						<input type="text" name="txtCardType" id="txtCardType" maxlength="50" size="20" value="<%= card.getCardType() %>" readonly="readonly" style="border:none;"/> <br><br>
							
						<label for="description">N�mero de Tarjeta:</label>
						<% String cardNumber = String.valueOf(card.getCardNumber());
							String aux = cardNumber.substring(cardNumber.length() - 4);
							aux = "**" + aux;
						%>
						<input type="text" name="numCard" id="numCard" maxlength="50" size="30" value="<%= aux %>" readonly="readonly" style="border:none;"/> <br><br>
						<label for="nameCard">Banco:</label>
						<input type="text" name="txtBank" id="txtBank" maxlength="50" size="30" value="<%= card.getBank() %>" readonly="readonly" style="border:none;"/> <br><br>
							
							
						<label for="cedClient">C�dula:</label>
						<input type="text" name="txtCedNumClient" id="txtCedNumClient" maxlength="50" size="10" value="<%=client.getIdentityCard() %>" readonly="readonly" style="border:none;"/> <br><br>
						
						<label for="voucher">N�mero de Voucher:</label>
						<input type="text" name="txtVoucher" id="txtVoucher" maxlength="50" size="10"/> <br><br>
					</fieldset>
	
				
					<div class="buttonCenterVerif">
						<input type="button" class="button" value="Volver"  onClick="mostrardiv('requestInfo4','requestInfo3');"/>
						<input type="submit"  class="button"  name="sbmtButton" value="Agregar" style="margin-left:20px;" />
					</div>
					</form>
				</div>
		    <div id="footer"></div>
		</div>
	</div>
	
	
	
	<div id="signupCed">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Modificaci�n</h3><br><br>
				<span>�Est� seguro que desea modificar la c�dula del cliente <%= client.getFirstName() %> ? </span> <br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div><br>
				<form  class="edit" action="/segaDental/EditClientIdentCardServlet" method="post" onsubmit="return validateCed(this)" >
				  <input type="hidden" id="clientId" class="good_input" name="clientId"  value="<%= client.getClientId() %>"/>
				  <input type="hidden" id="type" class="good_input" name="type"  value="<%= request.getParameter("type")%>"/>
				  <input type="hidden" id="id" class="good_input" name="id"  value="<%= request.getParameter("id")%>"/>
				
     			  <fieldset>
				  <div class="txt-fld">
					<label for="identityCard">C�dula:</label>
					<select name="txtCedId" id="txtCedId" class="good_input">
						<%
							String [] ced = client.getIdentityCard().split("-");
							if (ced[0].equals("V")){
						%>
								<option value="V-" selected="selected">V</option>
								<option value="E-">E</option>
					 	<%
						}else{
							%>
							<option value="V-" >V</option>
							<option value="E-" selected="selected">E</option>
				 			<%
					 	}
					 	
					 	%>
					</select>
				    <input id="txtCedIdNum" class="good_input" name="txtCedIdNum" type="text"  value="<%= ced[1] %>"/>
				  </div>
				  
				  <div class="btn-fld">
					 <input type="submit"  class="buttonPopUp"  name="sbmtButton" value="Aceptar" style="margin-left:20px;" />
				  </div>
				  </fieldset>
				 </form>
			</div>
		</div>
		
	<div id="signupEmail">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Modificaci�n</h3><br><br>
				<span>�Est� seguro que desea modificar el correo del cliente <%= client.getFirstName() %> ? </span> <br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div><br>
				<form class="edit"  action="/segaDental/EditClientEmailServlet" method="post">
				  <input type="hidden" id="clientId" class="good_input" name="clientId"  value="<%=client.getClientId()%>"/>
				  <input type="hidden" id="type" class="good_input" name="type"  value="<%= request.getParameter("type")%>"/>
				  <input type="hidden" id="id" class="good_input" name="id"  value="<%= request.getParameter("id")%>"/>
				   <fieldset>
					  <div class="txt-fld">
						<label for="clientEmail">Correo Electr�nico:</label>
						<input id="txtEmailClient" class="good_input" name="txtEmailClient" type="text"  value="<%= client.getEmail() %>"/>
					  </div>
					  
					  <div class="btn-fld">
						 <input type="submit"  class="buttonPopUp"  name="sbmtButton" value="Aceptar" style="margin-left:20px;" />
					  </div>
				 </fieldset>
				 </form>
			</div>
		</div>	
		
		
		<div id="signupAddress">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Modificaci�n</h3><br><br>
				<span>�Est� seguro que desea modificar la direcci�n del cliente <%= client.getFirstName() %> ? </span> <br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div>
				<form action="/segaDental/EditClientAddressServlet" method="post" onsubmit="return validateAddress(this)">
				  <input type="hidden" id="clientId" class="good_input" name="clientId"  value="<%=client.getClientId()%>"/>
				  <input type="hidden" id="type" class="good_input" name="type"  value="<%= request.getParameter("type")%>"/>
				  <input type="hidden" id="id" class="good_input" name="id"  value="<%= request.getParameter("id")%>"/>
				  <input type="hidden" id="propertyTypeId" class="good_input" name="propertyTypeId"  value="<%= address.getPropertyTypeId() %>"/>
				
				  <fieldset>
				  <div class="txt-fld">
     				<label for="state">Estado:</label>
				    <input id="txtState" class="good_input" name="txtState" type="text"  value="<%= address.getState() %>"/>
				    <br>
				    <label for="city">Ciudad:</label>
				    <input id="txtCity" class="good_input" name="txtCity" type="text"  value="<%= address.getCity() %>"/>
					<br>
				  	<label for="municipality">Municipio:</label>
				    <input id="txtMunicipality" class="good_input" name="txtMunicipality" type="text"  value="<%= address.getMunicipality() %>"/>
					<br>
					<label for="urbanization">Urbanizaci�n:</label>
				    <input id="txtUrbanization" class="good_input" name="txtUrbanization" type="text"  value="<%= address.getUrbanization() %>"/>
				    <br>
					<label for="postalCode">C�digo Postal:</label>
				    <input id="txtPostalCode" class="good_input" name="txtPostalCode" type="text"  value="<%= address.getPostalCode()==null?"":address.getPostalCode() %>"/>
				    <br>
				    <label for="street">Calle:</label>
				    <input id="txtStreet" class="good_input" name="txtStreet" type="text"  value="<%= address.getStreet() %>"/>
				    <br>
				    <label for="referencePoint">Punto Referencia:</label>
				    <input id="txtReferencePoint" class="good_input" name="txtReferencePoint" type="text"  value="<%= address.getReferencePoint()==null?"":address.getReferencePoint() %>"/>
				    <br>
				    <label for="propetyName">Nombre de la propiedad:</label>
				    <input id="txtPropetyName" class="good_input" name="txtPropetyName" type="text"  value="<%= address.getPropertyName() %>"/>
				    <br>
				    <%
				    	if (address.getPropertyTypeId() == 1 || address.getPropertyTypeId() == 3 ||  address.getPropertyTypeId() == 5 )
				    	{
				    
				    %>
					   	<label for="tower">Torre:</label>
					    <input id="txtTower" class="good_input" name="txtTower" type="text"  value="<%= address.getTower() %>"/>
					    <br>
					    <label for="floor">Piso:</label>
					    <input id="txtFloor" class="good_input" name="txtFloor" type="text"  value="<%= address.getFloor() %>"/>
					    <br>
					    <label for="apartment">Apartamento:</label>
					    <input id="txtApartment" class="good_input" name="txtApartment" type="text"  value="<%= address.getPropertyName()%>"/>
						<br>
					<%
				    	}
				    
				    %>
						
				  </div>
				  <br>
				  <div class="btn-fld">
					 <input type="submit"  class="buttonPopUpSA"  name="sbmtButton" value="Aceptar" style="margin-left:20px;" />
				  </div>
				  </fieldset>
				  
				 </form>
			</div>
		</div>	
		
		
		<div id="signupCard">
			<div id="signup-ct">
				<h3 id="see_id" class="sprited" >Modificaci�n</h3><br><br>
				<span>�Est� seguro que desea modificar los datos de la tarjeta del cliente <%= client.getFirstName() %> ? </span> <br>
				<div id="signup-header">
					<a class="close_x" id="close_x"  href="#"></a>
				</div><br>
				<form  class="edit" action="/segaDental/EditClientCardServlet" method="post" onsubmit="return validateCreditCard(this)">
				  <input type="hidden" id="clientId" class="good_input" name="clientId"  value="<%= client.getClientId() %>"/>
				  <input type="hidden" id="type" class="good_input" name="type"  value="<%= request.getParameter("type")%>"/>
				  <input type="hidden" id="id" class="good_input" name="id"  value="<%= request.getParameter("id")%>"/>
				  <fieldset>
     			  	<div class="txt-fld">
					  	<label for="tarjeta">Tipo Tarjeta:</label>
							<select class="good_input" name="txtCardTypeEdit" id="txtCardTypeEdit">
								<%
									for(CreditCard cc : cardType) {
										String selected = "";
										if (card.getCardType().equals(cc.getName())){
											selected = "selected=selected";
										}
								%>
									<option value="<%=cc.getId()%>" <%= selected %>> <%=cc.getName()%> </option>
								<%
									}
								%>
							</select><br><br>
				  </div>
				  
				  <div class="txt-fld">
					<label for="bank">Banco:</label> &nbsp;
				    <input id="txtBankEdit" class="good_input" name="txtBankEdit" type="text"  value="<%= card.getBank() %>" style="margin-left:25px;"/>
				  </div><br>
				  
				  <div class="btn-fld">
						<input type="submit"  class="buttonPopUp"  name="sbmtButton" value="Aceptar" style="margin-left:20px;" />
				  </div>
				  </fieldset>
				 </form>
			</div>
		</div>	
		
		
	<div id="noAgree">
		<div id="signup-ct">
			<h3 id="see_id" class="sprited" >Devoluci�n de <%= request.getParameter("type")%></h3>
			<br><br>
			<span>�Est� seguro que desea devolver la <%= request.getParameter("type")%> del cliente <%= client.getFirstName() %> ? </span> <br><br>
			<div id="signup-header">
				<a class="close_x" id="close_x"  href="#"></a>
			</div>
			<form action="/segaDental/SendBackRequestServlet" method="post"  onsubmit="return validateJustification(this)">
				<input type="hidden" id="clientProductId" class="good_input" name="clientProductId"  value="<%= client.getClientProductId() %>"/>
				  <div class="txt-fld">
   			  	<%
				for(domain.StatusJustification sj : statusJustification) { 	
					if (sj.getId() != 5){
				%>
				<input type="radio" name="justif" value="<%= sj.getId() %>"><%= sj.getName() %><br>
				<%
					}
				}
				%>
				<input type="radio" name="justif" value="5" checked> 
					Otro: <input name="otherJustif" id="otherJustif" />
			  </div><br>
			  <div class="btn-fld">
				  <input type="submit"  class="buttonPopUp"  name="sbmtButton" value="Aceptar" style="margin-left:20px;" />
			  </div>
		 </form>
		</div>
	</div>	
	
	
	
	
</body>
</html>