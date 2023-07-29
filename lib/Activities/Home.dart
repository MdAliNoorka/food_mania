import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_mania/Activities/RecipeList.dart';
import 'package:food_mania/Workings/ScreenResolutionPercents.dart';
import 'package:food_mania/Workings/RecipeModal.dart';
import 'package:http/http.dart';
import 'RecipeView.dart';
class CategoryData {
  late String categoryType;
  late String location;
  late String category;
  CategoryData(this.categoryType, this.category , this.location);
}
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variables
  TextEditingController searchController = new TextEditingController();
  FocusNode searchNode = FocusNode();
  List<RecipeModal> recipes = [];
  bool isLoading = false;
  // List<Map> categories = [
  //   {"breakfast" : "Assets/Images/breakfast.jpg"},
  //   {"lunch" : "Assets/Images/lunch.jpg"},
  //   {"dinner" : "Assets/Images/dinner.jpg"},
  //   {"snacks" : "Assets/Images/snacks.jpg"},
  //   {"tea" : "Assets/Images/tea.jpg"},
  //   {"tea" : "Assets/Images/tea.jpg"},
  // ];
  // List<img> categories;
  List<CategoryData> ca = [];
  void getImages()
  {
    ca.add(CategoryData( "mealType", "breakfast", "Assets/Images/breakfast.jpg"));
    ca.add(CategoryData( "mealType", "dinner", "Assets/Images/dinner.jpg"));
    ca.add(CategoryData( "mealType", "lunch", "Assets/Images/lunch.jpg", ));
    ca.add(CategoryData( "mealType", "tea", "Assets/Images/tea.jpg"));
    ca.add(CategoryData( "mealType", "snacks", "Assets/Images/snacks.jpg"));
  }



  // List<int>
  // List<> categories = ["Assets/Images/breakfast.jpg", "Assets/Images/lunch.jpg","Assets/Images/dinner.jpg", "Assets/Images/snacks.jpg", "Assets/Images/tea.jpg"];
  // Lis



  //methods
  OnRefresh() {
    setState(() {
      // getPictures();
    });
    print("OnRefresh()");
    recipes.forEach((element) {
      print(element.label);
      print(element.appUrl);
    });
  }




  Future<List<RecipeModal>> _GetData({String keyword = "N/A", String categroyType = "N/A", String categroy = "N/A", }) async {
    List<RecipeModal> recipes = [];

    String url;
    if (categroy != "N/A" ){
      print("in Category");
    url = "https://api.edamam.com/api/recipes/v2?type=public&app_id=d39e35f3&app_key=ba2f76319ef782e37c6c582a457380dc&$categroyType=$categroy&random=true";
    }
    else if (keyword == "N/A") {
      url = "https://api.edamam.com/api/recipes/v2?type=any&app_id=d39e35f3&app_key=ba2f76319ef782e37c6c582a457380dc&calories=0-100000&random=true";
      print("in Random");

    }else{
      url = "https://api.edamam.com/api/recipes/v2?type=public&q=$keyword&app_id=d39e35f3&app_key=ba2f76319ef782e37c6c582a457380dc&random=true";
      print("in keyword");
    }
    recipes.clear();
    print("before populating list");
    recipes.forEach((element) {
      print("label: ${element.label}");
    });
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(data["hits"][0]["recipe"]["healthLabels"]);
    // log(data.toString() as num);
    print( "After populating list");

    data["hits"].forEach((element) {
      RecipeModal recipeModal = RecipeModal.dataFromMap(element["recipe"]);
      print("Before: ${recipeModal.appUrl}");
      recipeModal.appUrl = recipeModal.appUrl.replaceAll("http://", "https://");
      print("After: ${recipeModal.appUrl}");
      recipes.add(recipeModal);
    });
    recipes.forEach((element) {
      print("label: ${element.label}");
    });
    setState(() { });
    return recipes;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImages();
    // await _GetData();on
    recipes.clear();
    Future.delayed(Duration.zero, () async {
      recipes = await _GetData();
      recipes.forEach((element) {
        print(element);
      });
      print("initState()");
      // your code here
    });

    // GetData(keyword)
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set State()");
    print(Theme.of(context).backgroundColor);
    print(Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,

      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top * 0.99,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: widthPercent(context, 3.2)),
          child: Column(
            //main column
            children: [
              SearchWidget(context, this),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: heightPercent(context, 15),
                        width: widthPercent(context, 20),
                        child: CategoryWIdget(context, this)),
                  ),
                ],
              ),
              SizedBox(height: heightPercent(context, 4),),
              Container(
                  child: Expanded(
                child: ListView(
                  children: [
                   
                    // Stack(
                    //   children: [
                    //     Image.network("https://source.unsplash.com/random/100×100/?alcohol",
                    //       height: heightPercent(context, 10),
                    //       width: widthPercent(context, 20),
                    //     ),
                    //     Image.asset("Assets/Images/no.png",
                    //     height: heightPercent(context, 8),
                    //     width: widthPercent(context, 15),
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ],
                    // ),
                    // Categories(context, this),

                    ListTile(
                      title: Container( // Casual
                        padding: EdgeInsets.symmetric(
                          horizontal: widthPercent(context, 2),
                        ),

                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WHAT DO YOU WANT TO COOK TODAY",
                              style: TextStyle(
                                fontSize: averagePercent(context, 6),
                                fontFamily: "Edu_SA_Beginner",
                                fontWeight: FontWeight.w900,
                                // fon
                              ),
                            ),
                            SizedBox(
                              height: heightPercent(context, 1.5),
                            ),
                            Text(
                              "Let's cook something new!!!",
                              style: TextStyle(
                                fontSize: averagePercent(context, 3),
                                fontFamily: "Edu_SA_Beginner",
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isLoading? Container(
                      margin: EdgeInsets.only(top: heightPercent(context, 5)),
                      height: heightPercent(context, 2),
                        // width: widthPercent(context, 2),

                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).backgroundColor,
                        ),
                    ) : ListTile(
                      title: ListView.builder(
                          itemCount: recipes.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // Align: Alignment.topCenter;
                            return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Recipe(recipes[index].appUrl )));
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
                                            recipes[index].imageUrl,
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

                                            child: Text(recipes[index].label, style: TextStyle(
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
                                                Text(recipes[index].calories.substring(0,min(6, recipes[index].calories.length)), style: TextStyle(
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
                    ),
                  ],
                ),
              )),

              // Text("hi"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget SearchWidget(BuildContext context, _HomeState home) {
  return Container(
    //search container
    height: heightPercent(context, 6.5),
    width: widthPercent(context, 93.6),
    padding: EdgeInsets.symmetric(
      horizontal: widthPercent(context, 1.2),
    ),
    margin: EdgeInsets.only(
      // left: widthPercent(context, 3.2),
      // right: widthPercent(context, 3.2),
      top: heightPercent(context, 2),
      bottom: heightPercent(context, 3.5),
    ),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).backgroundColor.withOpacity(.7),
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(home.searchNode);
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(
                  widthPercent(context, 1.2), 0, widthPercent(context, 1.7), 0),
              child: Icon(
                Icons.search,
                color: Colors.blue,
                size: averagePercent(context, 5),
              )),
        ),
        Expanded(
            child: TextField(
          style: TextStyle(
              // color: Colors.black,
              ),
          focusNode: home.searchNode,
          textInputAction: TextInputAction.search,
          onSubmitted: (text) async {
            home.isLoading = true;
            print("Submitted");
            List<RecipeModal> recipes  = [];
            recipes.clear();
            recipes = await home._GetData(keyword: text);
            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeList(recipes, text)));
            // home.searchController.clear();
            home.isLoading = false;
            print("Still there");
            // home.setState(() { });
          },
          controller: home.searchController,
          decoration: InputDecoration(
            hintText: "Lets cook something,",
            // hintStyle: TextStyle(
            //   color: Colors.black45,
            // ),
            border: InputBorder.none,
          ),
        )),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.only(right: widthPercent(context, 3)),
            child: Icon(
              Icons.refresh_outlined,
              size: averagePercent(context, 8),
              color: Colors.teal,
            ),
          ),
          onTap: home.OnRefresh,
        ),
      ],
    ),
  );
}



