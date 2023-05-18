<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/readerType.css" />
<div id="readerType_editDiv">
	<form id="readerTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">读者类型编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="readerType_readerTypeId_edit" name="readerType.readerTypeId" value="<%=request.getParameter("readerTypeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">读者类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="readerType_readerTypeName_edit" name="readerType.readerTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">可借阅数目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="readerType_number_edit" name="readerType.number" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="readerTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ReaderType/js/readerType_modify.js"></script> 
