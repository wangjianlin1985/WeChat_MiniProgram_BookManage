var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    readerNo: "", //读者编号
    password: "", //登录密码
    readerTypeObj_Index: "0", //读者类型
    readerTypes: [],
    readerName: "", //姓名
    sex: "", //性别
    photo: "upload/NoImage.jpg", //读者头像
    photoList: [],
    birthday: "", //读者生日
    telephone: "", //联系电话
    email: "", //联系Email
    address: "", //读者地址
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //初始化下拉框的信息
  init_select_params: function () { 
    var self = this;
    var url = null;
    url = config.basePath + "api/readerType/listAll";
    utils.sendRequest(url, null, function (res) {
      wx.stopPullDownRefresh();
      self.setData({
        readerTypes: res.data,
      });
    });
  },
  //读者类型改变事件
  bind_readerTypeObj_change: function (e) {
    this.setData({
      readerTypeObj_Index: e.detail.value
    })
  },

  //选择读者生日
  bind_birthday_change: function (e) {
    this.setData({
      birthday: e.detail.value
    })
  },
  //清空读者生日
  clear_birthday: function (e) {
    this.setData({
      birthday: "",
    });
  },

  /*提交添加读者到服务器 */
  formSubmit: function (e) {
    var self = this;
    var formData = e.detail.value;
    var url = config.basePath + "api/reader/add";
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '发布成功',
        icon: 'success',
        duration: 500
      })

      //提交成功后重置表单数据
      self.setData({
        readerNo: "",
    password: "",
        readerTypeObj_Index: "0",
    readerName: "",
    sex: "",
        photo: "upload/NoImage.jpg",
        photoList: [],
    birthday: "",
    telephone: "",
    email: "",
    address: "",
        loadingHide: true,
        loadingText: "网络操作中。。",
      })
    });
  },

  //选择读者头像上传
  select_photo: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          photoList: tempFilePaths,
          loadingHide: false
        });
        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              photo: res.data,
              loadingHide: true
            });
          }, 200);
        });
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.init_select_params();
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    var token = wx.getStorageSync('authToken');
    if (!token) {
      wx.navigateTo({
        url: '../mobile/mobile',
      })
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  }
})

