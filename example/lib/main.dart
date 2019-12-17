import 'package:flutter/material.dart';
import 'package:smooth_sort/smooth_sort.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Update AnimatedList data')),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> with TickerProviderStateMixin {
  SmoothSort smoothSort;

  @override
  void initState() {
    super.initState();

    smoothSort = SmoothSort(
        listType: 'grid',
        itemList: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/shirt1.jpeg',
                  height: 140,
                ),
                Text("Peter England"),
                Text(
                  "Men Solid Formal Shirt",
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "        ₹499 ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    Text(
                      "999 ",
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "50% off",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/shirt3.jpeg',
                  height: 140,
                ),
                Text("Flying Machine"),
                Text(
                  "Men Solid Casual Spread Shirt",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "        ₹694 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    Text(
                      "900 ",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "40% off",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/shirt4.jpeg',
                  height: 140,
                ),
                Text("Raymond"),
                Text(
                  "Men Self Design Formal Shirt",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "        ₹749 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    Text(
                      "2499 ",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "70% off",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/shirt2.jpeg',
                  height: 140,
                ),
                Text("Highlander"),
                Text(
                  "Men Casual Regular Shirt",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "        ₹1019 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    Text(
                      "1699 ",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "40% off",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/shirt6.jpeg',
                  height: 140,
                ),
                Text("Van Heusen"),
                Text(
                  "Men Casual Shirt",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "        ₹1429 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    Text(
                      "2599 ",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "45% off",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/shirt5.jpeg',
                  height: 140,
                ),
                Text("Levis"),
                Text(
                  "Men Casual Cut Away Shirt",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "        ₹1499 ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                    Text(
                      "2999 ",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "50% off",
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
        itemIdList: [4, 5, 3, 2, 0, 1],
        animationType: 'scale');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Column(
        children: <Widget>[
          smoothSort,
          RaisedButton(
            child: Text("Sort By Price"),
            onPressed: () {
              smoothSort.onPress();
            },
          )
        ],
      ),
    );
  }
}
