<%@ include file="/WEB-INF/taglibs.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<!--[if lt IE 9]>
	        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	 <![endif]-->
	 <title>Download fichier</title>
</head>
<body>
<jsp:include page="/css/styleBleu.css"/>
	<header>
		<H2>Export du fichier de sous titre</H2>
	</header>
	<nav class="navExport">
		<%@ include file="menu.jsp" %>
	</nav>
	<fieldset class="fieldsetExport">
		<legend><strong>&nbsp;&nbsp;Export du fichier&nbsp;&nbsp;</strong></legend>
			<c:if test="${ !empty errorDb }" >
		    	<P class="echec"><c:out value="${ errorDb }" /></P>
		    </c:if>
		    <c:if test="${ !empty errorIO }" >
		    	<P class="echec"><c:out value="${ errorIO }" /></P>
		    </c:if>
		  	<form method="get" action="downloadFileServlet?fileName=${fileNameTrad}" enctype="multipart/form-data">
			   	<P><input type="submit" style="align : center;" class="btnDownload" value="Downloader le fichier ${fileNameTrad}"/></P>
			</form>
			<br />
			<br />
			<br />
	</fieldset> 
</body>
</html>