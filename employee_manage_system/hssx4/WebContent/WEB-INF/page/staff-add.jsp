<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>添加员工</title>
  <link rel="stylesheet" type="text/css" href="css/main.css">
  <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
  <style type="text/css">
  	.form-group div {
  		display: inline-block;
  	}
  	.form-group label {
  		text-align: right;
  	}
  	.form-group input {
  		margin: 8px;
  	}
  	.modal-title {
  		letter-spacing:2px;
  	}
  </style>
</head>
<body>
  <div class="modal-content">
    <div class="modal-header">
      <h4 class="modal-title" id="modal-title">注册员工</h4>
    </div>
    <div class="modal-body">
      <form id="fm1">
        <input type="hidden" id="id" name="id" value="">
        <input type="hidden" id="userid" name="userid" value="${userInfo.id}">
        <div class="form-group">
          <label class="col-sm-2 control-Label">用户名</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="username" value="">
          </div>
          <label class="col-sm-2 control-Label">密码</label>
          <div class="col-sm-3">
            <input type="password" class="form-control" id="password" value="">
          </div>
          <label class="col-sm-2 control-Label">姓名</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="name" value="">
          </div>
          <label class="col-sm-2 control-Label">手机号</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="phone" value="">
          </div> 
		  <label class="col-sm-2 control-Label">性别</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="sex" value="">
          </div>
          <label class="col-sm-2 control-Label">年龄</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="age" value="">
          </div>
          <!-- <label class="col-sm-2 control-Label">角色</label> -->
          <!-- <div class="col-sm-3"> -->
            <input type="hidden" class="form-control" id="role" value="员工">
          <!-- </div> -->
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button id="addbutton" type="button" class="btn btn-primary" data-dismiss="modal" onclick="addStaff()" style="width: 10%; height: 38px; margin-right: 14%">添加</button>
      <button id="backbutton" type="button" class="btn btn-success" data-dismiss="modal" onclick="quit()">返回</button>
    </div>
  </div>
      <!-- Essential javascripts for application to work-->
    <script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
    <script src="js/plugins/pace.min.js"></script>
    <script type="text/javascript">
    window.onload = function() {
    	if (isEmpty($("#userid").val())) {
    		document.getElementById("modal-title").innerHTML = "新员工注册";
    		document.getElementById("addbutton").innerHTML = "注册";
    		document.getElementById('backbutton').style.display = "none"; // 改变样式
    	}
    }
    
	function isnoabcnum(str) {
	  var pattern = new RegExp("[a-z0-9]+");
	  if(pattern.test(str)){
	    return false;
	  } else {
	    return true;
	  }
	}
			
	function addStaff() {
		// 获取对应元素的值
		// var id=$("#id").val() // 增加没有id
		var username=$("#username").val().trim()
		var password=$("#password").val().trim() // 修改没有password
		var name=$("#name").val().trim()
		var phone=$("#phone").val().trim()
		var age=$("#age").val().trim()
		var sex=$("#sex").val().trim()
		// var role=$("#role").val() // 增加没有role
		// 输入判断
		if (isEmpty(username)||isEmpty(password)
				||isEmpty(name)||isEmpty(phone)
				||isEmpty(age)||isEmpty(sex)) {
			alert("输入不能为空");
			return;
		}
		if (isnoabcnum(username)) {
			alert("请输入小写字母和数字的用户名");
			return;
		}
		if (!(sex == "男" || sex == "女")) {
			alert("请输入真实的性别（特殊性别请联系管理员）");
			return;
		}
		if (isNaN(age) || parseInt(age) < 0 || parseInt(age) > 127) {
			alert("请输入真实的年龄");
			return;
		}
		if (isNaN(phone) || phone.length < 11) {
			alert("请输入真实的11位手机号（特殊手机号请联系管理员）");
			return;
		}
		// 调用ajax判断是否登录成功
		$.ajax({
			type: "post",
			url: "insertStaff.st",
			dataType: "text",
			async: true,
			data: {
				"username": username,
				"password": password,
				"name": name,
				"phone": phone,
				"age": age,
				"sex": sex,
			},
			// 回调方法
			success: function(data) {
				if (data=="re") {
					alert("用户名不能重复");
				} else if (data=="ok") {
					if (isEmpty($("#userid").val())) {
						alert("注册成功");
			            parent.quit();
			    	}
				} else {
					alert("注册失败");
				}
			},
			error: function() {
				alert("请求失败！");
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
