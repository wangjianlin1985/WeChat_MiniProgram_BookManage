var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    bookTypeId: 0, //图书类别id
    bookTypeName: "", //类别名称
    days: "", //可借阅天数
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var bookTypeId = params.bookTypeId
    var url = config.basePath + "api/bookType/get/" + bookTypeId
    utils.sendRequest(url, {}, function (bookTypeRes) {
      wx.stopPullDownRefresh()
      self.setData({
        bookTypeId: bookTypeRes.data.bookTypeId,
        bookTypeName: bookTypeRes.data.bookTypeName,
        days: bookTypeRes.data.days,
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

