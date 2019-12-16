import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  List<String> _data = [
    'Horse',
    'Cow',
    'Camel',
    'Sheep',
    'Goat',
    'Help',
    'Guide',
    'Hello',
    'Ihdid'
  ];

  SmoothSort smoothSort;

  @override
  void initState() {
    super.initState();

    smoothSort = SmoothSort(
        listType: 'list',
        itemList: [
          Card(
            child: Text(
                "Hello",
            ),
          ),
          FlutterLogo(),
          Container(
            margin: EdgeInsets.all(10.0),
            height: 150.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              gradient: LinearGradient(
                colors: [Colors.yellow[700], Colors.redAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp)
            ),
            child: ListTile(
              title: Text(
                "Hello",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
        itemIdList: [2, 1, 0],
        animationType: 'cardScale');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Column(
        children: <Widget>[
          smoothSort,
          RaisedButton(
            child: Text("Sort"),
            onPressed: () {
              smoothSort.onPress();
            },
          )
        ],
      ),
    );
  }
}
