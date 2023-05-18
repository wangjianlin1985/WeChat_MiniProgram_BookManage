<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reader.css" /> 

<div id="reader_manage"></div>
<div id="reader_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="reader_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="reader_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="reader_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="reader_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="reader_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="readerQueryForm" method="post">
			读者编号：<input type="text" class="textbox" id="readerNo" name="readerNo" style="width:110px" />
			读者类型：<input class="textbox" type="text" id="readerTypeObj_readerTypeId_query" name="readerTypeObj.readerTypeId" style="width: auto"/>
			姓名：<input type="text" class="textbox" id="readerName" name="readerName" style="width:110px" />
			读者生日：<input type="text" id="birthday" name="birthday" class="easyui-datebox" editable="false" style="width:100px">
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="reader_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="readerEditDiv">
	<form id="readerEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">读者编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_readerNo_edit" name="reader.readerNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_password_edit" name="reader.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">读者类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="reader_readerTypeObj_readerTypeId_edit" name="reader.readerTypeObj.readerTypeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_readerName_edit" name="reader.readerName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_sex_edit" name="reader.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">读者头像:</span>
			<span class="inputControl">
				<img id="reader_photoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="reader_photo" name="reader.photo"/>
				<input id="photoFile" name="photoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">读者生日:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_birthday_edit" name="reader.birthday" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_telephone_edit" name="reader.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系Email:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_email_edit" name="reader.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">读者地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="reader_address_edit" name="reader.address" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Reader/js/reader_manage.js"></script> 
