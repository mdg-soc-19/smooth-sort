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
        listType: 'list',
        itemList: [
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: Text(
              "A",
              style: TextStyle(fontSize: 150.0),
            ),
          ),
          Container(
            color: Colors.blueAccent,
            alignment: Alignment.center,
            child: Text(
              "B",
              style: TextStyle(fontSize: 150.0),
            ),
          ),
          Container(
            color: Colors.yellowAccent,
            alignment: Alignment.center,
            child: Text(
              "C",
              style: TextStyle(fontSize: 150.0),
            ),
          ),
        ],
        itemIdList: [1, 2, 0],
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
