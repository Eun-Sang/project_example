<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<div class="d-flex justify-content-between">
	<div class="logo">
		<div class="font-weight-bold">메모 게시판</div>
	</div>
	<div class="login-info">
		<c:if test="${not empty userName}">
		<div>
			<span class="text-white">${userName}님 안녕하세요</span>
			<a href="/user/sign_out" class="text-white font-weight-blod">로그아웃</a>
		</div>
		</c:if>
	</div>
</div>