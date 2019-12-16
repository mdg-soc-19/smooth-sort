import 'dart:math';

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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  bool _flag = true;
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

  AnimationController animationController;
  AnimationController _slideAnimationController1, _slideAnimationController2;
  AnimationController _fadeAnimationController1, _fadeAnimationController2;
  AnimationController _scaleAnimationController1, _scaleAnimationController2;
  Animation animation;
  Animation<double> _offset;
  Animation<Offset> _slide1, _slide2, slide;
  Animation<double> _fade1, _fade2, fade;
  Animation<double> _scale1, _scale2, scale;
  LinearGradient linearGradient;
  Color shadowColor;

  SmoothSort smoothSort;

  @override
  void initState() {
    super.initState();

    smoothSort = SmoothSort(
      listType: 'grid',
      data: ['Horse', 'Cow', 'Camel', 'Sheep', 'Goat', 'Help', 'Guide', 'Hello', 'Ihdid'],
      animationType: 'textScale'
    );

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _slideAnimationController1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _slideAnimationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _fadeAnimationController1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _fadeAnimationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _scaleAnimationController1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _scaleAnimationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _offset = Tween<double>(begin: -0.5, end: 0).animate(animationController);

    _slide1 = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(_slideAnimationController1);

    _slide2 = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(_slideAnimationController1);

    slide = _slide1;

    _fade1 =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeAnimationController1);

    _fade2 =
        Tween<double>(begin: 1.0, end: 0.0).animate(_fadeAnimationController2);

    fade = _fade1;

    _scale1 =
        Tween<double>(begin: 0.0, end: 1.0).animate(_scaleAnimationController1);

    _scale2 =
        Tween<double>(begin: 1.0, end: 0.0).animate(_scaleAnimationController2);

    scale = _scale1;

    linearGradient = LinearGradient(
        colors: [Colors.yellow[700], Colors.redAccent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        tileMode: TileMode.clamp);

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

  ///Flip opposite vertically
//  AnimatedBuilder(
//  animation: _offset,
//  builder: (BuildContext context, Widget child) {
//  return   Transform(
//  transform: Matrix4.identity()
//  ..setEntry(3, 2, 0.0002)
//  ..rotateX(- pi * _offset.value),
//  alignment: Alignment.center,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );
//  },
//  );

  ///Flip vertically
//  AnimatedBuilder(
//  animation: _offset,
//  builder: (BuildContext context, Widget child) {
//  return   Transform(
//  transform: Matrix4.identity()
//  ..setEntry(3, 2, 0.0002)
//  ..rotateX(pi * _offset.value),
//  alignment: Alignment.center,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );
//  },
//  );

  ///Flip opposite horizontally
//  AnimatedBuilder(
//  animation: _offset,
//  builder: (BuildContext context, Widget child) {
//  return Transform(
//  transform: Matrix4.identity()
//  ..setEntry(3, 2, 0.0002)
//  ..rotateY( - pi * _offset.value),
//  alignment: Alignment.center,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );
//  },
//  );

  ///Flip horizontally
//  AnimatedBuilder(
//  animation: _offset,
//  builder: (BuildContext context, Widget child) {
//  return Transform(
//  transform: Matrix4.identity()
//  ..setEntry(3, 2, 0.0002)
//  ..rotateY(pi * _offset.value),
//  alignment: Alignment.center,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );
//  },
//  );

  ///Slide Transition
//  SlideTransition(
//  position: slide,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );

  ///Fade Transition
//  FadeTransition(
//  opacity: fade,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );

  ///Text Fade Transition
//  Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient),
//  child: FadeTransition(
//  opacity: fade,
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  )
//  );

  ///Scale transition
//  ScaleTransition(
//  scale: scale,
//  alignment: Alignment.center,
//  child: Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  ),
//  );

  ///Text scale transition
//  Container(
//  margin: EdgeInsets.all(10.0),
//  height: 150,
//  alignment: Alignment.center,
//  decoration: BoxDecoration(
//  borderRadius: BorderRadius.all(Radius.circular(15.0)),
//  gradient: linearGradient
//  ),
//  child: ScaleTransition(
//  scale: scale,
//  child: ListTile(
//  title: Text(
//  item,
//  style: TextStyle(fontSize: 20),
//  textAlign: TextAlign.center,
//  ),
//  ),
//  )
//  );

  Widget _buildItem(String item, Animation animation, int index) {
    return SlideTransition(
      position: slide,
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
  }

  void _sortList() async {
    if (_flag) {
      await _slideAnimationController1.reverse();

      setState(() {
//          List<String> _newData = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
        _data.sort();
//        linearGradient = LinearGradient(
//            colors: [Colors.blueAccent, Colors.yellow],
//            begin: Alignment.centerLeft,
//            end: Alignment.centerRight,
//            tileMode: TileMode.clamp);
        shadowColor = Colors.yellow;
//          _data = _newData;
        slide = _slide2;
      });

      await _slideAnimationController1.reset();
      await _slideAnimationController1.forward();
    }
//    else {
//      await animationController.reverse();
//
//      setState(() {
////          List<String> _newData = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
//        _data.sort();
//        linearGradient = LinearGradient(
//            colors: [Colors.yellow[700], Colors.redAccent],
//            begin: Alignment.centerLeft,
//            end: Alignment.centerRight,
//            tileMode: TileMode.clamp);
//        shadowColor = Colors.redAccent;
////          _data = _newData;
//      });
//
//      await animationController.reverse();
//    }

    _flag = !_flag;
  }

  void _removeItem(int index) {
    _listKey.currentState.removeItem(
        index,
        (BuildContext context, Animation animation) => _buildItem(_data[index],
            Tween(begin: 0.5, end: 1.0).animate(animationController), index),
        duration: Duration(milliseconds: 0));
  }
}
