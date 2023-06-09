$(function () {
	$.ajax({
		url : "BookType/" + $("#bookType_bookTypeId_edit").val() + "/update",
		type : "get",
		data : {
			//bookTypeId : $("#bookType_bookTypeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (bookType, response, status) {
			$.messager.progress("close");
			if (bookType) { 
				$("#bookType_bookTypeId_edit").val(bookType.bookTypeId);
				$("#bookType_bookTypeId_edit").validatebox({
					required : true,
					missingMessage : "请输入图书类别id",
					editable: false
				});
				$("#bookType_bookTypeName_edit").val(bookType.bookTypeName);
				$("#bookType_bookTypeName_edit").validatebox({
					required : true,
					missingMessage : "请输入类别名称",
				});
				$("#bookType_days_edit").val(bookType.days);
				$("#bookType_days_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入可借阅天数",
					invalidMessage : "可借阅天数输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#bookTypeModifyButton").click(function(){ 
		if ($("#bookTypeEditForm").form("validate")) {
			$("#bookTypeEditForm").form({
			    url:"BookType/" +  $("#bookType_bookTypeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#bookTypeEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#bookTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
