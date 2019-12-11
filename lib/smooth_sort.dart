library smooth_sort;

import 'package:flutter/material.dart';

class SmoothSort extends RefreshIndicator{
  const SmoothSort({
    Key key,
    Widget child,
    RefreshCallback onRefresh,
  }) : super(key: key, child: child, onRefresh: onRefresh);
}