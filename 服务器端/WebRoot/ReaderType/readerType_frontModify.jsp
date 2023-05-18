<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ReaderType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    ReaderType readerType = (ReaderType)request.getAttribute("readerType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改读者类型信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">读者类型信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="readerTypeEditForm" id="readerTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="readerType_readerTypeId_edit" class="col-md-3 text-right">读者类型编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="readerType_readerTypeId_edit" name="readerType.readerTypeId" class="form-control" placeholder="请输入读者类型编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="readerType_readerTypeName_edit" class="col-md-3 text-right">读者类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="readerType_readerTypeName_edit" name="readerType.readerTypeName" class="form-control" placeholder="请输入读者类型">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="readerType_number_edit" class="col-md-3 text-right">可借阅数目:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="readerType_number_edit" name="readerType.number" class="form-control" placeholder="请输入可借阅数目">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxReaderTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#readerTypeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改读者类型界面并初始化数据*/
function readerTypeEdit(readerTypeId) {
	$.ajax({
		url :  basePath + "ReaderType/" + readerTypeId + "/update",
		type : "get",
		dataType: "json",
		success : function (readerType, response, status) {
			if (readerType) {
				$("#readerType_readerTypeId_edit").val(readerType.readerTypeId);
				$("#readerType_readerTypeName_edit").val(readerType.readerTypeName);
				$("#readerType_number_edit").val(readerType.number);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交读者类型信息表单给服务器端修改*/
function ajaxReaderTypeModify() {
	$.ajax({
		url :  basePath + "ReaderType/" + $("#readerType_readerTypeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#readerTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "ReaderType/frontlist";
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    readerTypeEdit("<%=request.getParameter("readerTypeId")%>");
 })
 </script> 
</body>
</html>

