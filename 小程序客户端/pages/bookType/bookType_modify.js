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

  //提交服务器修改图书类型信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/bookType/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var bookTypelist_page = pages[pages.length - 2];
      var bookTypes = bookTypelist_page.data.bookTypes
      for(var i=0;i<bookTypes.length;i++) {
        if(bookTypes[i].bookTypeId == res.data.bookTypeId) {
          bookTypes[i] = res.data
          break
        }
      }
      bookTypelist_page.setData({bookTypes:bookTypes})
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

