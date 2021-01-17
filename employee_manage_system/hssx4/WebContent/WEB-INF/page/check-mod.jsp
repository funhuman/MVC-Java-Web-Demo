<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" type="text/css" href="css/main.css">
 <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<title>修改考勤信息</title>
<style type="text/css">
.form-group div{
        display:inline-block;
}
.form-group label{
        text-align:right;
 }
</style>
</head>
<body>
<div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title">修改考勤信息</h4>
              </div>
              <div class="modal-body">
              <form id="fm1">
              <input type="hidden" id="userid" name="userid" value="${CheckInfo.staffid}" >
              <div class="form-group">
              <label class="col-sm-2 control-label">员工编号:</label>
              <div class="col-sm-3">
              <input type="text" class="form-control" id="staffid" name="staffid" value="${CheckInfo.staffid}" ReadOnly="readonly">
              </div>
              </div>
              <div class="form-group">
               <label class="col-sm-2 control-label">签到状态:</label>
              <div class="col-sm-3">
              <input type="text" class="form-control" id="checkstatus" name="checkstatus" value="${CheckInfo.checkstatus}">
              </div>
              </div>
              
              </form>
              
               
              </div>
              </div>
             
              <div class="modal-footer">
              <button type="button" class="btn btn-success" data-dismiss="modal" onclick="saveStudent()">保存</button>
              <button type="button" class="btn btn-success" data-dismiss="modal" onclick="javasrcipt:window.location.href='findStatus.ck'">返回</button>
              </div>
 
                
    <script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
    <script type="text/javascript">
    function saveStudent() {
    	var checkstatus =$("#checkstatus").val();
    	var staffid = $("#staffid").val();
		// 调用ajax判断是否登录成功
		if(confirm("确认要修改吗？")){
			$.ajax({
				type: "post",
				url: "updateUserStatusById.ck",
				dataType: "text",
				async: true,
				data: {
					"checkstatus":checkstatus,
					"staffid":staffid
				},
				// 回调方法
				success: function(data) {
					if (data=="no") {
						alert("保存失败");
					} else {
						// alert("修改成功");
						alert("保存成功！");
						window.location.href='findStatus.ck';
					}
				},
				error: function() {
					alert("异常！");
				}
			});
		}
		
	}
    </script>
</body>
</html>