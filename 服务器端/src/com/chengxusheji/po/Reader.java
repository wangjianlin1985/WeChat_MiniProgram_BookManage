package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;
import com.client.utils.JsonUtils;
import com.client.utils.SessionConsts;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class Reader {
    /*读者编号*/
    @NotEmpty(message="读者编号不能为空")
    private String readerNo;
    public String getReaderNo(){
        return readerNo;
    }
    public void setReaderNo(String readerNo){
        this.readerNo = readerNo;
    }

    /*登录密码*/
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*读者类型*/
    private ReaderType readerTypeObj;
    public ReaderType getReaderTypeObj() {
        return readerTypeObj;
    }
    public void setReaderTypeObj(ReaderType readerTypeObj) {
        this.readerTypeObj = readerTypeObj;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String readerName;
    public String getReaderName() {
        return readerName;
    }
    public void setReaderName(String readerName) {
        this.readerName = readerName;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*读者头像*/
    private String photo;
    public String getPhoto() {
        return photo;
    }
    public void setPhoto(String photo) {
        this.photo = photo;
    }

    private String photoUrl;
    public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	public String getPhotoUrl() {
		return  SessionConsts.BASE_URL + photo;
	}
    /*读者生日*/
    @NotEmpty(message="读者生日不能为空")
    private String birthday;
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /*联系电话*/
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*联系Email*/
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    /*读者地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    @JsonIgnore
    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonReader=new JSONObject(); 
		jsonReader.accumulate("readerNo", this.getReaderNo());
		jsonReader.accumulate("password", this.getPassword());
		jsonReader.accumulate("readerTypeObj", this.getReaderTypeObj().getReaderTypeName());
		jsonReader.accumulate("readerTypeObjPri", this.getReaderTypeObj().getReaderTypeId());
		jsonReader.accumulate("readerName", this.getReaderName());
		jsonReader.accumulate("sex", this.getSex());
		jsonReader.accumulate("photo", this.getPhoto());
		jsonReader.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonReader.accumulate("telephone", this.getTelephone());
		jsonReader.accumulate("email", this.getEmail());
		jsonReader.accumulate("address", this.getAddress());
		return jsonReader;
    }

    @Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}