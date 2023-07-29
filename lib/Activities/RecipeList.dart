import 'package:flutter/material.dart';
import 'package:food_mania/Workings/RecipeModal.dart';
import 'package:food_mania/Workings/ScreenResolutionPercents.dart';
import 'RecipeView.dart';
import 'dart:math';
class RecipeList extends StatefulWidget
{
  List<RecipeModal> recipes = [];
  String title;

  RecipeList(this.recipes, this.title);
  // RecipeList()

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: heightPercent(context, 3.5)),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: widget.recipes.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Align: Alignment.topCenter;
                    return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Recipe(widget.recipes[index].appUrl)));
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: heightPercent(context, 2.5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    widget.recipes[index].imageUrl,
                                    fit: BoxFit.cover,
                                    width: widthPercent(context, 100),
                                    height: heightPercent(context, 25),
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                Positioned( //label
                                  width: widthPercent(context, 80),
                                  left: widthPercent(context, 3),
                                  bottom: heightPercent(context, 1.2),

                                  child: Text(widget.recipes[index].label, style: TextStyle(
                                    backgroundColor: Theme.of(context).backgroundColor == Color(0xff616161)? Theme.of(context).backgroundColor.withOpacity(.5) : Colors.white.withOpacity(.5), //checking if color is black or not
                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                    fontSize: averagePercent(context, 3),
                                    fontStyle: FontStyle.italic,
                                  )

                                  ),),
                                Positioned( //calories
                                  right: widthPercent(context, 3),
                                  top: heightPercent(context, 1.2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor == Color(0xff616161)? Theme.of(context).backgroundColor.withOpacity(.5) : Colors.white.withOpacity(.5),
                                    ),
                                    child: Row(

                                      children: [
                                        Icon(Icons.local_fire_department_outlined,
                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                        ),
                                        Text(widget.recipes[index].calories.substring(0,min(6, widget.recipes[index].calories.length)), style: TextStyle(
                                          // backgroundColor: Theme.of(context).backgroundColor.withOpacity(.4),
                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                          fontSize: averagePercent(context, 3),
                                          fontStyle: FontStyle.italic,
                                        )

                                        ),
                                      ],
                                    ),
                                  ),),
                              ],

                            )));
                  }),
            ],
          )
        ),
      ),
    );
  }
}


