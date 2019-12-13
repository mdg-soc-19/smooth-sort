import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
class BodyWidgetState extends State<BodyWidget> with TickerProviderStateMixin{

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  bool _flag = true;
  List<String> _data = ['Horse', 'Cow', 'Camel', 'Sheep', 'Goat', 'Help', 'Guide', 'Hello', 'Ihdid'];

  AnimationController animationController;
  Animation animation;
  Animation<double> _offset;
  LinearGradient linearGradient;
  Color shadowColor;

  BodyWidgetState() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        value: 1
    );

    _offset = Tween<double>(
        begin: -0.5,
        end: 0
    ).animate(animationController);

    linearGradient = LinearGradient(
        colors: [Colors.yellow[700], Colors.redAccent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        tileMode: TileMode.clamp
    );

    shadowColor = Colors.red;

  }

  /// For animated list
//  AnimatedList(
//  key: _listKey,
//  initialItemCount: _data.length,
//  itemBuilder: (context, index, animation) {
//  return _buildItem(_data[index], animation, index);
//  },
//  ),

  /// For GridView
//  GridView.builder(
//  itemCount: _data.length,
//  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//  itemBuilder: (BuildContext context, int index) {
//  return _buildItem(_data[index], animation, index);
//  },
//  )

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 520,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_data[index], animation, index);
              },
            ),
          ),
          RaisedButton(
            child: Text("Sort"),
            onPressed: () {
              _sortList();
            },
          )
        ],
      ),
    );
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0002)
            ..rotateX(pi * _offset.value),
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(10.0),
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                gradient: linearGradient
            ),
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  void _sortList() async{


    if (_flag) {

      await animationController.reverse();


      setState(() {
//          List<String> _newData = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
        _data.sort();
        linearGradient = LinearGradient(
            colors: [Colors.blueAccent, Colors.yellow],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp
        );
        shadowColor = Colors.yellow;
//          _data = _newData;
      });


      await animationController.forward();
    }else {

      await animationController.reverse();


      setState(() {
//          List<String> _newData = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
        _data.sort();
        linearGradient = LinearGradient(
            colors: [Colors.yellow[700], Colors.redAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp
        );
        shadowColor = Colors.redAccent;
//          _data = _newData;
      });


      await animationController.forward();

    }

    _flag = !_flag;

  }

  void _removeItem(int index){

    _listKey.currentState.removeItem(
        index,
            (BuildContext context, Animation animation) => _buildItem(_data[index], Tween(begin: 0.5, end: 1.0).animate(animationController), index),
        duration: Duration(milliseconds: 0)
    );

  }
}
