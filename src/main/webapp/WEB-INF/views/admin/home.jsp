<!-- JSP 및 태그라이브러리 설정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal"/>
<html ng-app="myApp">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- 스프링 시큐리티의 CSRF 토큰을 AJAX에서 사용 -->
		<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
		<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

		<title>스프링 부트 웹 애플리케이션</title>

		<!--Import Google Icon Font-->
		<link href="http://fonts.googleapis.com/icon?family=Material+Icons"	rel="stylesheet">
		<!-- Compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css">
		<link rel="stylesheet"  href="${pageContext.request.contextPath}/assets/css/tether.min.css">
		<link rel="stylesheet" href="/assets/css/style.css">
	</head>
	<body id="AdminController" ng-controller="AdminController" ng-cloak>
	<!-- 헤더 영역 -->
		<header>
						 <nav>
			    <div class="nav-wrapper blue lighten-1">
					<a class="brand-logo right waves-effect waves-light button-collapse hide-on-large-only blue lighten-1" data-activates="nav-mobile"><i class="material-icons">menu</i></a>
			      <ul class="list-none-style left">
			      <!-- 인증된 사용자의 메뉴 영역 -->
					<sec:authorize access="isAuthenticated()">
					    <li><a href="#">IT STACKS - 신입 개발자를 위한 질문 서비스</a></li>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						 <li><a href="/login">IT STACKS를 이용하기 위해서는 로그인 하셔야 합니다.</a></li>
					</sec:authorize>
			      </ul>
			    </div>
			  </nav>
			  
			  <ul id="nav-mobile" class="side-nav fixed tabs-transparent">
    <li><div class="userView center">
      <div class="background blue lighten-1">
      </div>
      <sec:authorize access="isAnonymous()">
      	  <a href="#"><img class="circle" src="/assets/img/user-star.png" style="margin:0 auto;"></a>
	      <a href="${pageContext.request.contextPath}/login"><span class="white-text name">로그인</span></a><br>
	  </sec:authorize>
      <sec:authorize access="isAuthenticated()">
      	  <a><img class="circle" src="${user.thumbnail}" style="margin:0 auto;"></a>
	      <a><span class="white-text name">${user.nickname}</span></a>
	      <form name="logoutform" action="/logout"	method="post">
    		<input type="hidden"  name="${_csrf.parameterName}"	value="${_csrf.token}"/>
    	  </form>
	      <a href="#" onclick="logoutform.submit();"><span class="white-text email">로그아웃</span></a>
      </sec:authorize>
    </div></li>
    <li><a href="/"><i class="material-icons">home</i>홈</a></li>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    <li><a href="/admin" class="waves-effect"><i class="material-icons">settings</i>관리페이지</a></li>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    <li><a href="/user/${user.id}" class="waves-effect"><i class="material-icons">account_box</i>회원정보수정</a></li>
    <li><a href="/board/scrap" class="waves-effect"><i class="material-icons">share</i>스크랩</a></li>
    <li><a href="/board" class="waves-effect"><i class="material-icons">create</i>글쓰기</a></li>
    </sec:authorize>
    <li><div class="divider"></div></li>
    <li><a class="subheader">게시판</a></li>
    <!-- 게시판 카테고리 영역  -->
    <li><a href="/board/category/QA" class="waves-effect"><i class="material-icons">folder</i>QA</a></li>
    <li><a href="/board/category/신입공채" class="waves-effect"><i class="material-icons">folder</i>신입공채</a></li>
    <!--  -->
    <li><div class="divider"></div></li>
    <li><a class="subheader" class="waves-effect">IT 관련 사이트</a></li>
    <li><a href="http://stackoverflow.com/" target="_blank" class="waves-effect"><i class="material-icons">link</i>스택 오버플로우</a></li>
    <li><a href="http://okky.kr/" target="_blank" class="waves-effect"><i class="material-icons">link</i>OKKY</a></li>
    <li><a class="subheader">개발 기록</a></li>
    <li><a href="http://kdevkr.tistory.com/" target="_blank" class="waves-effect"><i class="material-icons">room</i>개발자 블로그</a></li>
