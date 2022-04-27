import 'package:carts1/cartScr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_Bloc.dart';

class ProductShowScreen extends StatelessWidget {
  ProductShowScreen({Key? key}) : super(key: key);

  // ProdHomeBloc prodBloc = ProdHomeBloc();

  // @override
  // void initState() {
  //   prodBloc = BlocProvider.of<ProdHomeBloc>(context, listen: false);
  //   prodBloc.add(FetchProdEvent());

  //   super.initState();
  // }
  final List catList = [
    {"id": 0, "name": "SILVER PLATED", "product": 245},
    {"id": 1, "name": "GERMAN SILVER", "product": 117},
    {"id": 3, "name": "COPPERWARE", "product": 36},
    {"id": 4, "name": "BRASS ITEMS", "product": 121},
    {"id": 5, "name": "POOJA MANDIR", "product": 25},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_bag))
          ],
        ),
        body: CustomScrollView(
          slivers: [
            //  ! SLIVER PRODUCT CONTENT
            SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
              return InkWell(
                  // onTap: () => navigationPush(
                  //     context, ProductDetailScr(prodNum: state.data[i])),
                  child: ProdContent(
                prodNum: catList[i],
              ));
            }, childCount: catList.length))
          ],
        ));
  }
}

// 1 Product
class ProdContent extends StatelessWidget {
  final dynamic prodNum;
  final List? cartData;
  ProdContent({Key? key, this.prodNum, this.cartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Color.fromARGB(255, 221, 214, 214))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('${prodNum['id']}'),
              Text('${prodNum['name']}'),
              Text('${prodNum['product']}'),
            ],
          ),
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                InkWell(
                    onTap: () {
                      // BlocProvider.of<LocalCartBloc>(context, listen: false)
                      //     .add(LocalCartItemAddEvent(
                      //   prodData: {},
                      //   context: context,
                      // ));
                      BlocProvider.of<LocalCartBloc>(context, listen: false)
                        ..add(LocalCartItemAddEvent(prodData: {
                          "id":prodNum['id'],
                          "name": prodNum['name'],
                          "quantity": prodNum['product']
                        }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 50,
                        padding: EdgeInsets.all(3),
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        // txtColor: offWhiteColor,
                        color: Colors.green,
                      ),
                    ))
              ]))
        ],
      ),
    );
  }
}
