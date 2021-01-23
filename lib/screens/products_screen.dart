import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/single_product_adim_view.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var products;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (products == null) {
      products = Provider.of<Products>(context, listen: true);
      products.fechAndDecode();
    }
    super.didChangeDependencies();
  }

  void call() async {
    setState(() {
      _isLoading = true;
    });
    products = Provider.of<Products>(context, listen: true);
    await products.fechAndDecode();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var productsData = products.items();
    if (productsData.isEmpty) {
      call();
    }
    return LayoutBuilder(builder: (ctx, constrants) {
      return productsData.isEmpty
          ? Container(
              height: MediaQuery.of(context).size.height * (7 / 9),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/assets/images/noproduct.jpg'))),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: constrants.maxHeight * 1,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      //  print(index);
                      return ProductViewAdmin(productsData[index]);
                    },
                    itemCount: products.length(),
                  ),
                ),
              ],
            );
    });
  }
}
