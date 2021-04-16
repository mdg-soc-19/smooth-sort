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

  /// Keeps count for the number of grids in a single row
  ///
  /// default to 2
  final int gridCrossAxisCount;

  /// The list of widgets available for sorting
  final List<Widget> itemList;

  /// The boolean variable for the sorting ascendant or descendant
  ///
  /// default true
  final bool ascendant;

  /// The list of ids corresponding to the particular item which is useful for sorting the items
  final List<int> itemIdList;

  SmoothSort(
      {Key? key,
      this.listType = 'list',
      required this.itemList,
      required this.itemIdList,
      this.ascendant = true,
      this.animationType = 'flipVertically',
      this.gridCrossAxisCount = 2});

  final _SmoothSortState __smoothSortState = _SmoothSortState();

  @override
  _SmoothSortState createState() => __smoothSortState;

  void onPress() {
    __smoothSortState.sortList(ascendant);
  }
}

class _SmoothSortState extends State<SmoothSort>
    with TickerProviderStateMixin<SmoothSort> {
  /// GlobalKey for the list
  GlobalKey<AnimatedListState>? _listkey;

  /// AnimationController for the flipVertically animation
  late AnimationController _flipVerticallyAnimationController;

  /// AnimationController for the flipHorizontally animation
  late AnimationController _flipHorizontallyAnimationController;

  /// AnimationController for the slide animation
  late AnimationController _slideAnimationController;

  /// AnimationController for the fade animation
  late AnimationController _listFadeAnimationController,
      _newListFadeAnimationController;

  /// AnimationController for the scale animation
  late AnimationController _listScaleAnimationController,
      _newListScaleAnimationController;

  /// Tween object for vertical flip animation
  late Animation<double> _flipX;

  /// Tween object for horizontal flip animation
  late Animation<double> _flipY;

  /// Tween object for slideRight animation
  Animation<Offset>? _listSlideRight, _newListSlideRight, _listPositionRight;

  /// Tween object for slideLeft animation
  Animation<Offset>? _listSlideLeft, _newListSlideLeft, _listPositionLeft;

  /// Tween object for fade animation
  Animation<double>? _fadeIn, _fadeOut, _listFadeValue;

  /// Tween object for scale animation
  Animation<double>? _positiveScale, __negativeScale, _listScaleValue;

  @override
  void initState() {
    super.initState();

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
              initialItemCount: widget.itemList.length,
              itemBuilder: (context, index, animation) {
                return buildListItem(
                    widget.itemList[widget.itemIdList[index]], index);
              },
            )
          : GridView.builder(
              key: _listkey,
              itemCount: widget.itemList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridCrossAxisCount),
              itemBuilder: (BuildContext context, int index) {
                return buildListItem(
                    widget.itemList[widget.itemIdList[index]], index);
              },
            ),
    );
  }

  Widget buildListItem(Widget item, int index) {
    switch (widget.animationType) {
      // Widget for the vertically flipping animation
      case 'flipVertically':
        {
          return AnimatedBuilder(
            animation: _flipX,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateX(pi * _flipX.value),
                alignment: Alignment.center,
                child: Container(
                  child: item,
                ),
              );
            },
          );
        }

      // Widget for the horizontally flipping animation
      case 'flipHorizontally':
        {
          return AnimatedBuilder(
            animation: _flipY,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.00015)
                  ..rotateY(pi * _flipY.value),
                alignment: Alignment.center,
                child: Container(
                  child: item,
                ),
              );
            },
          );
        }

      // Widget for the reverse vertically flipping animation
      case 'reverseFlipVertically':
        {
          return AnimatedBuilder(
            animation: _flipX,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateX(-1 * pi * _flipX.value),
                alignment: Alignment.center,
                child: Container(
                  child: item,
                ),
              );
            },
          );
        }

      // Widget for the reverse horizontally flipping animation
      case 'reverseFlipHorizontally':
        {
          return AnimatedBuilder(
            animation: _flipY,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0002)
                  ..rotateY(-1 * pi * _flipY.value),
                alignment: Alignment.center,
                child: Container(
                  child: item,
                ),
              );
            },
          );
        }

      // Widget for the card right slide animation
      case 'slideRight':
        {
          return SlideTransition(
            position: _listPositionRight!,
            child: Container(
              child: item,
            ),
          );
        }

      // Widget for the card left slide animation
      case 'slideLeft':
        {
          return SlideTransition(
            position: _listPositionLeft!,
            child: Container(
              child: item,
            ),
          );
        }

      // Widget for the fading card animation
      case 'fade':
        {
          return FadeTransition(
            opacity: _listFadeValue!,
            child: Container(
              child: item,
            ),
          );
        }

      // Widget for the card scaling animation
      case 'scale':
        {
          return ScaleTransition(
            scale: _listScaleValue!,
            alignment: Alignment.center,
            child: Container(
              child: item,
            ),
          );
        }

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

  void sortList(bool ascendant) async {
    switch (widget.animationType) {
      // Implementation of sorting animation for vertically flipping animation
      case 'flipVertically':
        {
          await _flipVerticallyAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
            });
          }

          await _flipVerticallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for horizontally flipping animation
      case 'flipHorizontally':
        {
          await _flipHorizontallyAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
            });
          }

          await _flipHorizontallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for reverse vertically flipping animation
      case 'reverseFlipVertically':
        {
          await _flipVerticallyAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
            });
          }

          await _flipVerticallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for reverse horizontally flipping animation
      case 'reverseFlipHorizontally':
        {
          await _flipHorizontallyAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
            });
          }

          await _flipHorizontallyAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for card right slide animation
      case 'slideRight':
        {
          await _slideAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
              _listPositionRight = _newListSlideRight;
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
              _listPositionRight = _newListSlideRight;
            });
          }

          await _slideAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for card left slide animation
      case 'slideLeft':
        {
          await _slideAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
              _listPositionLeft = _newListSlideLeft;
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
              _listPositionLeft = _newListSlideLeft;
            });
          }

          await _slideAnimationController.forward();
        }
        break;

      // Implementation of sorting animation for card fading animation
      case 'fade':
        {
          await _listFadeAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
              _listFadeValue = _fadeIn;
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
              _listFadeValue = _fadeIn;
            });
          }

          await _newListFadeAnimationController.reverse();
        }
        break;

      // Implementation of sorting animation for card scaling animation
      case 'scale':
        {
          await _listScaleAnimationController.reverse();

          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
              _listScaleValue = __negativeScale;
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
              _listScaleValue = __negativeScale;
            });
          }

          await _newListScaleAnimationController.reverse();
        }
        break;

      default:
        {
          if (ascendant) {
            setState(() {
              widget.itemIdList.sort();
            });
          } else {
            setState(() {
              widget.itemIdList.sort((a, b) => b.compareTo(a));
            });
          }
        }
    }
  }
}
