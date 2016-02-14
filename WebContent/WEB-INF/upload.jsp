<%@ include file="/WEB-INF/taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<!--[if lt IE 9]>
     <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
     <![endif]-->
     <!-- <link type="text/css" rel="stylesheet" href="css/styleBleu.css" /> -->
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script> <!-- jQuery est inclus ! -->
     <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-7s5uDGW3AHqw6xtJmNNtr+OBRJUlgkNJEo78P4b0yRw= sha512-nNo+yCHEyn0smMxSswnf/OnX6/KwJuZTlNZBjauKhTK0c+zT+q5JOCx0UFhXQ6rJR9jg6Es8gPuD2uZcYDLqSw==" crossorigin="anonymous">
     <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
	<title>Editer les sous-titres</title>
</head>
<body>
<jsp:include page="/css/styleBleu.css"/>
<header>
	<H2>Traduction de fichier de sous titre</H2>
</header>
<nav class="navUpload">
<%@ include file="menu.jsp" %>
</nav>
<div ng-app="">
<section>
 	<h2>{{description}}</h2>
</p>
	<fieldset class="fieldsetUpload">
		<legend><strong>Choisir un fichier &nbsp;</strong></legend>
			<div id="idDisparaitre">
				<form method="post" action="upload" enctype="multipart/form-data">
        		<p>
	           		<label for="description">Description du fichier de sous titre à traduire : </label>
	           		<input type="text" name="description" id="description"  placeholder="Entrer une description" ng-model="description" />
	       		</p>
	       		<p>
	           		<label for="fichier">Fichier à envoyer : </label>	
		           	<c:choose>
		       	  		<c:when test="${ !empty erreur }"><input type="file" style="color:#6D7B8D; font-weight:bold; font-size: 1em;" name="fileName" id="fichier"/></c:when>
				    	<c:otherwise><input type="file" name="fileName" style="font-size: 1em;" class="inputSubmitBtn" /></c:otherwise>
					</c:choose>
				</p>      	 	
	       </div>
        	 	<input type="submit" class="btnUpload" value="Uploader le fichier"/>
        	</form>
          	<br />
          	<br />
	         <c:choose>
	        	<c:when test="${!empty errorFileUpload }"><H3 class="errorFileUpload"><c:out value="${ errorFileUpload }" /></H3></c:when>
	        	<c:when test="${ !empty erreurPasDeRecord }"><p style="width : 50%" class="echec"><c:out value="il n'y a pas d\'enregistrement en base données"/></p></c:when>
	        	<c:when test="${ !empty pasEncoreImplémenté }"><p style="width : 50%" class="echec"><c:out value="ce développement n\'est pas encore implémenté"/></p></c:when>
	        	<c:when test="${ !empty erreurPasDeFichierUploade }"><p style="width : 50%" class="echec"><c:out value="Aucun fichier ne sont disponible à l\'export"/></p></c:when>
	        	<c:when test="${ !empty erreur }"><p style="width : 50%" class="echec"><c:out value="${ erreur }"/></p></c:when>
			  	<c:when test="${ !empty erreurPasFichierSrt }"><p style="width : 50%" class="echec"><c:out value="le fichier ${ fichier }  n'est pas de type .srt"/></p></c:when>
			  	<c:when test="${ !empty erreurPasDeFichierSelectionne }"><p style="width : 50%" class="echec"><c:out value="Vous n'avez pas selectionné de fichier"/></p></c:when>
			   <c:when test="${ !empty succesUpload }"><P  style="width : 60%" class="succes"><c:out value="Le fichier de sous titre  "/><span style="color : black;"><c:out value="${ nomFichier }    ${ description } "/></span><c:out value=" a été uploadé !" /></P></c:when>
			   <c:otherwise></c:otherwise>
			</c:choose>
		   	<br />		   
		   	<br />
		   	<c:if test="${ empty disparaitreBouttonEditer }" >
		   		<form method="get" action="edit" enctype="multipart/form-data">
		  			<P><input type="submit" style="align : center;" class="btnEdit" value="Editer le fichier"/></P>
		  	   	</form>
		   	</c:if>
           <br />
     </fieldset>
 </section>
 </div>
 
</body>
</html>