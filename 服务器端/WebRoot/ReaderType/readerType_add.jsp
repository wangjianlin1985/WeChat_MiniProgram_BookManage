<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/readerType.css" />
<div id="readerTypeAddDiv">
	<form id="readerTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">读者类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="readerType_readerTypeName" name="readerType.readerTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">可借阅数目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="readerType_number" name="readerType.number" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="readerTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="readerTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ReaderType/js/readerType_add.js"></script> 
