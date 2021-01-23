import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/providers/admin.dart';
import '../providers/products.dart' show Product;
import '../screens/overview_of_food.dart';
import '../screens/overiew_of_food2.dart';

class ProductViewAdmin extends StatefulWidget {
  final Product myProduct;
  const ProductViewAdmin(this.myProduct);
  @override
  _ProductViewAdminState createState() => _ProductViewAdminState();
}

class _ProductViewAdminState extends State<ProductViewAdmin> {
  var _isPressend = false;
  void product_details(context) {
    if (a.isAdmin) {
      Navigator.pushNamed(context, OverviewProductAdmin.routeName,
          arguments: widget.myProduct);
    } else {
      Navigator.pushNamed(context, OverviewProductUser.routeName,
          arguments: widget.myProduct);
    }
  }

  IsAdmin a;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    a = Provider.of<IsAdmin>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    // print("image url is ");
    //print(widget.myProduct.imageUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("entered");
    return InkWell(
      onTap: () => product_details(context),
      highlightColor: Colors.yellow[500],
      child: Stack(alignment: Alignment.centerRight, children: [
        LayoutBuilder(
          builder: (ctx, constriants) => Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.fromLTRB(20, 10, 35, 10),
            child: Container(
              //margin: EdgeInsets.all(20),
              color: Colors.white,
              height: 180,
              width: constriants.maxWidth - 42,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Icon(
                      Icons.loyalty_rounded,
                      size: 30,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      //color: _isPressend ? Colors.yellow[600] : Colors.white,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        widget.myProduct.title,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text("\$ ${widget.myProduct.price.toString()}",
                          style: TextStyle(
                              color: Color.fromRGBO(135, 135, 135, 0.7),
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: constriants.maxWidth / 3,
                      decoration: BoxDecoration(
                          color: Colors.yellow[600],
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(10))),
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        LayoutBuilder(
            builder: (ctx, constriants) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.myProduct.imageUrl,
                          ),
                          fit: BoxFit.fill)),
                  height: 150,
                  width: constriants.maxWidth / 2,
                )),
      ]),
    );
  }
}
