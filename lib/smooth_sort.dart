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

  AnimationController _listFadeAnimationController, _newListFadeAnimationController;

  AnimationController _listScaleAnimationController, _newListScaleAnimationController;

  Animation<double> _flipX;
  Animation<double> _flipY;

  Animation<Offset> _listSlideRight, _newListSlideRight, _listPositionRight;
  Animation<Offset> _listSlideLeft, _newListSlideLeft, _listPositionLeft;

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

    _listFadeAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _newListFadeAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _listScaleAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000), value: 1);

    _newListScaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
      value: 1
    );

    _flipX =
        Tween<double>(begin: -0.5, end: 0).animate(_flipXAnimationController);

    _flipY =
        Tween<double>(begin: -0.5, end: 0).animate(_flipYAnimationController);

    _listSlideRight = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _newListSlideRight = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _listSlideLeft = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_slideAnimationController);

    _newListSlideLeft = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _fadeOut =
        Tween<double>(begin: 0.0, end: 1.0).animate(_listFadeAnimationController);

    _fadeIn = Tween<double>(begin: 1.0, end: 0.0)
        .animate(_newListFadeAnimationController);

    _positiveScale =
        Tween<double>(begin: 0.0, end: 1.0).animate(_listScaleAnimationController);

    __negativeScale =
        Tween<double>(begin: 1.0, end: 0.0).animate(_newListScaleAnimationController);

    _listPositionRight = _listSlideRight;
    _listPositionLeft = _listSlideLeft;
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
              return Transform(
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

      case 'cardSlideRight':
        {
          return SlideTransition(
            position: _listPositionRight,
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
        }
        break;

      case 'textSlideRight':
        {
          return Container(
            margin: EdgeInsets.all(10.0),
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.red),
            child: SlideTransition(
              position: _listPositionRight,
              child: ListTile(
                title: Text(
                  item,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          );
        }
        break;

      case 'cardSlideLeft':
        {
          return SlideTransition(
            position: _listPositionLeft,
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
        }
        break;

      case 'cardFade':
        {
          return FadeTransition(
            opacity: _listFadeValue,
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
        }
        break;

      case 'textFade':
        {
          return Container(
              margin: EdgeInsets.all(10.0),
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Colors.red),
              child: FadeTransition(
                opacity: _listFadeValue,
                child: ListTile(
                  title: Text(
                    item,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
        }
        break;

      case 'cardScale':
        {
          return ScaleTransition(
            scale: _listScaleValue,
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
        }
        break;

      case 'textScale':
        {
          return Container(
            margin: EdgeInsets.all(10.0),
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.red
            ),
            child: ScaleTransition(
              scale: _listScaleValue,
              child: ListTile(
                title: Text(
                  item,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            )
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

      case 'cardSlideRight':
        {
          await _slideAnimationController.reverse();

          setState(() {
            _data.sort();
            _listPositionRight = _newListSlideRight;
          });

          await _slideAnimationController.forward();
        }
        break;

      case 'textSlideRight':
        {
          await _slideAnimationController.reverse();

          setState(() {
            _data.sort();
            _listPositionRight = _newListSlideRight;
          });

          await _slideAnimationController.forward();
        }
        break;

      case 'cardSlideLeft':
        {
          await _slideAnimationController.reverse();

          setState(() {
            _data.sort();
            _listPositionLeft = _newListSlideLeft;
          });

          await _slideAnimationController.forward();
        }
        break;

      case 'cardFade':
        {
          await _listFadeAnimationController.reverse();

          setState(() {
            _data.sort();
            _listFadeValue = _fadeIn;
          });

          await _newListFadeAnimationController.reverse();
        }
        break;

      case 'textFade':
        {
          await _listFadeAnimationController.reverse();

          setState(() {
            _data.sort();
            _listFadeValue = _fadeIn;
          });

          await _newListFadeAnimationController.reverse();
        }
        break;

      case 'cardScale':
        {
          await _listScaleAnimationController.reverse();

          setState(() {
            _data.sort();
            _listScaleValue = __negativeScale;
          });

          await _newListScaleAnimationController.reverse();
        }
        break;

      case 'textScale':
        {
          await _listScaleAnimationController.reverse();

          setState(() {
            _data.sort();
            _listScaleValue = __negativeScale;
          });

          await _newListScaleAnimationController.reverse();
        }
        break;

      default:
        {}
    }
  }
}
