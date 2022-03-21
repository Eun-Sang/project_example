<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<script>
$(document).ready(function() {
	$('#loginForm').on('submit', function(e) {
		e.preventDefault();	//submit 수행 중단
		
		let loginId = $('#loginId').val().trim();
		// validation
		if (loginId == '') {
			alert("아이디를 입력 해 주세요.");
			return false;
		}
		
		let password = $('#password').val();
		if (password == '') {
			alert("비밀번호를 입력 해 주세요.");
			return false;
		}
		// submit 대신 ajax
		
		let url = $(this).attr('action');
		let params = $(this).serialize();
		
		// 검증하기
		//console.log("url:" + url);
		//console.log("params:" + params);
		
		$.post(url.params)
		.done(function(data) {
			if (data.result == "success") {
				// 로그인 성공
				location.href = "/post/post_list_view";
			} else {
				alert(data.error_message);
			}
		});
	});
});

</script>