<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<div class="sign-up-box">
	<form id="signUpForm" method="post" action="/user/sign_up">
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>비밀번호</th>
					<th>비밀번호 확인</th>
					<th>이름</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				
			<%-- 아이디 체크 결과 --%>
			<div id="idChecklength" class="small text-danger d-none">ID를 4자이상 입력하세요</div>
			<div id="idCheckduplicated" class="small text-danger d-none">이미 사용 중인 ID 입니다.</div>
			<div id="idCheckdOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</tbody>
			
		</table>
	</form>
	</div>
</div>

<script>
$(document).ready(function() {
	//아이디 중복확인
	$('#loginCheckBtn').on('click', function() {
		let loginId = $('#loginId').val().trim();
		
		// 경고문구 초기화
		$('#idChecklength').addclass('d-none');
		$('#idCheckduplicated').addclass('d-none');
		$('#idCheckdOk').addclass('d-none');
		
		
		if (loginId.length < 4) { 
			$('#idChecklength').removeClass('d-none');
			return;
		}
		
		$.ajax({
			url: "/user/is_duplicated_id"
			, data: {"loginId": loginId}
			, success: function(data) {
				if (data.result) {	// 중복인 경우
					$('#idCheckduplicated').removeclass('d-none');
				} else {	// 사용가능한 아이디
					$('#idCheckdOk').removeclass('d-none');
				}
			}
			, error: function(e) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의하세요");
			}
		});
	});
	
	// 회원가입
	$('#signUpBtn').on('click', function() {
		let loginId = $('#loginId').val().trim();
		if (loginId == '') {
			alert("아이디를 입력해주세요");
			return;
		}
		
		let password = $('#password').val();
		let comfirmpassword = $('#confirmpassword').val();
		if (password == '' || confirmpassword == '') {
			alert("비밀번호를 입력하세요");
			return
		}
		
		if (password != confirmpassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력 해주세요");
			
			$('#password').val('');
			$('#confirmpassword').val('');
			return;
		}
		
		let name = $('#name').val().trim();
		if (name == '') {
			alert("이름을 입력 해 주세요");
			return;
		}
		
		let email = $('#email').val().trim();
		if (email == '') {
			alert("이메일 주소를 입력 해 주세요");
			return;
		}
		
		// 아이디 중복확인 완료 되었는지 확인
		// idCheck <div> 클래스에 d-none이 없으면 사용 가능
		// idCheck에 d-none이 있으면 alert을 띄운다.
		
		if ($('#idCheckOk').hasClass('d-none')) {
			alert("아이디 중복 확인을 다시 해 주세요");
			return;
		}
		
		// 회원가입 서버 요청 (서버에 보내기)
		// 1. submit
		//$('form')[0].submit();
			
		// 2. ajax
		let url = $('#signUpForm').attr('action')	; // form에 있는 action 주소 가져오기
		let params = $('#signUpForm').serialize();	  // form 태그에 있는 값들을 한번에 보낼 수 있게 한다.
		consol.log(params);
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다! 로그인을 해주세요");
				location.href = "/user/sign_in_view";
			} else {
				alert("가입에 실패 했습니다. 다시 시도 해 주세요");
			}
		});
	});
});

</script>