</ul>
		</header>
		<!-- 아티클 영역 -->
		<article>
			<div class="container-fluid">
				<!-- 게시물 페이지네이션 영역 -->
				<div class="row center-align">
				<h3 style="margin-top:50px;"></h3>
				<blockquote>
					<div class="col s12 m6 l3">
						<span class="chip green lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">전체 사용자수
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${userCount}명</span>
						</span>
					</div>
					<div class="col s12 m6 l3">
						<span class="chip blue lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">페이스북 사용자
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${facebookUser}명</span>
						</span>
					</div>
					<div class="col s12 m6 l3">
						<span class="chip orange lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">카카오톡 사용자
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${kakaoUser}명</span>
						</span>
					</div>
					<div class="col s12 m6 l3">
						<span class="chip purple lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">제재 사용자
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${restrictCount}명</span>
						</span>
					</div>
					<div class="col s12 m6 l3">
						<span class="chip pink lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">전체 게시물수
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${boardCount}개</span>
						</span>
					</div>
					<div class="col s12 m6 l3">
						<span class="chip teal lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">현재 세션수
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${currentSessionCount}명</span>
						</span>
					</div>
					<div class="col s12 m6">
						<span class="chip red lighten-2 hover white-text" style="border-radius:0; padding-right:0; width:100%;">시스템 메모리
							<span class="chip grey darken-2 hover white-text right" style="border-radius:0; margin-right:0;">${systemMemory}MB</span>
						</span>
					</div>
				</blockquote>
				</div>
				
				<!-- 게시물 영역 -->
				<div class="row">
				<div class="col s12 m6">
					<div class="collection">
						<div class="collection-item">
							<div class="row">
								<div class="col s6">
								회원 소셜 타입
									<select id="provider" class="browser-default form-control">
								      <option value="" disabled selected>소셜 구분을 선택해주세요</option>
								      <option value="Kakao">Kakao</option>
								      <option value="Facebook">Facebook</option>
								    </select>
								</div>
								
								<div class="col s6">
									회원 번호 <input id="id" name="id" type="text" class="form-control validate"/>
								</div>
								<div class="col s12">
									제재 사유 <input id="reason" name="reason" type="text" class="form-control validate"/>
								</div>
								<div class="col s12">
									해제 일자 <input id="released" name="released" type="date" class="form-control validate"/>
								</div>
								
								<div class="col s12 right-align">
								<br/>
									<a class="waves-effect waves-light btn red white-text" data-ng-click="insertRestrict()">등록하기</a>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div class="col s12 m6">
					<div class="collection">
						<div class="collection-item">
							<b>제재된 리스트 {{totalRestrictList}}개</b>
						</div>
							<div class="collection-item">
							<p dir-paginate="x in search_contents = (restrictList) | itemsPerPage:pagesize" pagination-id="restrictpage" total-items="totalRestrictList">
								{{x.provider}} - {{x.userid}} : {{x.reason}} - {{x.released | date:'yyyy년 MM월 dd일'}}까지 <a href="#" data-ng-click="cancelRestriction(x.provider, x.userid, $index)">해제</a>
							</p>
						</div>
					<div class="center-align">
						<dir-pagination-controls
						    max-size="5"
						    template-url="/assets/html/dirPagination.tpl.html"
						    direction-links="true"
	   						boundary-links="true"
						    pagination-id="restrictpage"
						    on-page-change=""
						    >
						</dir-pagination-controls>
						</div>
					</div>
					</div>
				</div>
			</div>		
			<!-- 인증된 사용자의 메뉴 영역 -->
			<sec:authorize access="isAuthenticated()">
				<div class="fixed-action-btn click-to-toggle">
					<a class="btn-floating btn-large red">
						<i class="material-icons">menu</i>
					</a>
					<ul>
					    <li><a class="btn-floating btn-large red button-collapse hide-on-large-only waves-effect waves-light" data-activates="nav-mobile"><i class="material-icons">web</i>
					</a></li>
						<li><a class="btn-floating blue btn-large waves-effect waves-light" href="/board/"><i class="material-icons">add</i></a></li>
					</ul>
				</div>
			</sec:authorize>
		</article>
		
		<!-- 푸터 영역 -->
		<footer class="page-footer white">
			<div class="footer-copyright">
				<div class="container center black-text">
					Bootstrap 4 & Materialize
				</div>
			</div>
		</footer>

		<!-- Compiled and minified JavaScript -->
		<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
		
		<script	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular.min.js"></script>
		<script	src="https://code.angularjs.org/1.5.7/angular-sanitize.js"></script>
		<script	src="/assets/js/dirPagination.js"></script>
		<script src="/assets/js/app.js"></script>
		<script type="text/javascript">
			$(".button-collapse").sideNav();
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(function() {			
				$(document).ajaxSend(function(e, xhr, options) {
					xhr.setRequestHeader(header, token);
				});
			});
		</script>
	</body>
</html>
