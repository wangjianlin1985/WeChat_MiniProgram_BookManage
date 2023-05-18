var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    queryViewHidden: true, //是否隐藏查询条件界面
    readerNo: "", //读者编号查询关键字
    readerTypeObj_Index:"0", //图书分类查询条件
    readerTypes: [{"readerTypeId":0,"readerTypeName":"不限制"}],
    readerName: "", //姓名查询关键字
    birthday: "", //读者生日查询关键字
    telephone: "", //联系电话查询关键字
    readers: [], //界面显示的读者列表数据
    page_size: 8, //每页显示几条数据
    page: 1,  //当前要显示第几页
    totalPage: null, //总的页码数
    loading_hide: true, //是否隐藏加载动画
    nodata_hide: true, //是否隐藏没有数据记录提示
  },

  // 加载读者列表
  listReader: function () {
    var self = this
    var url = config.basePath + "api/reader/list"
    //如果要显示的页码超过总页码不操作
    if(self.data.totalPage != null && self.data.page > self.data.totalPage) return
    self.setData({
      loading_hide: false,  //显示加载动画
    })
    //提交查询参数到服务器查询数据列表
    utils.sendRequest(url, {
      "readerNo": self.data.readerNo,
      "readerTypeObj.readerTypeId": self.data.readerTypes[self.data.readerTypeObj_Index].readerTypeId,
      "readerName": self.data.readerName,
      "birthday": self.data.birthday,
      "telephone": self.data.telephone,
      "page": self.data.page,
      "rows": self.data.page_size,
    }, function (res) { 
      wx.stopPullDownRefresh()
      setTimeout(function () {  
        self.setData({
          readers: self.data.readers.concat(res.data.list),
          totalPage: res.data.totalPage,
          loading_hide: true
        })
      }, 500)
      //如果当前显示的是最后一页，则显示没数据提示
      if(self.data.page == self.data.totalPage) {
        self.setData({
          nodata_hide: false,
        })
      }
    })
  },

  //显示或隐藏查询视图切换
  toggleQueryViewHide: function () {
    this.setData({
      queryViewHidden: !this.data.queryViewHidden,
    })
  },

  //点击查询按钮的事件
  queryReader: function(e) {
    var self = this
    self.setData({
      page: 1,
      totalPage: null,
      readers: [],
      loading_hide: true, //隐藏加载动画
      nodata_hide: true, //隐藏没有数据记录提示 
      queryViewHidden: true, //隐藏查询视图
    })
    self.listReader()
  },

  //查询参数读者生日选择事件
  bind_birthday_change: function (e) {
    this.setData({
      birthday: e.detail.value
    })
  },
  //清空查询参数读者生日
  clear_birthday: function (e) {
    this.setData({
      birthday: "",
    })
  },

  //绑定查询参数输入事件
  searchValueInput: function (e) {
    var id = e.target.dataset.id
    if (id == "readerNo") {
      this.setData({
        "readerNo": e.detail.value,
      })
    }

    if (id == "readerName") {
      this.setData({
        "readerName": e.detail.value,
      })
    }

    if (id == "telephone") {
      this.setData({
        "telephone": e.detail.value,
      })
    }

  },

  //查询参数读者类型选择事件
  bind_readerTypeObj_change: function(e) {
    this.setData({
      readerTypeObj_Index: e.detail.value
    })
  },

  init_query_params: function() { 
    var self = this
    var url = null
    //初始化读者类型下拉框
    url = config.basePath + "api/readerType/listAll"
    utils.sendRequest(url,null,function(res){
      wx.stopPullDownRefresh();
      self.setData({
        readerTypes: self.data.readerTypes.concat(res.data),
      })
    })
  },

  //删除读者记录
  removeReader: function (e) {
    var self = this
    var readerNo = e.currentTarget.dataset.readerno
    wx.showModal({
      title: '提示',
      content: '确定要删除readerNo=' + readerNo + '的记录吗？',
      success: function (sm) {
        if (sm.confirm) {
          // 用户点击了确定 可以调用删除方法了
          var url = config.basePath + "api/reader/delete/" + readerNo
          utils.sendRequest(url, null, function (res) {
            wx.stopPullDownRefresh();
            wx.showToast({
              title: '删除成功',
              icon: 'success',
              duration: 500
            })
            //删除读者后客户端同步删除数据
            var readers = self.data.readers;
            for (var i = 0; i < readers.length; i++) {
              if (readers[i].readerNo == readerNo) {
                readers.splice(i, 1)
                break
              }
            }
            self.setData({ readers: readers })
          })
        } else if (sm.cancel) {
          console.log('用户点击取消')
        }
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.listReader()
    this.init_query_params()
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    var self = this
    self.setData({
      page: 1,  //显示最新的第1页结果
      readers: [], //清空读者数据
      nodata_hide: true, //隐藏没数据提示
    })
    self.listReader()
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    var self = this
    if (self.data.page < self.data.totalPage) {
      self.setData({
        page: self.data.page + 1, 
      })
      self.listReader()
    }
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }

})

