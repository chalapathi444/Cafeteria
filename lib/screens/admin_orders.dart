import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/adminorders.dart';

class AdminOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AdminOrders adminObj = Provider.of<AdminOrders>(context, listen: true);
    var obj = Provider.of<Adminorders>(context, listen: true);
    obj.fetchAndDecode();
    List<Adminorder> list = obj.orders;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: 30,
            width: constraints.maxWidth,
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => obj.change(),
            ),
          ),
          Container(
            height: constraints.maxHeight - 40,
            child: ListView.builder(
              itemBuilder: (builder, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(list[index].imageUrl),
                          radius: 40,
                        ),
                        title: Text(
                          list[index].itemName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        subtitle: Text(
                            "Total amout is ${list[index].count * list[index].price}\n Employee Id : ${list[index].empId}"),
                        trailing: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(
                              Icons.fastfood,
                              size: 40,
                            ),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pink[900]),
                              child: Center(
                                  child: Text(
                                "${list[index].count}",
                                style: TextStyle(color: Colors.white),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: list.length,
            ),
          ),
        ],
      );
    });
  }
}
