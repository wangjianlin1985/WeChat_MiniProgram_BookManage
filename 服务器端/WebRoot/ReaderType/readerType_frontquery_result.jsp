<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ReaderType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ReaderType> readerTypeList = (List<ReaderType>)request.getAttribute("readerTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>读者类型查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-12 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#readerTypeListPanel" aria-controls="readerTypeListPanel" role="tab" data-toggle="tab">读者类型列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ReaderType/readerType_frontAdd.jsp" style="display:none;">添加读者类型</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="readerTypeListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>读者类型编号</td><td>读者类型</td><td>可借阅数目</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<readerTypeList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		ReaderType readerType = readerTypeList.get(i); //获取到读者类型对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=readerType.getReaderTypeId() %></td>
 											<td><%=readerType.getReaderTypeName() %></td>
 											<td><%=readerType.getNumber() %></td>
 											<td>
 												<a href="<%=basePath  %>ReaderType/<%=readerType.getReaderTypeId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="readerTypeEdit('<%=readerType.getReaderTypeId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="readerTypeDelete('<%=readerType.getReaderTypeId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div style="display:none;">
		<div class="page-header">
    		<h1>读者类型查询</h1>
		</div>
		<form name="readerTypeQueryForm" id="readerTypeQueryForm" action="<%=basePath %>ReaderType/frontlist" class="mar_t15" method="post">
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="readerTypeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;读者类型信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#readerTypeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxReaderTypeModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.readerTypeQueryForm.currentPage.value = currentPage;
    document.readerTypeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.readerTypeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.readerTypeQueryForm.currentPage.value = pageValue;
    documentreaderTypeQueryForm.submit();
}

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
				$('#readerTypeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除读者类型信息*/
function readerTypeDelete(readerTypeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ReaderType/deletes",
			data : {
				readerTypeIds : readerTypeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#readerTypeQueryForm").submit();
					//location.href= basePath + "ReaderType/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

