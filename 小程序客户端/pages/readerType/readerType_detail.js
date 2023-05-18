var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    readerTypeId: 0, //读者类型编号
    readerTypeName: "", //读者类型
    number: "", //可借阅数目
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var readerTypeId = params.readerTypeId
    var url = config.basePath + "api/readerType/get/" + readerTypeId
    utils.sendRequest(url, {}, function (readerTypeRes) {
      wx.stopPullDownRefresh()
      self.setData({
        readerTypeId: readerTypeRes.data.readerTypeId,
        readerTypeName: readerTypeRes.data.readerTypeName,
        number: readerTypeRes.data.number,
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

