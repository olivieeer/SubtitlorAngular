<%@ include file="/WEB-INF/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!--[if lt IE 9]>
     <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
     <![endif]-->
<!-- <link type="text/css" rel="stylesheet" href="css/styleBleu.css" /> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
<!-- jQuery est inclus ! -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha256-7s5uDGW3AHqw6xtJmNNtr+OBRJUlgkNJEo78P4b0yRw= sha512-nNo+yCHEyn0smMxSswnf/OnX6/KwJuZTlNZBjauKhTK0c+zT+q5JOCx0UFhXQ6rJR9jg6Es8gPuD2uZcYDLqSw=="
	crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js" async></script>
	<link rel="preconnect" href="https://fonts.typonine.com/" crossorigin>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular.min.js"></script>

<title>Editer les sous-titres</title>
</head>
<body ng-app="myapp">
	<jsp:include page="/css/styleBleu.css" />

	<header>
		<H2>Traduction de fichier de sous titre</H2>
	</header>
	<div ng-app="">
		<section id="container-fluid">

			<div class="row" >
				<div class="col-md-12 col-lg-12">
					<div class="col-md-3 col-lg-3 text-center">
						<nav>
							<%@ include file="/WEB-INF/menu.jsp"%>
						</nav>
					</div>
					<div class="col-md-7 col-lg-7">
						
						<fieldset>
							<legend>
								<strong>Choisir un fichier &nbsp;</strong>
							</legend> 
							<div id="idDisparaitre">
							      <div ng-controller = "myCtrl">
							      	
								<form method="post" action="upload" 
									enctype="multipart/form-data">
									<div class="form-group">
										<label for="description" class="control-label">Description
											du fichier de sous titre à traduire : </label> <input type="text"
											name="description" id="description" class="form-control"
											placeholder="Entrer une description" ng-model="description" />
									</div>
									<h2>{{description}}</h2>
									<div class="form-group">
										<label for="fichier" class="control-label">Fichier à
											envoyer : </label>
										<c:choose>
											<c:when test="${ !empty errorFileUpload }">
												<input type="file"
													style="color: #6D7B8D; font-weight: bold; font-size: 1em;"
													name="fileName" id="fichier" ng-model="fichier" />
											</c:when>
											<c:otherwise>
												<input type="file" name="fileName" style="font-size: 1em;"
													class="inputSubmitBtn" ng-model="fichier" />
											</c:otherwise>
										</c:choose>
									</div>
									<h2>{{fichier}}</h2>
									<div class="text-center">
										<button type="submit" class="btn btn-lg btn-primary">Uploader
											le fichier</button>
									</div>
									<input type = "text" ng-model = "description1" id="description1"/>
						         	<input type = "file" file-model = "myFile"/>
						         	<button ng-click = "uploadFile()">upload me</button>
						      	</div>
								</form>
							</div>
							<br /> <br />
							<div class="text-center" border="1">
								<c:choose>
									<c:when test="${!empty errorFileUpload }">
										<H3 class="errorFileUpload">
											<c:out value="${ errorFileUpload }" />
										</H3>
									</c:when>
									<c:when test="${ !empty erreurPasDeRecord }">
										<p style="width: 50%" class="echec">
											<c:out value="il n'y a pas d\'enregistrement en base données" />
										</p>
									</c:when>
									<c:when test="${ !empty pasEncoreImplémenté }">
										<p style="width: 50%" class="echec">
											<c:out value="ce développement n\'est pas encore implémenté" />
										</p>
									</c:when>
									<c:when test="${ !empty erreurPasDeFichierUploade }">
										<p style="width: 50%" class="echec">
											<c:out value="Aucun fichier ne sont disponible à l\'export" />
										</p>
									</c:when>
									<c:when test="${ !empty erreur }">
										<p style="width: 50%" class="echec">
											<c:out value="${ erreur }" />
										</p>
									</c:when>
									<c:when test="${ !empty erreurPasFichierSrt }">
										<p style="width: 50%" class="echec">
											<c:out
												value="le fichier ${ fichier }  n'est pas de type .srt" />
										</p>
									</c:when>
									<c:when test="${ !empty erreurPasDeFichierSelectionne }">
										<p style="width: 50%" class="echec">
											<c:out value="Vous n'avez pas selectionné de fichier" />
										</p>
									</c:when>
									<c:when test="${ !empty succesUpload }">
										<P style="width: 60%" class="succes">
											<c:out value="Le fichier de sous titre  " />
											<span style="color: black;"><c:out
													value="${ nomFichier }    ${ description } " /></span>
											<c:out value=" a été uploadé !" />
										</P>
									</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
								<br /> <br />
								<c:if test="${ empty disparaitreBouttonEditer }">
									<form method="get" action="edit" enctype="multipart/form-data">
										<div class="text-center">
											<button type="submit" class="btn btn-lg btn-primary">Editer
												le fichier</button>
										</div>
									</form>
								</c:if>
							</div>
							<br />
						</fieldset>
					</div>
					<div class="col-md-2 col-lg-2">&nbsp;</div>
				</div>
			</div>
		</section>
	</div>
<script>
var myapp = angular.module('myapp', []);

myapp.directive('fileModel', ['$parse', function ($parse) {
   return {
      restrict: 'A',
      link: function(scope, element, attrs) {
         var model = $parse(attrs.fileModel);
         var modelSetter = model.assign;
         
         element.bind('change', function(){
            scope.$apply(function(){
               modelSetter(scope, element[0].files[0]);
            });
         });
      }
   };
}]);

myapp.service('fileUpload', ['$http', function ($http) {
   this.uploadFileToUrl = function(file, uploadUrl){
      var fd = new FormData();
      fd.append('file', file);
   
      $http.post(uploadUrl, fd, {
         transformRequest: angular.identity,
         headers: {'Content-Type': undefined}
      })
     	
      .success(function(){
      })
   
      .error(function(){
      });
   }
}]);

myapp.controller('myCtrl', ['$scope', 'fileUpload', function($scope, fileUpload){
   $scope.uploadFile = function(){
      var file = $scope.myFile;
      var description = $scope.description1;
      console.log('file is ' );
      console.dir(file);
      
      var uploadUrl = "/Subtitlor/edit";
      fileUpload.uploadFileToUrl(file, uploadUrl);
   };
}]);

</script>
</body>
</html>