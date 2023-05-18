var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    barcode: "", //图书条形码
    bookName: "", //图书名称
    bookTypeObj_Index: "0", //图书所在类别
    bookTypes: [],
    price: "", //图书价格
    count: "", //库存
    publishDate: "", //出版日期
    publish: "", //出版社
    bookPhoto: "upload/NoImage.jpg", //图书图片
    bookPhotoUrl: "",
    bookPhotoList: [],
    hitNum: "", //浏览量
    bookDesc: "", //图书简介
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //选择出版日期事件
  bind_publishDate_change: function (e) {
    this.setData({
      publishDate: e.detail.value
    })
  },
  //清空出版日期事件
  clear_publishDate: function (e) {
    this.setData({
      publishDate: "",
    });
  },

  //选择图书图片上传
  select_bookPhoto: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          bookPhotoList: tempFilePaths,
          loadingHide: false, 
        });

        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              bookPhoto: res.data,
              loadingHide: true
            })
          }, 200)
        })
      }
    })
  },

  //图书所在类别修改事件
  bind_bookTypeObj_change: function (e) {
    this.setData({
      bookTypeObj_Index: e.detail.value
    })
  },

  //提交服务器修改图书信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/book/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var booklist_page = pages[pages.length - 2];
      var books = booklist_page.data.books
      for(var i=0;i<books.length;i++) {
        if(books[i].barcode == res.data.barcode) {
          books[i] = res.data
          break
        }
      }
      booklist_page.setData({books:books})
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
    var barcode = params.barcode
    var url = config.basePath + "api/book/get/" + barcode
    utils.sendRequest(url, {}, function (bookRes) {
      wx.stopPullDownRefresh()
      self.setData({
        barcode: bookRes.data.barcode,
        bookName: bookRes.data.bookName,
        bookTypeObj_Index: 1,
        price: bookRes.data.price,
        count: bookRes.data.count,
        publishDate: bookRes.data.publishDate,
        publish: bookRes.data.publish,
        bookPhoto: bookRes.data.bookPhoto,
        bookPhotoUrl: bookRes.data.bookPhotoUrl,
        hitNum: bookRes.data.hitNum,
        bookDesc: bookRes.data.bookDesc,
      })

      var bookTypeUrl = config.basePath + "api/bookType/listAll" 
      utils.sendRequest(bookTypeUrl, null, function (res) {
        wx.stopPullDownRefresh()
        self.setData({
          bookTypes: res.data,
        })
        for (var i = 0; i < self.data.bookTypes.length; i++) {
          if (bookRes.data.bookTypeObj.bookTypeId == self.data.bookTypes[i].bookTypeId) {
            self.setData({
              bookTypeObj_Index: i,
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

