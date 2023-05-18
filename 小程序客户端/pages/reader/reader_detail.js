var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    readerNo: "", //读者编号
    password: "", //登录密码
    readerTypeObj: "", //读者类型
    readerName: "", //姓名
    sex: "", //性别
    photoUrl: "", //读者头像
    birthday: "", //读者生日
    telephone: "", //联系电话
    email: "", //联系Email
    address: "", //读者地址
    loadingHide: true,
    loadingText: "网络操作中。。",
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
        readerTypeObj: readerRes.data.readerTypeObj.readerTypeName,
        readerName: readerRes.data.readerName,
        sex: readerRes.data.sex,
        photo: readerRes.data.photo,
        photoUrl: readerRes.data.photoUrl,
        birthday: readerRes.data.birthday,
        telephone: readerRes.data.telephone,
        email: readerRes.data.email,
        address: readerRes.data.address,
      })
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  }

})

