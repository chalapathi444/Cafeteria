import 'package:flutter/material.dart';
import '../screens/add_product_form.dart';

class AddProduct extends StatelessWidget {
  void add_form(BuildContext context) {
    Navigator.pushNamed(context, ProductForm.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) => (Center(
              child: Container(
                height: constraints.maxHeight / 8,
                width: constraints.maxWidth / 2,
                decoration: BoxDecoration(
                    color: Colors.yellow[900],
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  onTap: () => add_form(context),
                  child: Center(
                    child: Text(
                      "Add Food Item",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )));
  }
}
