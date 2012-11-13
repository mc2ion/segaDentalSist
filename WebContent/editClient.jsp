<%@page import="domain.PhoneType"%>
<%@page import="domain.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script type="text/javascript" src="/segaDental/js/messages.js"></script>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
	<script src="/segaDental/js/jquery.bgiframe.min.js" type="text/javascript"></script>
	<script src="/segaDental/js/jquery.multiSelect.js" type="text/javascript"></script>
	<link href="/segaDental/css/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="/segaDental/css/styleAdmin.css" />
		
	<script type="text/javascript" src="/segaDental/js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="/segaDental/js/jquery-ui-1.8.24.custom.min.js"></script>
	<script type="text/javascript" src="/segaDental/js/jquery.ui.datepicker-es.js"></script>
	<script type="text/javascript" language="javascript" src="/segaDental/js/messages.js"></script>
	
	<title>Editar Cliente</title>
	<script type="text/javascript">
	$(function(){
		$.datepicker.setDefaults($.datepicker.regional['es']);
		$('#txtDateIni').datepicker({
			showOn: "button",
			buttonImage: "images/calendar.png",
			buttonImageOnly: true,
			buttonText: "Seleccione una fecha",
			dateFormat:'dd/mm/yy',
			changeMonth: true,
		    changeYear: true,
		});
	} );
</script>
<script type="text/javascript">
function mostrardiv(div1, div2) {
	div = document.getElementById(div1);
	div.style.display = "block";
	
	div2 = document.getElementById(div2);
	div2.style.display="none";
	
};

