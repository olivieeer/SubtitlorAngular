<%@ include file="/WEB-INF/taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<!--[if lt IE 9]>
	        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	 <![endif]-->
	<title>Editer les sous-titres</title>
</head>
<body>
<jsp:include page="/css/styleBleu.css"/>
<header>
	<H2 align="center" style="text-align : center;">Traduction de fichier de sous titre</H2>
</header>
<nav class="navRetrieve">
	<%@ include file="menu.jsp" %>
</nav>
<section>
	<fieldset class="fieldsetDisplaySubtitle">
		<legend><strong>&nbsp;&nbsp;Continuer une traduction&nbsp;&nbsp;</strong></legend>
			<c:if test="${ !empty erreur}" >
				<c:out value="${ erreur}" />
			</c:if>
		     <c:choose>
				<c:when test="${!empty errorDB }"><H3 class="errorDB"><c:out value="${ errorDB }" /></H3></c:when>
				<c:when test="${!empty erreurPasTradFinies }"><H3><c:out value="${ erreurPasTradFinies }" /></H3></c:when>				    
	  			<c:when test="${!empty erreurDisplay }"><P class="echec"><c:out value="${ erreurDisplay }" /></P></c:when>
	  			<c:otherwise></c:otherwise>
			</c:choose>
			<form method="post" name="form" id="form" action="recordSubtitle">
			<div id="listFichier">
				<ul> 
					<c:forEach items="${ listFiles }" var="line" varStatus="status">
						<c:if test="${line.isTranslationFinished()}">
							<li><div class="btnEnligne"><P><c:out value="${line.myString()}"/>&nbsp;&nbsp;<span>Traduction finie&nbsp;&nbsp;</span><a class="btnContinuer" href="displaySubtitleFile?name=${line.myString()}&amp;finished=${line.isTranslationFinished()}">Modifier</a>&nbsp;&nbsp;<a class="btnExporter" href="exporterFile?name=${line.myString()}&amp;finished=${line.isTranslationFinished()}">Exporter</a></P></div></li>
						</c:if>
						<c:if test="${!line.isTranslationFinished()}">
							<li><div class="btnEnligne"><P><c:out value="${line.myString()}"/>&nbsp;&nbsp;<span>Traduction partielle&nbsp;&nbsp;</span><a class="btnContinuer" href="displaySubtitleFile?name=${line.myString()}&amp;finished=${line.isTranslationFinished()}">Modifier</a>&nbsp;&nbsp;</P></div></li>
						</c:if>
					</c:forEach>
				 </ul>
			</div>
	  		</form>
	  		<P></P>
	  		<P></P>
	</fieldset>
</section>
</body>
</html>