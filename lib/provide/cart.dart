import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_shop/model/cartInfo.dart';


class CartProvide with ChangeNotifier{
  String cartString ="[]";
  List<CartInfoModel> cartList=[];
  double allPrice=0;//总价格
  int allGoodsCount=0;//总数量
  bool isAllCheck=true;//是否全选


  save(goodsId,goodsName,count,price,images)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    cartString=prefs.getString("cartInfo");
    var temp=cartString==null?[]:jsonDecode(cartString.toString());
    List<Map> tempList=(temp as List).cast();
    bool isHave=false;
    int ival=0;
    allGoodsCount=0;
    allPrice=0;
    tempList.forEach((item){
      if(item["goodsId"]==goodsId){
        tempList[ival]["count"]=item["count"]+1;
        cartList[ival].count++;
        isHave=true;
      }
      if(item["isCheck"]){
        allPrice+=(cartList[ival].price*cartList[ival].count);
        allGoodsCount+=cartList[ival].count;
      }
      ival++;
    });

    if(!isHave){
      Map<String,dynamic> newGoods={
        "goodsId":goodsId,
        "goodsName":goodsName,
        "count":count,
        "price":price,
        "images":images,
        "isCheck":true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      allPrice+=count*price;
      allGoodsCount+count;
    }

    cartString=json.encode(tempList).toString();
    print("11111111111111${cartString}");
    print("2222222${cartList.toString()}");
    prefs.setString("cartInfo", cartString);

    notifyListeners();
  }

  remove() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove("cartInfo");
    cartList=[];
    print("清空？？？？？？？？？？？");
    notifyListeners();
  }

  getCartInfo() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    cartString=prefs.getString("cartInfo");
    cartList=[];
    if(cartString==null){
      cartList=[];
    }else{
      List<Map> tempList=(json.decode(cartString.toString())as List).cast();
      allPrice=0;
      allGoodsCount=0;
      isAllCheck=true;
      tempList.forEach((item){
        if(item["isCheck"]){
          allPrice+=(item["count"]*item["price"]);
          allGoodsCount+=item["count"];
        }else{
          isAllCheck=false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }



  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex =0;
    int delIndex=0;
    tempList.forEach((item){

      if(item['goodsId']==goodsId){
        delIndex=tempIndex;

      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);//
    await getCartInfo();
  }

  changeCheckState(CartInfoModel cartItem)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex=0;
    int changeIndex=0;
    tempList.forEach((item){
      if(item["goodsId"]==cartItem.goodsId){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex]=cartItem.toJson();
    cartString=json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();
  }


  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList=[]; //新建一个List，用于组成新的持久化数据。
    for(var item in tempList ){
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck']=isCheck; //改变选中状态
      newList.add(newItem);
    }

    cartString= json.encode(newList).toString();//形成字符串
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();

  }

  //商品数量加减
  addOrReduceAction(var cartItem,String todo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex=0;
    int changeIndex=0;
    tempList.forEach((item){
      if(item["goodsId"]==cartItem.goodsId){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });

    if(todo=="add"){
      cartItem.count++;
    }else if(cartItem.count>1){
      cartItem.count--;
    }
    tempList[changeIndex]=cartItem.toJson();
    cartString=json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);
    await getCartInfo();
  }


}