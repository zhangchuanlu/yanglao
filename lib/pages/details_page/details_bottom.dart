import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_shop/provide/currentIndex.dart';


class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId=goodsInfo.goodsId;
    var goodsName=goodsInfo.goodsName;
    var count=1;
    var price=goodsInfo.presentPrice;
    var images=goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  height: ScreenUtil().setHeight(80),
                  alignment: Alignment.center,
                  child: Icon(CupertinoIcons.shopping_cart,size: 35,color: Colors.red,),
                ),
              ),
              Provide<CartProvide>(
                builder: (build,child,val){
                  int goodsCount=Provide.value<CartProvide>(context).allGoodsCount;
                  return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(width: 2,color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Text(
                        "${goodsCount}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(22)
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),

          InkWell(
            onTap: () async{
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text("加入购物车",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),),
            ),
          ),
          InkWell(
            onTap: ()async{
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text("立即购买",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),),
            ),
          )
        ],
      ),
    );
  }
}
