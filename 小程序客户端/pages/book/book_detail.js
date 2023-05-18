var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    barcode: "", //图书条形码
    bookName: "", //图书名称
    bookTypeObj: "", //图书所在类别
    price: "", //图书价格
    count: "", //库存
    publishDate: "", //出版日期
    publish: "", //出版社
    bookPhotoUrl: "", //图书图片
    hitNum: "", //浏览量
    bookDesc: "", //图书简介
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var barcode = params.barcode
    var url = config.basePath + "api/book/get/" + barcode
    utils.sendRequest(url, {}, function (bookRes) {
      wx.stopPullDownRefresh()
      self.setData({
        barcode: bookRes.data.barcode,
        bookName: bookRes.data.bookName,
        bookTypeObj: bookRes.data.bookTypeObj.bookTypeName,
        price: bookRes.data.price,
        count: bookRes.data.count,
        publishDate: bookRes.data.publishDate,
        publish: bookRes.data.publish,
        bookPhoto: bookRes.data.bookPhoto,
        bookPhotoUrl: bookRes.data.bookPhotoUrl,
        hitNum: bookRes.data.hitNum,
        bookDesc: bookRes.data.bookDesc,
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

