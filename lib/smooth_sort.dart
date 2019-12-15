library smooth_sort;

import 'package:flutter/material.dart';

import 'dart:math';

class SmoothSort extends StatefulWidget {
  String listType;
  String animationType;
  List<String> data;

  SmoothSort(
      {Key key,
      this.listType = 'list',
      this.animationType = 'flipVertically',
      @required this.data});

  _SmoothSortState __smoothSortState = _SmoothSortState();

  @override
  _SmoothSortState createState() => __smoothSortState;

  void onPress() {
    __smoothSortState.sortList();
  }
}

class _SmoothSortState extends State<SmoothSort>
    with TickerProviderStateMixin<SmoothSort> {
  GlobalKey<AnimatedListState> _listkey;

  AnimationController _flipXAnimationController;
  AnimationController _flipYAnimationController;

  AnimationController _slideAnimationController;

  AnimationController _fadeAnimationController;

  AnimationController _scaleAnimationController;

  Animation<double> _flipX;
  Animation<double> _flipY;

  Animation<Offset> _listSlideRight, _newListSlideRight, _listPosition;

  Animation<double> _fadeIn, _fadeOut, _listFadeValue;

  Animation<double> _positiveScale, __negativeScale, _listScaleValue;

  List<String> _data;

  @override
  void initState() {
    super.initState();

    _data = widget.data;

    _listkey = GlobalKey();

    _flipXAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _flipYAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _slideAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _fadeAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _scaleAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1);

    _flipX =
        Tween<double>(begin: -0.5, end: 0).animate(_flipXAnimationController);

    _flipY =
        Tween<double>(begin: -0.5, end: 0).animate(_flipYAnimationController);

    _listSlideRight = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(_slideAnimationController);

    _newListSlideRight = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _fadeOut =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeAnimationController);

    _fadeIn =
        Tween<double>(begin: 1.0, end: 0.0).animate(_fadeAnimationController);

    _positiveScale =
        Tween<double>(begin: 0.0, end: 1.0).animate(_scaleAnimationController);

    __negativeScale =
        Tween<double>(begin: 1.0, end: 0.0).animate(_scaleAnimationController);

    _listPosition = _listSlideRight;
    _listFadeValue = _fadeOut;
    _listScaleValue = _positiveScale;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: (widget.listType == 'list')
          ? AnimatedList(
              key: _listkey,
              initialItemCount: _data.length,
              itemBuilder: (context, index, animation) {
                return buildListItem(_data[index], animation, index);
              },
            )
          : GridView.builder(
              itemCount: _data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return buildListItem(_data[index], null, index);
              },
            ),
    );
  }

  Widget buildListItem(String item, Animation animation, int index) {
    switch (widget.animationType) {
      case 'flipVertically':
        {
          return AnimatedBuilder(
            animation: _flipX,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateX(pi * _flipX.value),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.red),
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
        break;

      case 'flipHorizontally':
        {
          return AnimatedBuilder(
            animation: _flipY,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateY(pi * _flipY.value),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.red),
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
        break;

      case 'reverseFlipVertically':
        {
          return AnimatedBuilder(
            animation: _flipX,
            builder: (BuildContext context, Widget child) {
              return   Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateX(-1 * pi * _flipX.value),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.red
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
        break;

      case 'reverseFlipHorizontally':
        {
          return AnimatedBuilder(
            animation: _flipY,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateY(-1 * pi * _flipY.value),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.red
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
        break;

      case 'slideRight':
        {
          return SlideTransition(
            position: _listPosition,
            child: Container(
              margin: EdgeInsets.all(10.0),
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.red
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
        break;

      default:
        {
          return Container(
            child: ListTile(
              title: Text("Hello"),
            ),
          );
        }
    }
  }

  void sortList() async {
    switch (widget.animationType) {
      case 'flipVertically':
        {
          await _flipXAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipXAnimationController.forward();
        }
        break;

      case 'flipHorizontally':
        {
          await _flipYAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipYAnimationController.forward();
        }
        break;

      case 'reverseFlipVertically':
        {
          await _flipXAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipXAnimationController.forward();
        }
        break;

      case 'reverseFlipHorizontally':
        {
          await _flipYAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipYAnimationController.forward();
        }
        break;

      case 'slideRight':
        {
          await _slideAnimationController.reverse();

          setState(() {
            _data.sort();
            _listPosition = _newListSlideRight;
          });

          _slideAnimationController.reset();
          await _slideAnimationController.forward();

        }
        break;

      default:
        {}
    }
  }
}
