<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 


<div class="subject" value="${post.subject}"></div>
<div class="content" value="${post.content}"></div>
<%-- 이미지가 있을 때만 노출하기 --%>
<c:if test="${not empty post.imagePath}">
<div class="image-area">
	<img src="${post.imagePath}" alt="업로드 이미지" width="300">
</div>
</c:if>

<script>
$(document).ready(function() {
	// 목록 버튼 클릭
	$('postListBtn').on(function() {
		location.href = "/post/post_list_view";
	});
});
</script>