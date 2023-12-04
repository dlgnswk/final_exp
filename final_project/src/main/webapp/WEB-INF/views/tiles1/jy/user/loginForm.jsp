<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>Expedia 로그인/회원가입</title>

<body>
	<div id="container" style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">
		<div class="login_section">
			<div><h2>로그인 및 회원가입</h2></div>
			<div>
				<label for="userid">이메일</label>
				<input type="text" class="input_userid" name="userid" />
				<input type="hidden" name="email" />				
			</div>
			<div>
				<input type="password" class="input_pw" name="pw" />			
			</div>
		</div>
	</div>
</body>
</html>