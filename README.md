<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/smooth_sort_cover.png" />

<div align="center">  
  <a href="https://flutter.io">  
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"  
      alt="Platform" />  
  </a>  
  <a href="https://opensource.org/licenses/MIT">  
    <img src="https://img.shields.io/badge/License-MIT-red.svg"  
      alt="License: MIT" />  
  </a>  
  <a href="https://pub.dev/packages/smooth_sort">  
    <img src="https://img.shields.io/pub/v/smooth_sort.svg"  
      alt="Pub Package" />  
  </a>  
</div> 

</br>  

In today's world, developer's use now and then sorting in their mobile applications. For such developer's, Smooth Sort can become a useful package which provides wonderful and custom animation while sorting a list instead of reloading the app.

Explore how to use SmoothSort in your Flutter app through this [medium blog](https://medium.com/mobile-development-group/smooth-sort-a-flutter-package-for-wonderful-sorting-animation-b3d3b56a4d7b).

# Table of Contents
* [Installing](#installing)
* [Demo](#demo)
* [Usage](#usage)
* [Documentation](#documentation)
* [Algorithm](#algorithm)
* [Bugs or Requests](#bugs-or-requests)
* [License](#license)

# Installing
### 1. Depend on it

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  smooth_sort: ^1.0.1
```

### 2. Install it
You can install packages from the command line:

with Flutter:

```shell
$ flutter pub get
```
Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

### 3. Import it
Now in your Dart code, you can use:

```dart
import 'package:smooth_sort/smooth_sort.dart';
```
 

# Demo
<div align="center">
<table>
<tr>
<td>
<div align="center"><code>Flip Vertically</code></div>
<div align="center"><code>animationType: flipVertically</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/flipVertically.gif" height = "400px"/>  
</td>
<td>
<div align="center"><code>Fade</code></div>
<div align="center"><code>animationType: fade</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/fade.gif" height = "400px"/>  
</td>
<td>
<div align="center"><code>Slide Right</code></div>
<div align="center"><code>animationType: slideRight</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/slideRight.gif" height = "400px"/>  
</td>
</tr>
<tr>
<td>
<div align="center"><code>Flip Horizontally</code></div>
<div align="center"><code>animationType: flipHorizontally</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/flipHorizontally.gif" height = "400px"/>  
</td>
<td>
<div align="center"><code>Scale</code></div>
<div align="center"><code>animationType: scale</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/scale.gif" height = "400px"/>  
</td>
<td>
<div align="center"><code>Slide Left</code></div>
<div align="center"><code>animationType: slideLeft</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/slideLeft.gif" height = "400px"/>  
</td>
</tr>
<tr align="center">
<td>
<div align="center"><code>Reverse Flip Vertically</code></div>
<div align="center"><code>animationType: reverseFlipVertically</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/reverseFlipVertically.gif" height = "400px"/>  
</td>
<td>
<div align="center"><code>Reverse Flip Horizontally</code></div>
<div align="center"><code>animationType: reverseFlipHorizontally</code></div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortGifs/reverseFlipHorizontally.gif" height = "400px"/>  
</td>
</tr>
</table>
</div>

## Example in Medium blog
In the medium blog as well as the example app, I have implemented this animation for the shopping app for sorting the products through price using the Smooth Sort package.
<tr>
<td>
<div align="center"><code>Scale Animation</code></div>
<br>
<div align="center">
<img src="https://miro.medium.com/max/645/1*XXw6_7DBCmt9ULPy9DldGw.gif" height = "400px"/> 
</div>
</td>
</tr>

# Usage
For adding the SmoothSort in your Flutter app, you have to simply provide the options for ListView or GridView with the list of the widgets to be displayed in the list/grid with the another list of their corresponding itemIds.

For example:
First create the object for SmoothSort 
```dart
SmoothSort smoothSort = SmoothSort(
	listType: 'list',	 // specify the listType i.e. list or grid
	ascendant: true,	// sort ascending or descending
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
	],					// specify the list of widgets for the ListView/GridView
	itemIdList: [1, 2, 0],		// specify the corresponding ids for widgets	
	animationType: 'cardScale'	// specify the type of animation you want
);
```

Whenever you want to add the list or grid, just add the above widget as follows:
```dart
Column(  
  children: <Widget>[  
    smoothSort	// just add the SmoothSort object
  ],
),
```

After this, just call the `smoothSort.onPress()` method to start the animation for sorting the list/grid just like this:
```dart
RaisedButton(  
  child: Text("Sort"),  
  onPressed: () {  
    smoothSort.onPress();	// just call the onPress method
  },  
)
```
For more info, please refer to the  `main.dart`  in example.

# Documentation

### SmoothSort Class

| Dart attribute                        | Datatype                    | Description                                                  |     Default Value     |
| :------------------------------------ | :-------------------------- | :----------------------------------------------------------- | :-------------------: |
| listType                                 | String                  | Specifies the type of list i.e. list/grid.               |       list       |
| animationType                             | String             | Specifies the type of animation required to sort the list/grid. |       flipVertically       |
| itemList                                | List&lt;Widget&gt;                      | The list of widgets which is to be sorted. |         @required         |
| itemIdList                           | List&lt;int&gt;                      | This list contains the ids for the corresponding widgets needed for the sorting of widgets. |          @required          |
| gridCrossAxisCount            | int                        | The number of grids in a single row in GridView.             |         2          |
| ascendant            | bool                        | Sort ascending or descending             |         true          |

For help on editing package code, view the [flutter documentation](https://flutter.io/developing-packages/).

# Algorithm
The algorithm used to build this project is as follows:

I have sorted the ListView or GridView with single TextView by using the default sort function by Dart language. On clicking of the sort button, I have provided different animations to the ListView or GridView according to the animation described by the user. 

For more info, please refer to the  `smooth_sort.dart`.

# Bugs or Requests  
  
If you encounter any problems feel free to open an issue. If you feel the library is  
missing a feature, please raise a ticket on Github and I'll look into it.  
Pull request are also welcome.  

# Contributors  

Thanks goes to these awesome people! :blush:

<table>
  <tr>
    <td align="center"><a href="https://github.com/albrecht99"><img src="https://avatars3.githubusercontent.com/u/40899882?s=400&u=8a8fa9a5fe3f883e9af17354a717308ef71157f1&v=4" width="100px;" alt=""/><br /><sub><b>Giulliano Albrecht</b></sub></a></td>
  </tr>
</table>

# License

SmoothSort is licensed under `MIT license`. View [license](https://github.com/mdg-soc-19/smooth-sort/blob/master/LICENSE).
