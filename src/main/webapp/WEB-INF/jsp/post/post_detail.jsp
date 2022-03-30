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
	// 삭제 버튼 클릭
	$('#postDeleteBtn').on('click', function() {
		let postId = $(this).data('post-id');
		
		$.ajax({
			type: "delete"
			, url: "/post/delete"
			, data: {"postId" : postId}
			, success: function(data) {
				if (data.result == "success") {
					alert("삭제되었습니다.");
					location.href = "/post/post_list_view";
				} else {
					alert(data.error_message);
				}
			}
			, error : function(e) {
				alert("메모를 삭제하는데 실패 했습니다.");
			}
		});
	});
	
	// 목록 버튼 클릭
	$('postListBtn').on('click', function() {
		location.href = "/post/post_list_view";
	});
	
	// 글 내용 저장
	$('#saveBtn').on('click', function() {
		let subject = $('input[name=subject]').val().trim();
		let content = $('textarea[name=content]').val().trim();
		
		if (subject = '') {
			alert("제목을 입력 해 주세요.");
			return;
		}
		if (content = '') {
			alert("내용을 입력 해 주세요.");
			return;
		}
		
		// 파일이 업로드 된 경우 확장자 체크
		let filePath = $('input[name=file]').val();
		if (filePath != '') {
			let ext = filePath.split('.').pop().toLowerCase();
			if ($.inArray(ext, ['gif','jpeg','jpg','png']) == -1) {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$('input[name=file]').val('');
				return;
			}
		}
		
		let formData = new FormData();
		let postId = $(this).data('post-id');
		formData.appent("postId", postId);
		formData.appent("subject", subject);
		formData.appent("content", content);
		formData.appent("file", $('input[name=file]')[0.files[0]]);	// 파일을 통째로 가져오는 문법
		
		$.ajax({
			type:"put"
			, url: "/post/update"
			, data: formData
			, enctype: "multipart/form-data"
			, processData: false
			, contentType: false
			, success: function(data) {
				if (data.reselt = "success") {
					alert("수정이 완료 되었습니다.");
					location.reload(true);
				} else {
					alert(data.error_message);
				}
			}
			, error: function(e) {
				alert("메모 수정에 실패 했습니다. 관리자에게 문의 해 주세요.");
			}
		});
	});
});
</script>