</script>
<script type="text/javascript">
<!--
function printPageContent(printContainer) {
	var DocumentContainer = document.getElementById(printContainer);
	document.getElementById('no_print').style.visibility='hidden';
	document.getElementById('title').style.visibility='visible';
	var WindowObject = window.open('', "PrintWindow", "");
    WindowObject.document.writeln(DocumentContainer.innerHTML);
	WindowObject.print();
    WindowObject.close();
	document.getElementById('no_print').style.visibility='visible';
	document.getElementById('title').style.visibility='hidden';

}
//-->
</script>
</head>
<body>
	<div id="container">
		<div id="header">
        	<img alt="logo" src="/segaDental/images/loguito.png"/>
        </div>   
		<div id="menu">
			<div class="menuitemHome"><a href="UserLoginServlet">Home</a></div>	
			<ul>      
			</ul>
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
        		<h2>Editar Cliente:</h2>
      				<jsp:useBean id="clientInfo" type="domain.Client" scope="request"/> 
					<jsp:useBean id="phoneType" type="java.util.ArrayList<domain.PhoneType>" scope="request"/>  	
        	
					<% if (clientInfo.getType().equalsIgnoreCase("titular")){
					%>
						<a href="#null" onclick="printPageContent('print_div2')" style="position: absolute; left: 800px; top: 200px;"> 
							<img alt="logo" src="/segaDental/images/print.png" height="20" width="20" style="padding-right:5px;"/> 
							<span style="font-weight: bold; color:#00668c; ">Imprimir </span>
						</a>
						<div id="print_div2">	
						<div id="title" STYLE="visibility:hidden;"> Informacion del cliente <%= clientInfo.getFirstName() %> <%= clientInfo.getLastName() %> </div>
					 	<form name="form" class="formClient" action="/segaDental/EditClientServlet" onsubmit="return validateClient(this)" method="post">
							<input type="hidden" name="txtClientId" value="<%= request.getParameter("clientId") %>" />
							<input type="hidden" name="type" value="<%= request.getParameter("type") %>" />
							<input type="hidden" name="txtPropertyTypeId" value="<%= clientInfo.getAddress().getPropertyTypeId() %>" />
							<div id="personales">
									<div id="pestanas">
									   <ul>
										  <li class="activa"><a href="#null" onclick="mostrardiv('personales', 'direccion')">Datos Personales</a></li>
										  <li ><a href="#" onclick="mostrardiv('direccion', 'personales')">Datos Direcci�n</a></li>
									   </ul>
									</div>
								<BR><BR>	
							<div style="border: 1px solid #E6E6E6;">
							<fieldset>
								<label for="name">Nombres:</label>
								<input type="text" name="txtName" id="txtName" maxlength="50" size="40" value="<%= clientInfo.getFirstName() %>" /> <br><br>
								<label for="LastName">Apellidos:</label>
								<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="40" value="<%= clientInfo.getLastName() %>" /> <br><br>
								<label for="cedId">C&eacute;dula de identidad:</label>
								<%
								String identityCard = clientInfo.getIdentityCard();
								String identityCardId = identityCard.substring(0, 2);
								String identityCardNum = identityCard.substring(2);
								%>
								<select name="txtCedId" id="txtCedId">
								<%
								if(identityCardId.equalsIgnoreCase("V-")){
								%>
									<option value="V-" selected="selected">V</option>
									<option value="E-">E</option>
								<%	
								} else {
								%>	
									<option value="V-">V</option>
									<option value="E-" selected="selected">E</option>
								<%
								}
								%>
								</select>
								<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= identityCardNum %>" /> <br><br>
								<label for="date">Fecha de Nacimiento:</label>
								<input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="<%= clientInfo.getBirthday() %>" />
								<span id="txtGenLabel"> Sexo: </span>
								<select name="txtGen" id="txtGen">
									<%	
									if (clientInfo.getSex().equalsIgnoreCase("f")){
									%>	
										<option value="F" selected="selected">Femenino</option>
										<option value="M">Masculino</option>
									<%	
									} else {
									%>	
									<option value="F">Femenino</option>
									<option value="M" selected="selected">Masculino</option>
									<%
									}
									%>
								</select><br><br> 
								<label for="email">Correo Electr�nico:</label>
								<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="40" value="<%= clientInfo.getEmail() %>" /> <br><br>
								<%
									ArrayList<String> phones = clientInfo.getPhones();	
									for( int i = 0; i<phones.size(); i++){
										String [] phone = phones.get(i).split("-");
										String type = phone[0];
										String number = phone[1];
										for (domain.PhoneType p: phoneType){
											if (p.getId() == Integer.valueOf(type)){
												String typeName = p.getName();
								%>		
											<label for="phone"><%= typeName %>:</label>
											<input type="text" name="txtPhone<%=i%>>" id="txtPhone<%=i %>" maxlength="50" size="40" value="<%= number %>" /> <br><br>
								<%
											}
										}
									}
								%>
									</fieldset>
								</div>
							</div>
							
						
							<div id="direccion" style="display:none">
							<div id="pestanas">
									   <ul>
										  <li ><a href="#null" onclick="mostrardiv('personales', 'direccion')">Datos Personales</a></li>
										  <li class="activa"><a href="#" onclick="mostrardiv('direccion', 'personales')">Datos Direcci�n</a></li>
									   </ul>
							</div><BR><BR>
							<div style="border: 1px solid #E6E6E6;;">
							<fieldset>	
							<label for="email">	Estado: </label>
							    <input id="txtState" class="good_input" name="txtState" type="text"  value="<%= clientInfo.getAddress().getState() %>"/><br><br>
								
								<label for="email">Ciudad: </label>
							    <input id="txtCity" class="good_input" name="txtCity" type="text"  value="<%= clientInfo.getAddress().getCity() %>"/><br><br>
								<label for="email">Municipio:</label>
							    <input id="txtMunicipality" class="good_input" name="txtMunicipality" type="text"  value="<%= clientInfo.getAddress().getMunicipality() %>"/><br><br>
								<label for="email">Urbanizacion:</label>
							    <input id="txtUrbanization" class="good_input" name="txtUrbanization" type="text"  value="<%= clientInfo.getAddress().getUrbanization() %>"/><br><br>
								<label for="email">Calle:</label>
							    <input id="txtStreet" class="good_input" name="txtStreet" type="text"  value="<%= clientInfo.getAddress().getStreet() %>"/><br><br>
							    <label for="email">Nombre Propiedad:</label>
							    <input id="txtPropetyName" class="good_input" name="txtPropetyName" type="text"  value="<%= clientInfo.getAddress().getPropertyName() %>"/>
								 <br><br>
							    <%
							    	if (clientInfo.getAddress().getPropertyTypeId() == 1 || clientInfo.getAddress().getPropertyTypeId() == 3 
							    	||  clientInfo.getAddress().getPropertyTypeId() == 5 )
							    	{
							    
							    %>
								 <label for="email">Torre:</label>
								    <input id="txtTower" class="good_input" name="txtTower" type="text"  value="<%= clientInfo.getAddress().getTower() %>"/><br><br>
								    <span id="txtFloorLabel" >Piso:</span>
								    <input id="txtFloor" class="good_input" name="txtFloor" type="text" size="5" value="<%= clientInfo.getAddress().getFloor() %>"/>
								    <span id="txtAPLabel">Apartamento:</span>
								    <input id="txtApartment" class="good_input" name="txtApartment" type="text" size="5"  value="<%= clientInfo.getAddress().getApartment() %>"/>
									<br>
								<%
						    		}
						    
						   		 %>
							</fieldset>	
								
							</div>
							</div>
							<div style="text-align:center">
								<input type="submit"  class="buttonModif"  name="sbmtButton" value="Modificar" style="margin-left:20px;" />
							</div>	
					</form>      
					</div>	
        			<%
					}else{
					%>	
					<a href="#null" onclick="printPageContent('print_div2')" style="position: absolute; left: 800px; top: 200px;"> 
						<img alt="logo" src="/segaDental/images/print.png" height="20" width="20" style="padding-right:5px;"/> 
						<span style="font-weight: bold; color:#00668c; ">Imprimir </span>
					</a>
					<DIV id="print_div2">	<br>
					 <form name="form" class="formClient" action="/segaDental/EditClientServlet" onsubmit="return validateBenef(this)" method="post">
							<input type="hidden" name="txtClientId" value="<%= request.getParameter("clientId") %>" />
							<input type="hidden" name="type" value="<%= request.getParameter("type") %>" />
					
						<fieldset>
								<label for="name">Nombres:</label>
								<input type="text" name="txtName" id="txtName" maxlength="50" size="40" value="<%= clientInfo.getFirstName() %>" /> <br><br>
								<label for="LastName">Apellidos:</label>
								<input type="text" name="txtLastName" id="txtLastName" maxlength="50" size="40" value="<%= clientInfo.getLastName() %>" /> <br><br>
								<label for="cedId">C&eacute;dula de identidad:</label>
								<%
								String identityCard = clientInfo.getIdentityCard();
								String identityCardId = identityCard.substring(0, 2);
								String identityCardNum = identityCard.substring(2);
								%>
								<select name="txtCedId" id="txtCedId">
								<%
								if(identityCardId.equalsIgnoreCase("V-")){
								%>
									<option value="V-" selected="selected">V</option>
									<option value="E-">E</option>
								<%	
								} else {
								%>	
									<option value="V-">V</option>
									<option value="E-" selected="selected">E</option>
								<%
								}
								%>
								</select>
								<input type="text" name="txtCedIdNum" id="txtCedIdNum" maxlength="50" size="18" value="<%= identityCardNum %>" /> <br><br>
								<label for="date">Fecha de Nacimiento:</label>
								<input  type="text" name="txtDateIni" id="txtDateIni" maxlength="50" size="10" value="<%= clientInfo.getBirthday() %>" />
								<span id="txtGenLabel"> Sexo: </span>
								<select name="txtGen" id="txtGen">
									<%	
									if (clientInfo.getSex().equalsIgnoreCase("f")){
									%>	
										<option value="F" selected="selected">Femenino</option>
										<option value="M">Masculino</option>
									<%	
									} else {
									%>	
									<option value="F">Femenino</option>
									<option value="M" selected="selected">Masculino</option>
									<%
									}
									%>
								</select><br><br>
								<label for="email">Correo Electr�nico:</label>
								<input type="text" name="txtEmail" id="txtEmail" maxlength="50" size="40" value="<%= clientInfo.getEmail() %>" /> 
							</fieldset>
							<div style="text-align:center">
								<input type="submit"  class="button"  name="sbmtButton" value="Modificar" style="margin-left:20px;" />
							</div>	
					</form>      
					</div>	
        			<%	
					}
					%>	
		    <div id="footer"></div>
		</div>
	</div>
	
	
	
</body>
</html>