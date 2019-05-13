//接口管理类
const serviceUrl = 'http://v.jspang.com:8088/baixing/';
const servicePath = {
  'homePageContent': serviceUrl + 'wxmini/homePageContent', //商家首页信息
  'homePageBelowConten': serviceUrl + 'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  'getCategory': serviceUrl + 'wxmini/getCategory', //商品类别信息
  'getMallGoods': serviceUrl + 'wxmini/getMallGoods', //商品分类的商品列表
};
