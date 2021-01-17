<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>用户信息</title>
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
  </style>
</head>
<body>
  <div class="modal-content">
    <div class="modal-header">
      <h4 class="modal-title">用户个人信息</h4>
    </div>
    <div class="modal-body">
      <form id="fm1">
        <input type="hidden" id="id" name="id" value="${userInfo.id}">
        <div class="form-group">
          <label class="col-sm-2 control-Label">用户名</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="username" value="${userInfo.username}"  readonly>
          </div>
          <label class="col-sm-2 control-Label">角色</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="role" value="${userInfo.role}" readonly>
          </div>
          <label class="col-sm-2 control-Label">真实姓名</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="staffname" value="${staffInfo.name}">
          </div>
          <label class="col-sm-2 control-Label">手机号</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="staffphone" value="${staffInfo.phone}">
          </div>
          <label class="col-sm-2 control-Label">性别</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="staffsex" value="${staffInfo.sex}">
          </div>
          <label class="col-sm-2 control-Label">年龄</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="staffage" value="${staffInfo.age}">
          </div>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-success" data-dismiss="modal" onclick="updateUserInfo()" style="width: 140px; margin-right: 19%;">修改</button>
      <!-- <a href="#title-1" target="_self">
      	<button type="button" class="btn btn-success" data-dismiss="modal">返回</button>
      </a> -->
    </div>
  </div>
      <!-- Essential javascripts for application to work-->
    <script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
    <script src="js/plugins/pace.min.js"></script>
    <script type="text/javascript">
	function updateUserInfo() {
		// 获取对应元素的值
		var id=$("#id").val();
		//var username=$("#username").val();
		var name=$("#staffname").val();
		var phone=$("#staffphone").val();
		var age=$("#staffage").val();
		var sex=$("#staffsex").val();
		$.ajax({
			type: "post", // 方法类型
			url: "updateStaff.st", // url
			cache: false,
			data: {
				"id": id, // 增加没有id
				"name": name,
				"phone": phone,
				//"password": password,
				"age": age,
				"sex": sex,
			},
			dataType: "text", // 数据；类型	string json xml
			// 回调方法
			success: function(data) {
				if (data=="no") {
					alert("修改失败");
				} else {
					// alert("修改成功");
					location.reload(); // 刷新
				}
			},
			error: function() {
				alert("请求失败！");
			}
		});
	}
    </script>
  </body>
</html>