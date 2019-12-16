# <div align="center">Smooth Sort</div>

<div align="center">A wonderful and custom sorting animation for Flutter.</div>
<div align="center">In today's world, developer's use now and then sorting in their mobile applications. For such developer's, Smooth Sort can become a useful package which provides wonderful and custom animation while sorting a list instead of reloading the app.</div>

# Table of Contents
* [Demo](#demo)
* [Usage](#usage)
* [Documentation](#documentation)
* [Algorithm](#algorithm)
* [Bugs or Requests](#bugs-or-requests)
* [License](#license)

# Demo
<div align="center">
<table>
<tr>
<td>
<div align="center">Card Slide Right</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/cardSlideRight.gif" height = "400px"/>  
</td>
<td>
<div align="center">Card Flip Vertcially</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/flipVertically.gif" height = "400px"/>  
</td>
<td>
<div align="center">Card Scale</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/cardScale.gif" height = "400px"/>  
</td>
</tr>
<tr>
<td>
<div align="center">Card Slide Left</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/cardSlideLeft.gif" height = "400px"/>  
</td>
<td>
<div align="center">Card Flip Horizontally</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/flipHorizontally.gif" height = "400px"/>  
</td>
<td>
<div align="center">Card Fade</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/cardFade.gif" height = "400px"/>  
</td>
</tr>
<tr>
<td>
<div align="center">Text Slide Right</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/textSlideRight.gif" height = "400px"/>  
</td>
<td>
<div align="center">Text Fade</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/textFade.gif" height = "400px"/>  
</td>
<td>
<div align="center">Text Scale</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/textScale.gif" height = "400px"/>  
</td>
</tr>
<tr>
<td>
<div align="center">Text Slide Left</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/textSlideLeft.gif" height = "400px"/>  
</td>
<td>
<div align="center">Reverse Card Flip Vertcially</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/reverseFlipVertically.gif" height = "400px"/>  
</td>
<td>
<div align="center">Reverse Card Flip Horizontally</div>
<br>
<img src="https://raw.githubusercontent.com/mdg-soc-19/smooth-sort/master/smoothSortScreenshots/reverseFlipHorizontally.gif" height = "400px"/>  
</td>
</tr>
</table>
</div>

# Usage
For adding the SmoothSort in your Flutter app, you have to simply provide the options for ListView or GridView with the input list of strings. Also you can select the animationType, cardColor, linearGradient for card, borderRadius etc.

For example:
First create the object for SmoothSort 
```dart
SmoothSort smoothSort = SmoothSort(
	listType: 'list',	// specify the listType i.e. list or grid
	data: _data,	// list of strings
	animationType: 'reverseFlipHorizontally',	// specify the type of animation you want
	cardColor: Colors.green,	// give the color to the card if you want
	linearGradient: LinearGradient(  
		    colors: [Colors.yellow[700], Colors.redAccent],  
			begin: Alignment.centerLeft,  
			end: Alignment.centerRight,  
			tileMode: TileMode.clamp
		),	// give the changing color to the card 
	cardBorderRadius: BorderRadius.all(Radius.circular(35.0)),	// border radius for the card
	cardMargin: EdgeInsets.all(10.0)	// margin for the card
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
    smoothSort.onPress();  
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
| data                                | List&lt;String&gt;                      | The list of string which is to be sorted. |         @required         |
| cardColor                           | Color                      | Specifies the color of the Card in the list/grid. |          Colors.red          |
| linearGradient            | LinearGradient                        | Smooth Transition color for the card.             |         null          |
| cardBorderRadius                                 | BorderRadius                       | Specifies the border radius for the card.                   | BorderRadius.all(Radius.circular(15.0)) |
| cardMargin                       | EdgeInsets                       | Provides the margin for the card.                   | EdgeInsets.all(10.0) |
| cardHeight                 | double | Specifies the height for the card. |         150.0          |
| cardWidth                      | double            | Specifies the width for the card.                             |         Width of the screen          |

For help on editing package code, view the [flutter documentation](https://flutter.io/developing-packages/).

# Algorithm
The algorithm used to build this project is as follows:

I have sorted the ListView or GridView with single TextView by using the default sort function by Dart language. On clicking of the sort button, I have provided different animations to the ListView or GridView according to the animation described by the user. 

For more info, please refer to the  `smooth_sort.dart`.

# Bugs or Requests  
  
If you encounter any problems feel free to open an issue. If you feel the library is  
missing a feature, please raise a ticket on Github and I'll look into it.  
Pull request are also welcome.  

# License

SmoothSort is licensed under `MIT license`. View [license](https://github.com/mdg-soc-19/smooth-sort/blob/master/LICENSE).