Widget CategoryWIdget(BuildContext context, _HomeState home )
{
  return  ListView.builder(
    scrollDirection:  Axis.horizontal,
        itemCount: home.ca.length,
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // Align: Alignment.topCenter;
          return InkWell(
              onTap: () async {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ))
                List<RecipeModal> recipes = [];
                recipes = await home._GetData(categroyType: home.ca[index].categoryType, categroy: home.ca[index].category,);
                Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeList(recipes, home.ca[index].category)));
              },
              child: Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: widthPercent(context, 4),
                      // vertical: heightPercent(context, 1.5)
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          home.ca[index].location,
                          fit: BoxFit.cover,
                          width: widthPercent(context, 35),
                          height: heightPercent(context, 20),
                        ),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      Positioned( //label
                        width: widthPercent(context, 80),
                        left: widthPercent(context, 3),
                        bottom: heightPercent(context, 1.2),

                        child: Text(home.ca[index].category, style: TextStyle(
                          backgroundColor: Theme
                              .of(context)
                              .backgroundColor == Color(0xff616161) ? Theme
                              .of(context)
                              .backgroundColor
                              .withOpacity(.5) : Colors.white.withOpacity(.5),
                          //checking if color is black or not
                          color: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .color,
                          fontSize: averagePercent(context, 3),
                          fontStyle: FontStyle.italic,
                        )

                        ),),
                      // Positioned( //calories
                      //   right: widthPercent(context, 3),
                      //   top: heightPercent(context, 1.2),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Theme
                      //           .of(context)
                      //           .backgroundColor == Color(0xff616161) ? Theme
                      //           .of(context)
                      //           .backgroundColor
                      //           .withOpacity(.5) : Colors.white.withOpacity(.5),
                      //     ),
                      //     child: Row(
                      //
                      //       children: [
                      //         Icon(Icons.local_fire_department_outlined,
                      //           color: Theme
                      //               .of(context)
                      //               .textTheme
                      //               .bodyText1!
                      //               .color,
                      //         ),
                      //         Text(recipes[index].calories.substring(0, min(6,
                      //             recipes[index].calories.length)),
                      //             style: TextStyle(
                      //               // backgroundColor: Theme.of(context).backgroundColor.withOpacity(.4),
                      //               color: Theme
                      //                   .of(context)
                      //                   .textTheme
                      //                   .bodyText1!
                      //                   .color,
                      //               fontSize: averagePercent(context, 3),
                      //               fontStyle: FontStyle.italic,
                      //             )
                      //
                      //         ),
                      //       ],
                      //     ),
                      //   ),),
                    ],

                  )));
        });
}
