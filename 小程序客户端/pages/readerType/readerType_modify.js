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

  //提交服务器修改读者类型信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/readerType/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var readerTypelist_page = pages[pages.length - 2];
      var readerTypes = readerTypelist_page.data.readerTypes
      for(var i=0;i<readerTypes.length;i++) {
        if(readerTypes[i].readerTypeId == res.data.readerTypeId) {
          readerTypes[i] = res.data
          break
        }
      }
      readerTypelist_page.setData({readerTypes:readerTypes})
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

