package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.LoanInfoService;
import com.chengxusheji.po.LoanInfo;
import com.chengxusheji.service.BookService;
import com.chengxusheji.po.Book;
import com.chengxusheji.service.ReaderService;
import com.chengxusheji.po.Reader;

//LoanInfo管理控制层
@Controller
@RequestMapping("/LoanInfo")
public class LoanInfoController extends BaseController {

    /*业务层对象*/
    @Resource LoanInfoService loanInfoService;

    @Resource BookService bookService;
    @Resource ReaderService readerService;
	@InitBinder("book")
	public void initBinderbook(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("book.");
	}
	@InitBinder("reader")
	public void initBinderreader(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("reader.");
	}
	@InitBinder("loanInfo")
	public void initBinderLoanInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("loanInfo.");
	}
	/*跳转到添加LoanInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new LoanInfo());
		/*查询所有的Book信息*/
		List<Book> bookList = bookService.queryAllBook();
		request.setAttribute("bookList", bookList);
		/*查询所有的Reader信息*/
		List<Reader> readerList = readerService.queryAllReader();
		request.setAttribute("readerList", readerList);
		return "LoanInfo_add";
	}

	/*客户端ajax方式提交添加借阅信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated LoanInfo loanInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		loanInfo.setReturnDate("--");
        loanInfoService.addLoanInfo(loanInfo);
        message = "借阅信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询借阅信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("book") Book book,@ModelAttribute("reader") Reader reader,String borrowDate,String returnDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (borrowDate == null) borrowDate = "";
		if (returnDate == null) returnDate = "";
		if(rows != 0)loanInfoService.setRows(rows);
		List<LoanInfo> loanInfoList = loanInfoService.queryLoanInfo(book, reader, borrowDate, returnDate, page);
	    /*计算总的页数和总的记录数*/
	    loanInfoService.queryTotalPageAndRecordNumber(book, reader, borrowDate, returnDate);
	    /*获取到总的页码数目*/
	    int totalPage = loanInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = loanInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(LoanInfo loanInfo:loanInfoList) {
			JSONObject jsonLoanInfo = loanInfo.getJsonObject();
			jsonArray.put(jsonLoanInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询借阅信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<LoanInfo> loanInfoList = loanInfoService.queryAllLoanInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(LoanInfo loanInfo:loanInfoList) {
			JSONObject jsonLoanInfo = new JSONObject();
			jsonLoanInfo.accumulate("loadId", loanInfo.getLoadId());
			jsonArray.put(jsonLoanInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询借阅信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("book") Book book,@ModelAttribute("reader") Reader reader,String borrowDate,String returnDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (borrowDate == null) borrowDate = "";
		if (returnDate == null) returnDate = "";
		List<LoanInfo> loanInfoList = loanInfoService.queryLoanInfo(book, reader, borrowDate, returnDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    loanInfoService.queryTotalPageAndRecordNumber(book, reader, borrowDate, returnDate);
	    /*获取到总的页码数目*/
	    int totalPage = loanInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = loanInfoService.getRecordNumber();
	    request.setAttribute("loanInfoList",  loanInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("book", book);
	    request.setAttribute("reader", reader);
	    request.setAttribute("borrowDate", borrowDate);
	    request.setAttribute("returnDate", returnDate);
	    List<Book> bookList = bookService.queryAllBook();
	    request.setAttribute("bookList", bookList);
	    List<Reader> readerList = readerService.queryAllReader();
	    request.setAttribute("readerList", readerList);
		return "LoanInfo/loanInfo_frontquery_result"; 
	}

     /*前台查询LoanInfo信息*/
	@RequestMapping(value="/{loadId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer loadId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键loadId获取LoanInfo对象*/
        LoanInfo loanInfo = loanInfoService.getLoanInfo(loadId);

        List<Book> bookList = bookService.queryAllBook();
        request.setAttribute("bookList", bookList);
        List<Reader> readerList = readerService.queryAllReader();
        request.setAttribute("readerList", readerList);
        request.setAttribute("loanInfo",  loanInfo);
        return "LoanInfo/loanInfo_frontshow";
	}

	/*ajax方式显示借阅信息修改jsp视图页*/
	@RequestMapping(value="/{loadId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer loadId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键loadId获取LoanInfo对象*/
        LoanInfo loanInfo = loanInfoService.getLoanInfo(loadId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonLoanInfo = loanInfo.getJsonObject();
		out.println(jsonLoanInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新借阅信息信息*/
	@RequestMapping(value = "/{loadId}/update", method = RequestMethod.POST)
	public void update(@Validated LoanInfo loanInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			loanInfoService.updateLoanInfo(loanInfo);
			message = "借阅信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "借阅信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除借阅信息信息*/
	@RequestMapping(value="/{loadId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer loadId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  loanInfoService.deleteLoanInfo(loadId);
	            request.setAttribute("message", "借阅信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "借阅信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条借阅信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String loadIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = loanInfoService.deleteLoanInfos(loadIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出借阅信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("book") Book book,@ModelAttribute("reader") Reader reader,String borrowDate,String returnDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(borrowDate == null) borrowDate = "";
        if(returnDate == null) returnDate = "";
        List<LoanInfo> loanInfoList = loanInfoService.queryLoanInfo(book,reader,borrowDate,returnDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "LoanInfo信息记录"; 
        String[] headers = { "借阅编号","图书对象","读者对象","借阅时间","归还时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<loanInfoList.size();i++) {
        	LoanInfo loanInfo = loanInfoList.get(i); 
        	dataset.add(new String[]{loanInfo.getLoadId() + "",loanInfo.getBook().getBookName(),loanInfo.getReader().getReaderName(),loanInfo.getBorrowDate(),loanInfo.getReturnDate()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"LoanInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
