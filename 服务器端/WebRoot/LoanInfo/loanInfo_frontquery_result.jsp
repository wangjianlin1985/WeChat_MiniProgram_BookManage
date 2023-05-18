<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LoanInfo" %>
<%@ page import="com.chengxusheji.po.Book" %>
<%@ page import="com.chengxusheji.po.Reader" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<LoanInfo> loanInfoList = (List<LoanInfo>)request.getAttribute("loanInfoList");
    //获取所有的book信息
    List<Book> bookList = (List<Book>)request.getAttribute("bookList");
    //获取所有的reader信息
    List<Reader> readerList = (List<Reader>)request.getAttribute("readerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Book book = (Book)request.getAttribute("book");
    Reader reader = (Reader)request.getAttribute("reader");
    String borrowDate = (String)request.getAttribute("borrowDate"); //借阅时间查询关键字
    String returnDate = (String)request.getAttribute("returnDate"); //归还时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>借阅信息查询</title>
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
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#loanInfoListPanel" aria-controls="loanInfoListPanel" role="tab" data-toggle="tab">借阅信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>LoanInfo/loanInfo_frontAdd.jsp" style="display:none;">添加借阅信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="loanInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>借阅编号</td><td>图书对象</td><td>读者对象</td><td>借阅时间</td><td>归还时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<loanInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		LoanInfo loanInfo = loanInfoList.get(i); //获取到借阅信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=loanInfo.getLoadId() %></td>
 											<td><%=loanInfo.getBook().getBookName() %></td>
 											<td><%=loanInfo.getReader().getReaderName() %></td>
 											<td><%=loanInfo.getBorrowDate() %></td>
 											<td><%=loanInfo.getReturnDate() %></td>
 											<td>
 												<a href="<%=basePath  %>LoanInfo/<%=loanInfo.getLoadId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="loanInfoEdit('<%=loanInfo.getLoadId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="loanInfoDelete('<%=loanInfo.getLoadId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>借阅信息查询</h1>
		</div>
		<form name="loanInfoQueryForm" id="loanInfoQueryForm" action="<%=basePath %>LoanInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="book_barcode">图书对象：</label>
                <select id="book_barcode" name="book.barcode" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Book bookTemp:bookList) {
	 					String selected = "";
 					if(book!=null && book.getBarcode()!=null && book.getBarcode().equals(bookTemp.getBarcode()))
 						selected = "selected";
	 				%>
 				 <option value="<%=bookTemp.getBarcode() %>" <%=selected %>><%=bookTemp.getBookName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="reader_readerNo">读者对象：</label>
                <select id="reader_readerNo" name="reader.readerNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Reader readerTemp:readerList) {
	 					String selected = "";
 					if(reader!=null && reader.getReaderNo()!=null && reader.getReaderNo().equals(readerTemp.getReaderNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=readerTemp.getReaderNo() %>" <%=selected %>><%=readerTemp.getReaderName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="borrowDate">借阅时间:</label>
				<input type="text" id="borrowDate" name="borrowDate" class="form-control"  placeholder="请选择借阅时间" value="<%=borrowDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="returnDate">归还时间:</label>
				<input type="text" id="returnDate" name="returnDate" class="form-control"  placeholder="请选择归还时间" value="<%=returnDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="loanInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;借阅信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="loanInfoEditForm" id="loanInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="loanInfo_loadId_edit" class="col-md-3 text-right">借阅编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="loanInfo_loadId_edit" name="loanInfo.loadId" class="form-control" placeholder="请输入借阅编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="loanInfo_book_barcode_edit" class="col-md-3 text-right">图书对象:</label>
		  	 <div class="col-md-9">
			    <select id="loanInfo_book_barcode_edit" name="loanInfo.book.barcode" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="loanInfo_reader_readerNo_edit" class="col-md-3 text-right">读者对象:</label>
		  	 <div class="col-md-9">
			    <select id="loanInfo_reader_readerNo_edit" name="loanInfo.reader.readerNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="loanInfo_borrowDate_edit" class="col-md-3 text-right">借阅时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date loanInfo_borrowDate_edit col-md-12" data-link-field="loanInfo_borrowDate_edit">
                    <input class="form-control" id="loanInfo_borrowDate_edit" name="loanInfo.borrowDate" size="16" type="text" value="" placeholder="请选择借阅时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="loanInfo_returnDate_edit" class="col-md-3 text-right">归还时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date loanInfo_returnDate_edit col-md-12" data-link-field="loanInfo_returnDate_edit">
                    <input class="form-control" id="loanInfo_returnDate_edit" name="loanInfo.returnDate" size="16" type="text" value="" placeholder="请选择归还时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#loanInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxLoanInfoModify();">提交</button>
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
    document.loanInfoQueryForm.currentPage.value = currentPage;
    document.loanInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.loanInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.loanInfoQueryForm.currentPage.value = pageValue;
    documentloanInfoQueryForm.submit();
}

/*弹出修改借阅信息界面并初始化数据*/
function loanInfoEdit(loadId) {
	$.ajax({
		url :  basePath + "LoanInfo/" + loadId + "/update",
		type : "get",
		dataType: "json",
		success : function (loanInfo, response, status) {
			if (loanInfo) {
				$("#loanInfo_loadId_edit").val(loanInfo.loadId);
				$.ajax({
					url: basePath + "Book/listAll",
					type: "get",
					success: function(books,response,status) { 
						$("#loanInfo_book_barcode_edit").empty();
						var html="";
		        		$(books).each(function(i,book){
		        			html += "<option value='" + book.barcode + "'>" + book.bookName + "</option>";
		        		});
		        		$("#loanInfo_book_barcode_edit").html(html);
		        		$("#loanInfo_book_barcode_edit").val(loanInfo.bookPri);
					}
				});
				$.ajax({
					url: basePath + "Reader/listAll",
					type: "get",
					success: function(readers,response,status) { 
						$("#loanInfo_reader_readerNo_edit").empty();
						var html="";
		        		$(readers).each(function(i,reader){
		        			html += "<option value='" + reader.readerNo + "'>" + reader.readerName + "</option>";
		        		});
		        		$("#loanInfo_reader_readerNo_edit").html(html);
		        		$("#loanInfo_reader_readerNo_edit").val(loanInfo.readerPri);
					}
				});
				$("#loanInfo_borrowDate_edit").val(loanInfo.borrowDate);
				$("#loanInfo_returnDate_edit").val(loanInfo.returnDate);
				$('#loanInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除借阅信息信息*/
function loanInfoDelete(loadId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "LoanInfo/deletes",
			data : {
				loadIds : loadId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#loanInfoQueryForm").submit();
					//location.href= basePath + "LoanInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交借阅信息信息表单给服务器端修改*/
function ajaxLoanInfoModify() {
	$.ajax({
		url :  basePath + "LoanInfo/" + $("#loanInfo_loadId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#loanInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#loanInfoQueryForm").submit();
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

    /*借阅时间组件*/
    $('.loanInfo_borrowDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*归还时间组件*/
    $('.loanInfo_returnDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

