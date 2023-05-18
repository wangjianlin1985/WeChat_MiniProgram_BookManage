var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

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
    photoUrl: "",
    photoList: [],
    birthday: "", //读者生日
    telephone: "", //联系电话
    email: "", //联系Email
    address: "", //读者地址
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //选择读者生日事件
  bind_birthday_change: function (e) {
    this.setData({
      birthday: e.detail.value
    })
  },
  //清空读者生日事件
  clear_birthday: function (e) {
    this.setData({
      birthday: "",
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
          loadingHide: false, 
        });

        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              photo: res.data,
              loadingHide: true
            })
          }, 200)
        })
      }
    })
  },

  //读者类型修改事件
  bind_readerTypeObj_change: function (e) {
    this.setData({
      readerTypeObj_Index: e.detail.value
    })
  },

  //提交服务器修改读者信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/reader/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var readerlist_page = pages[pages.length - 2];
      var readers = readerlist_page.data.readers
      for(var i=0;i<readers.length;i++) {
        if(readers[i].readerNo == res.data.readerNo) {
          readers[i] = res.data
          break
        }
      }
      readerlist_page.setData({readers:readers})
      setTimeout(function () {
        wx.navigateBack({})
      }, 500) 
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var readerNo = params.readerNo
    var url = config.basePath + "api/reader/get/" + readerNo
    utils.sendRequest(url, {}, function (readerRes) {
      wx.stopPullDownRefresh()
      self.setData({
        readerNo: readerRes.data.readerNo,
        password: readerRes.data.password,
        readerTypeObj_Index: 1,
        readerName: readerRes.data.readerName,
        sex: readerRes.data.sex,
        photo: readerRes.data.photo,
        photoUrl: readerRes.data.photoUrl,
        birthday: readerRes.data.birthday,
        telephone: readerRes.data.telephone,
        email: readerRes.data.email,
        address: readerRes.data.address,
      })

      var readerTypeUrl = config.basePath + "api/readerType/listAll" 
      utils.sendRequest(readerTypeUrl, null, function (res) {
        wx.stopPullDownRefresh()
        self.setData({
          readerTypes: res.data,
        })
        for (var i = 0; i < self.data.readerTypes.length; i++) {
          if (readerRes.data.readerTypeObj.readerTypeId == self.data.readerTypes[i].readerTypeId) {
            self.setData({
              readerTypeObj_Index: i,
            });
            break;
          }
        }
      })
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  },

})

