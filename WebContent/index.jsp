<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>教务系统成绩查询</title>
<link href="css/bootstrap.css" rel="stylesheet" />
<link href="css/style.css" rel="stylesheet" />
<link href="css/bootstrapValidator.css" rel="stylesheet" />
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<div id="main">
		<div class="container">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="page-header">
						<h3 class="text-center">
							教务系统成绩查询 <small>v1.0.0</small>
						</h3>
					</div>
					<div class="panel-body">
						<form id="login" role="form" action="results.do" method="POST">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<span class="glyphicon glyphicon-user"></span>
									</div>
									<input class="form-control" type="text" id="username"
										name="username" placeholder="用户名" />
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon">
										<span class="glyphicon glyphicon-lock"></span>
									</div>
									<input class="form-control" type="password" id="password"
										name="password" placeholder="密码" />
								</div>
							</div>
							<div style="float: left">
								<a href="res/JwxtQuery.apk" target="_blank"><img
									src="images/Android.png" height="36px" width="36px" />Android版下载</a>
							</div>
							<input type="submit" class="btn btn-primary" style="float: right"
								value="查询" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrapValidator.js"></script>
	<script src="js/language/zh_CN.js"></script>
	<script>
		$(function() {
			$("#username").bind(
					'input propertychange',
					function() {
						if ($("#password").val() != null
								&& $("#password").val() != "") {
							$("#login").bootstrapValidator('revalidateField',
									'password');
						}

					});
			$('#login').bootstrapValidator(
					{
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh'
						},
						fields : {
							username : {
								validators : {
									notEmpty : {

									},
									stringLength : {
										min : 10,
										max : 10,
										message : '学号长度为10位'
									},
									digits : {}
								}
							},
							password : {
								validators : {
									notEmpty : {},
									threshold : 3,
									remote : {
										url : 'login.do',
										message : '无法登陆教务系统，可能是用户名或密码错误',
										delay : 1000,
										type : 'POST',
										data : function(validator) {
											return {
												username : $(
														'[name="username"]')
														.val(),
												password : $(
														'[name="password"]')
														.val()
											};
										}
									}
								}
							},
						}
					});
		});
	</script>
</body>
</html>