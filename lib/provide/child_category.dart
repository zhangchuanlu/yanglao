import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList=[];
  int childIndex=0;
  String categoryId="4";//大类的ID
  String subId="";//小类ID
  int page=1;//列表页数
  String noMoreText="";//显示没有数据的文字

  getChildCategory(List<BxMallSubDto> list,String id){
    page=1;
    noMoreText="";
    childIndex=0;
    categoryId=id;
    BxMallSubDto all=BxMallSubDto();
    all.mallSubId='';
    all.mallCategoryId='00';
    all.comments='null';
    all.mallSubName='全部';
    childCategoryList=[all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changChildIndex(index,String id){
    page=1;
    noMoreText="";
    subId=id;
    childIndex=index;
    notifyListeners();
  }


  //增加page的方法
  addPage(){
    page++;
  }

  changNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }
}