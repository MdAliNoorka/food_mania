import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_mania/Workings/ScreenResolutionPercents.dart';
import 'package:http/http.dart';
import 'dart:developer';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variables
  TextEditingController searchController = new TextEditingController();
  FocusNode searchNode = FocusNode();


  //methods
  OnRefresh(){
    print("OnRefresh()");
  }
  SearchKeyword(String keyword){
    print("SearchKeyword()");
    _GetData(keyword);
  }
  void _GetData(String keyword) async{
    
    Response response = await get(Uri.parse("https://api.edamam.com/api/recipes/v2?type=public&q=$keyword&app_id=d39e35f3&app_key=ba2f76319ef782e37c6c582a457380dc"));
    Map data = jsonDecode(response.body);
    print(data["hits"][0]["recipe"]["healthLabels"]);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // GetData(keyword)

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // backgroundColor: Colors.black,

        body: SafeArea(
      child: SingleChildScrollView(

          child: Stack(

        children: [
          Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top * 0.99,
            width: MediaQuery.of(context).size.width,

            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   colors: [
            //     Colors.black,
            //     Colors.white38,
            //   ],
            // )),

            child: Column(//main column
              children: [
                Container(
                  //search container
                  height: heightPercent(context, 6.5),
                  width: widthPercent(context, 93.6),
                  padding: EdgeInsets.symmetric(
                    horizontal: widthPercent(context, 1.2),
                  ),
                  margin: EdgeInsets.only(
                    left: widthPercent(context, 3.2),
                    right: widthPercent(context, 3.2),
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
                          FocusScope.of(context).requestFocus(searchNode);
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
                              color: Colors.black,
                            ),
                            focusNode: searchNode,
                            textInputAction: TextInputAction.search,
                            onSubmitted: SearchKeyword(searchController.text),
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Lets cook something," ,
                              // hintStyle: TextStyle(
                              //   color: Colors.black45,
                              // ),
                              border: InputBorder.none,
                            ),
                          )),
                      GestureDetector(
                        child: Container(

                          padding: EdgeInsets.only(right: widthPercent(context, 3)),
                          child: Icon(Icons.refresh_outlined,
                            size: averagePercent(context, 8),
                            color: Colors.teal,

                          ),
                        ),
                        onTap: OnRefresh,

                      ),
                    ],
                  ),
                ),


                  Text("hi this is me an dthhis jis bonot ",
                  ),
                  Text("starts at 9:30 am"),
                  Text("hi this is me"),
                  // height: ,
              ],
            ),
          ),
        ],
      )),
    ));
  }
}
