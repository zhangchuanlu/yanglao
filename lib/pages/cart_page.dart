import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future:_getCartInfo(context),
        builder: (context,snapshot){
          List cartList=Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData && cartList!=null){
            return Stack(
              children: <Widget>[
                //主要代码--------------------start--------
                Provide<CartProvide>(
                    builder: (context,child,childCategory){
                      cartList= Provide.value<CartProvide>(context).cartList;
                      print(cartList);
                      return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context,index){
                          return CartItem(cartList[index]);
                        },
                      );
                    }
                ),
                //主要代码------------------end---------
                Positioned(
                  bottom:0,
                  left:0,
                  child: CartBottom(),
                )
              ],
            );


          }else{
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }


}



