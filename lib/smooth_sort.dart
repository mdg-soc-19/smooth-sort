library smooth_sort;

import 'package:flutter/material.dart';

import 'dart:math';

/// The duration for the vertically flip animation
const _flipVerticallyDuration = Duration(milliseconds: 1000);

/// The duration for the horizontally flip animation
const _flipHorizontallyDuration = Duration(milliseconds: 1000);

/// The duration for the slide animation
const _slideDuration = Duration(milliseconds: 1000);

/// The duration for the fade animation
const _fadeDuration = Duration(milliseconds: 1000);

/// The duration for the scale animation
const _scaleDuration = Duration(milliseconds: 1000);

class SmoothSort extends StatefulWidget {
  /// The string for selecting the type of the list i.e. list or grid
  ///
  /// default to list
  final String listType;

  /// The string for selecting the type of the animation
  ///
  /// default to flipVertically
  final String animationType;

  /// The list of string which is to be sorted.
  final List<String> data;

  /// Specifies the color of the card
  ///
  /// default to Colors.red
  final Color cardColor;

  /// Describes the smooth Transition color for the card
  final LinearGradient linearGradient;

  /// Specifies the border radius for the card
  final BorderRadius cardBorderRadius;

  /// Provides the margin for the card
  final EdgeInsets cardMargin;

  /// Specifies the height for the card
  final double cardHeight;

  /// Specifies the width for the card
  final double cardWidth;

  SmoothSort(
      {Key key,
      this.listType = 'list',
      @required this.data,
      this.animationType = 'flipVertically',
      this.cardColor = Colors.red,
      this.linearGradient,
      this.cardBorderRadius,
      this.cardMargin,
      this.cardHeight,
      this.cardWidth});

  final _SmoothSortState __smoothSortState = _SmoothSortState();

  @override
  _SmoothSortState createState() => __smoothSortState;

  void onPress() {
    __smoothSortState.sortList();
  }
}

