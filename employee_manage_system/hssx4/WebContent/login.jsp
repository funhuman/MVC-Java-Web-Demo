<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <title>Login</title>
  </head>
  <body>
    <section class="material-half-bg">
      <div class="cover"></div>
    </section>
    <section class="login-content">
      <div class="logo">
        <h1 style="margin-top: -80px; letter-spacing:20px;">员工管理系统</h1>
      </div>
      <div class="login-box">
        <div class="login-form">
          <h3 class="login-head" style="letter-spacing: 3.2px;"><i class="fa fa-lg fa-fw fa-user"></i>WELCOME</h3>
          <div class="form-group">
            <label class="control-label">USERNAME</label>
            <input class="form-control" type="text" name="username" id="username" placeholder="Username" autofocus>
          </div>
          <div class="form-group">
            <label class="control-label">PASSWORD</label>
            <input class="form-control" type="password" name="password" id="password" placeholder="Password">
          </div>
          <div class="form-group">
            <div class="utility">
              <div class="animated-checkbox">
                <label>
                  <input type="hidden"><span class="label-text"></span><!-- Stay Signed in checkbox Forgot Password ?-->
                </label>
              </div>
              <p class="semibold-text mb-2"><a href="#" data-toggle="flip" onclick="javascript:window.location.href='index'">Register</a></p>
            </div>
          </div>
          <div class="form-group btn-container"> <!-- style="margin: 14% 0;" -->
            <button class="btn btn-primary btn-block" onClick="checkInfo()">
            	<i class="fa fa-sign-in fa-lg fa-fw"></i>SIGN IN
            </button>
          </div>
        </div>
        <!-- <form class="forget-form">
          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-lock"></i>Forgot Password ?</h3>
          <div class="form-group">
            <label class="control-label">EMAIL</label>
            <input class="form-control" type="text" placeholder="Email">
          </div>
          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block"><i class="fa fa-unlock fa-lg fa-fw"></i>RESET</button>
          </div>
          <div class="form-group mt-3">
            <p class="semibold-text mb-0"><a href="#" data-toggle="flip"><i class="fa fa-angle-left fa-fw"></i> Back to Login</a></p>
          </div>
        </form> -->
      </div>
    </section>
    <!-- Essential javascripts for application to work-->
    <script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="js/plugins/pace.min.js"></script>
	<script type="text/javascript">
		// 登录前端函数
		function checkInfo() {
			// 获取对应元素的值
			var username=$("#username").val();
			var password=$("#password").val();
			// 简单判断
			if (isEmpty(username) || isEmpty(password)) {
				alert("输入不能为空");
				return;
			}
			// 调用ajax判断是否登录成功
			$.ajax({
				type: "post", // 方法类型
				url: "loginCheck", // url
				dataType: "text", // 数据类型 string json xml
				async: true, // 是否异步
				data: {"username": username, "password": password},
				// 回调方法
				success: function(data) {
					if (data=="ok") {
						// alert("登录成功");
						window.location.href="index"; // 跳转至主页
					} else {
						alert("登录信息错误");
					}
				},
				error: function() {
					alert("异常请求！");
				}
			});
		}
		// 判空函数
		// https://blog.csdn.net/qq_36150631/article/details/94553703
		function isEmpty(v) {
		    switch (typeof v) {
		    case 'undefined':
		        return true;
		    case 'string':
		        if (v.replace(/(^[ \t\n\r]*)|([ \t\n\r]*$)/g, '').length == 0) return true;
		        break;
		    case 'boolean':
		        if (!v) return true;
		        break;
		    case 'number':
		        if (0 === v || isNaN(v)) return true;
		        break;
		    case 'object':
		        if (null === v || v.length === 0) return true;
		        for (var i in v) {
		            return false;
		        }
		        return true;
		    }
		    return false;
		}
	</script>
  </body>
</html>