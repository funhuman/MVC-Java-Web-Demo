<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>修改学生信息</title>
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
      <h4 class="modal-title">修改员工信息</h4>
    </div>
    <div class="modal-body">
      <form id="fm1">
        <input id="id" type="hidden" name="id" value="${staffInfo.id}">
        <input type="hidden" class="form-control" id="oldusername" value="${staffInfo.username}" readonly>
        <div class="form-group">
          <label class="col-sm-2 control-Label">登录名</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="username" value="${staffInfo.username}">
          </div>
          <label class="col-sm-2 control-Label">角色</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="role" value="${staffInfo.role}">
          </div>
          <label class="col-sm-2 control-Label">姓名</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="name" value="${staffInfo.name}">
          </div>
          <label class="col-sm-2 control-Label">手机号</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="phone" value="${staffInfo.phone}">
          </div> 
		  <label class="col-sm-2 control-Label">性别</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="sex" value="${staffInfo.sex}">
          </div>
          <label class="col-sm-2 control-Label">年龄</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="age" value="${staffInfo.age}">
          </div>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="modStaff()">修改</button>
      <button type="button" class="btn btn-success" data-dismiss="modal" onclick="javascript:window.location.href='findStaff.st'">返回</button>
    </div>
  </div>
      <!-- Essential javascripts for application to work-->
    <script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
    <script src="js/plugins/pace.min.js"></script>
    <script type="text/javascript">
    
	function modStaff() {
		// 获取对应元素的值
		var id=$("#id").val() // 增加没有id
		var username=$("#username").val()
		var oldusername=$("#oldusername").val()
		// var password=$("#password").val() // 修改没有password
		var name=$("#name").val().trim()
		var phone=$("#phone").val().trim()
		var age=$("#age").val().trim()
		var sex=$("#sex").val().trim()
		var role=$("#role").val().trim() // 增加没有role
		// 输入判断
		if (isEmpty(username)||isEmpty(role)
				||isEmpty(name)||isEmpty(phone)
				||isEmpty(age)||isEmpty(sex)) {
			alert("输入不能为空");
			return;
		}
		if (isnoabcnum(username)) {
			alert("请输入小写字母和数字的用户名");
			return;
		}
		if (phone.length < 11) {
			alert("请输入真实的手机号");
			return;
		}
		if (!isNaN(sex)) {
			alert("请输入真实的性别");
			return;
		}
		if (isNaN(age) || parseInt(age) < 0 || parseInt(age) > 127) {
			alert("请输入真实的年龄");
			return;
		}
		// 调用ajax判断是否登录成功
		$.ajax({
			type: "post",
			url: "updateStaff.st",
			dataType: "text",
			async: true,
			data: {
				"id": id, // 增加没有id
				"oldusername": oldusername,
				"username": username,
				// "password": password, // 修改没有密码
				"role": role, // 增加没有角色
				"name": name,
				"phone": phone,
				"age": age,
				"sex": sex,
			},
			// 回调方法
			success: function(data) {
				if (data=="no") {
					alert("修改失败");
				} else {
					// alert("修改成功");
					window.location.href='findStaff.st';
				}
			},
			error: function() {
				alert("请求失败！");
			}
		});
	}
	function isnoabcnum(str) {
	  var pattern = new RegExp("[a-z0-9]+");
	  if(pattern.test(str)){
	    return false;
	  } else {
	    return true;
	  }
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