class _SmoothSortState extends State<SmoothSort>
    with TickerProviderStateMixin<SmoothSort> {
  /// GlobalKey for the list
  GlobalKey<AnimatedListState> _listkey;

  /// AnimationController for the flipVertically animation
  AnimationController _flipVerticallyAnimationController;

  /// AnimationController for the flipHorizontally animation
  AnimationController _flipHorizontallyAnimationController;

  /// AnimationController for the slide animation
  AnimationController _slideAnimationController;

  /// AnimationController for the fade animation
  AnimationController _listFadeAnimationController,
      _newListFadeAnimationController;

  /// AnimationController for the scale animation
  AnimationController _listScaleAnimationController,
      _newListScaleAnimationController;

  /// Tween object for vertical flip animation
  Animation<double> _flipX;

  /// Tween object for horizontal flip animation
  Animation<double> _flipY;

  /// Tween object for slideRight animation
  Animation<Offset> _listSlideRight, _newListSlideRight, _listPositionRight;

  /// Tween object for slideLeft animation
  Animation<Offset> _listSlideLeft, _newListSlideLeft, _listPositionLeft;

  /// Tween object for fade animation
  Animation<double> _fadeIn, _fadeOut, _listFadeValue;

  /// Tween object for scale animation
  Animation<double> _positiveScale, __negativeScale, _listScaleValue;

  List<String> _data;

  @override
  void initState() {
    super.initState();

    _data = widget.data;

    _listkey = GlobalKey();

    _flipVerticallyAnimationController = AnimationController(
        vsync: this, duration: _flipVerticallyDuration, value: 1);

    _flipHorizontallyAnimationController = AnimationController(
        vsync: this, duration: _flipHorizontallyDuration, value: 1);

    _slideAnimationController =
        AnimationController(vsync: this, duration: _slideDuration, value: 1);

    _listFadeAnimationController =
        AnimationController(vsync: this, duration: _fadeDuration, value: 1);

    _newListFadeAnimationController =
        AnimationController(vsync: this, duration: _fadeDuration, value: 1);

    _listScaleAnimationController =
        AnimationController(vsync: this, duration: _scaleDuration, value: 1);

    _newListScaleAnimationController =
        AnimationController(vsync: this, duration: _scaleDuration, value: 1);

    _flipX = Tween<double>(begin: -0.5, end: 0)
        .animate(_flipVerticallyAnimationController);

    _flipY = Tween<double>(begin: -0.5, end: 0)
        .animate(_flipHorizontallyAnimationController);

    _listSlideRight = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _newListSlideRight = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _listSlideLeft = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_slideAnimationController);

    _newListSlideLeft = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
        .animate(_slideAnimationController);

    _fadeOut = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_listFadeAnimationController);

    _fadeIn = Tween<double>(begin: 1.0, end: 0.0)
        .animate(_newListFadeAnimationController);

    _positiveScale = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_listScaleAnimationController);

    __negativeScale = Tween<double>(begin: 1.0, end: 0.0)
        .animate(_newListScaleAnimationController);

    _listPositionRight = _listSlideRight;
    _listPositionLeft = _listSlideLeft;
    _listFadeValue = _fadeOut;
    _listScaleValue = _positiveScale;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      width: MediaQuery.of(context).size.width,
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
      // Widget for the vertically flipping animation
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
                  margin: (widget.cardMargin != null)
                      ? widget.cardMargin
                      : EdgeInsets.all(10.0),
                  height:
                      (widget.cardHeight != null) ? widget.cardHeight : 150.0,
                  width: (widget.cardWidth != null)
                      ? widget.cardWidth
                      : MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: (widget.cardBorderRadius != null)
                          ? widget.cardBorderRadius
                          : BorderRadius.all(Radius.circular(15.0)),
                      color: widget.cardColor,
                      gradient: (widget.linearGradient != null)
                          ? widget.linearGradient
                          : null),
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

      // Widget for the horizontally flipping animation
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
                  margin: (widget.cardMargin != null)
                      ? widget.cardMargin
                      : EdgeInsets.all(10.0),
                  height:
                      (widget.cardHeight != null) ? widget.cardHeight : 150.0,
                  width: (widget.cardWidth != null)
                      ? widget.cardWidth
                      : MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: (widget.cardBorderRadius != null)
                          ? widget.cardBorderRadius
                          : BorderRadius.all(Radius.circular(15.0)),
                      color: widget.cardColor,
                      gradient: (widget.linearGradient != null)
                          ? widget.linearGradient
                          : null),
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

      // Widget for the reverse vertically flipping animation
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
                  margin: (widget.cardMargin != null)
                      ? widget.cardMargin
                      : EdgeInsets.all(10.0),
                  height:
                      (widget.cardHeight != null) ? widget.cardHeight : 150.0,
                  width: (widget.cardWidth != null)
                      ? widget.cardWidth
                      : MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: (widget.cardBorderRadius != null)
                          ? widget.cardBorderRadius
                          : BorderRadius.all(Radius.circular(15.0)),
                      color: widget.cardColor,
                      gradient: (widget.linearGradient != null)
                          ? widget.linearGradient
                          : null),
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

      // Widget for the reverse horizontally flipping animation
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
                  margin: (widget.cardMargin != null)
                      ? widget.cardMargin
                      : EdgeInsets.all(10.0),
                  height:
                      (widget.cardHeight != null) ? widget.cardHeight : 150.0,
                  width: (widget.cardWidth != null)
                      ? widget.cardWidth
                      : MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: (widget.cardBorderRadius != null)
                          ? widget.cardBorderRadius
                          : BorderRadius.all(Radius.circular(15.0)),
                      color: widget.cardColor,
                      gradient: (widget.linearGradient != null)
                          ? widget.linearGradient
                          : null),
                  child: ListTile(
                    title: Text(
                      item,
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          );
        }
        break;

      // Widget for the card right slide animation
      case 'cardSlideRight':
        {
          return SlideTransition(
            position: _listPositionRight,
            child: Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
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

      // Widget for the text right slide animation
      case 'textSlideRight':
        {
          return Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
              child: SlideTransition(
                position: _listPositionRight,
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

      // Widget for the card left slide animation
      case 'cardSlideLeft':
        {
          return SlideTransition(
            position: _listPositionLeft,
            child: Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
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

      // Widget for the text left slide animation
      case 'textSlideLeft':
        {
          return Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
              child: SlideTransition(
                position: _listPositionLeft,
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

      // Widget for the fading card animation
      case 'cardFade':
        {
          return FadeTransition(
            opacity: _listFadeValue,
            child: Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
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

      // Widget for the fading text animation
      case 'textFade':
        {
          return Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
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

      // Widget for the card scaling animation
      case 'cardScale':
        {
          return ScaleTransition(
            scale: _listScaleValue,
            alignment: Alignment.center,
            child: Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
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

      // Widget for the text scaling animation
      case 'textScale':
        {
          return Container(
              margin: (widget.cardMargin != null)
                  ? widget.cardMargin
                  : EdgeInsets.all(10.0),
              height: (widget.cardHeight != null) ? widget.cardHeight : 150.0,
              width: (widget.cardWidth != null)
                  ? widget.cardWidth
                  : MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: (widget.cardBorderRadius != null)
                      ? widget.cardBorderRadius
                      : BorderRadius.all(Radius.circular(15.0)),
                  color: widget.cardColor,
                  gradient: (widget.linearGradient != null)
                      ? widget.linearGradient
                      : null),
              child: ScaleTransition(
                scale: _listScaleValue,
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
      // Implementation of sorting animation for vertically flipping animation
      case 'flipVertically':
        {
          await _flipVerticallyAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipVerticallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for horizontally flipping animation
      case 'flipHorizontally':
        {
          await _flipHorizontallyAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipHorizontallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for reverse vertically flipping animation
      case 'reverseFlipVertically':
        {
          await _flipVerticallyAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipVerticallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for reverse horizontally flipping animation
      case 'reverseFlipHorizontally':
        {
          await _flipHorizontallyAnimationController.reverse();

          setState(() {
            _data.sort();
          });

          await _flipHorizontallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for card right slide animation
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

      // Implementation of sorting animation for text right slide animation
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

      // Implementation of sorting animation for card left slide animation
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

      // Implementation of sorting animation for text left slide animation
      case 'textSlideLeft':
        {
          await _slideAnimationController.reverse();

          setState(() {
            _data.sort();
            _listPositionLeft = _newListSlideLeft;
          });

          await _slideAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for card fading animation
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

      // Implementation of sorting animation for text fading animation
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

      // Implementation of sorting animation for card scaling animation
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

      // Implementation of sorting animation for text scaling animation
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
