<%@ include file="/WEB-INF/taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<!--[if lt IE 9]>
	        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	 <![endif]-->
	 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-7s5uDGW3AHqw6xtJmNNtr+OBRJUlgkNJEo78P4b0yRw= sha512-nNo+yCHEyn0smMxSswnf/OnX6/KwJuZTlNZBjauKhTK0c+zT+q5JOCx0UFhXQ6rJR9jg6Es8gPuD2uZcYDLqSw==" crossorigin="anonymous">
	<title>Editer les sous-titres</title>
</head>
<body>
<jsp:include page="/css/styleBleu.css"/>
<header>
	<H2 class="text-center">Traduction de fichier de sous titre</H2>
</header>
<nav class="navEdit">
	<%@ include file="menu.jsp" %>
</nav>
	<section>
		<fieldset class="fieldsetEdit">
			<legend><strong>&nbsp;&nbsp;Traduire un fichier&nbsp;&nbsp;</strong></legend>
			<form method="post" name="form" id="form" action="recordSubtitle">
				<input type="submit" class="inputButtonFixedRight" style="top: 30%;" value="Sauvegarder" />
				<H3>Traduction pour le fichier <strong><span style="color : black;"><c:out value="${ sessionScope.nomFichier }" /></span></strong></H3>
				<br />
				<table  id="tabEdit">
			   		<tr>
			  			<th class="text-center">Fichier 1 a traduire</th>
			  			<th class="text-center">Fichier 2 traduit</th>
					</tr>
			     		<c:forEach items="${ subtitles }" var="line" varStatus="status">
			   		<tr>
				   		<c:choose>
							<c:when test="${line.isVide() == false }"><td style="text-align:center;"><c:out value="${ line.myString() }" /></td></c:when>					    
				  			<c:when test="${line.isVide() == true }"></c:when>
				  			<c:otherwise></c:otherwise>
						</c:choose>
				   		 <c:choose>
				    		<c:when test="${line.isVide() == true }"></c:when>
							<c:when test="${line.isNumeric() == true }"><td  style="text-align:center;" name="line${ status.index }" id="line${ status.index }"><c:out value="${ line.myString() }" /></td></c:when>					    
				  			<c:when test="${line.isTimeValues() == true }"><td style="text-align:center;" name="line${ status.index }" id="line${ status.index }"><c:out value="${ line.myString() }" /></td></c:when>
				  			<c:when test="${line.isNotTranslated() == true }"><td><input type="text" name="line${ status.index }" id="line${ status.index }" class="vide" /></td></c:when>
				  			<c:when test="${line.isStringTraduction() == true }"><td><input type="text" name="line${ status.index }" id="line${ status.index }" class="vide" /></td></c:when>						    
				  			<c:otherwise></c:otherwise>
						</c:choose>
			   		</tr>
				</c:forEach>
			  </table>
		  </form>
		</fieldset>
	</section>
</body>
</html>