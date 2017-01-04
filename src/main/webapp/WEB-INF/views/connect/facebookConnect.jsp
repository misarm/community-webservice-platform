<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Facebook Account</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/access_confirmation_v2.css">
</head>
<body>
<header class="title">
      <h1 style="background-color: #3b5998; color:#fff;">페이스북계정 로그인</h1>
    </header>
    <section>
      <div class="info_app"><img src="https://mud-kage.kakao.com/14/dn/btqbjCnoZ8A/MyiKigHpJbSKusX0u3TPL1/o.jpg" alt="app">
        <div class="info">
          <h2>페이스북 계정 연동 예제</h2>
          <ul>
            <li>로컬호스트</li>
          </ul>
        </div>
      </div>
      <form action="${pageContext.request.contextPath}/connect/facebook" method="POST">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="scope" value="" />
				<section class="main_section privacy">
          <header>
            <h3>개인정보 제3자 제공 동의</h3>
            <p>페이스북으로부터 개인정보를 수집하는데 동의 하시겠습니까?</p>
          </header>
          <ul class="info_box">
            <li>
              <dl>
                <dt>제공받는 자</dt>
                <dd>로컬호스트</dd>
              </dl>
            </li>
            <li>
              <dl>
                <dt>제공받는 목적</dt>
                <dd>페이스북계정 연결을 통한 개인정보 연동 서비스 제공을 위해</dd>
              </dl>
            </li>
            <li>
              <dl>
                <dt>보유기간</dt>
                <dd>서비스 탈퇴시 지체없이 파기</dd>
              </dl>
            </li>
          </ul>
          <article class="approval">
            <header>
              <h4>제공되는 개인정보 항목</h4>
              <p>선택 정보는 동의를 거부하시는 경우에도 서비스 이용이 가능합니다.</p>
            </header>
            <ul>
              <li class="required">
                <div class="info"><span><em>[필수]</em>프로필 정보(닉네임/프로필 사진)</span>
                </div>
              </li>
            </ul>
          </article>
        </section>
        <div class="actions btn_split">
        <button id="denyButton" type="button" name="user_oauth_approval" onclick="location.href='${pageContext.request.contextPath}/login'" class="btn btn_noagree">동의안함
          </button>
        <button id="acceptButton" type="submit" name="user_oauth_approval" value="true" class="btn btn_agree facebook">동의
          </button>
        </div>
      </form>
    </section>
</body>
</html>