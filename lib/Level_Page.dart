import 'package:flutter/material.dart';
import 'package:picture_match/Home_Page.dart';
import 'package:picture_match/Play_Page.dart';
import 'package:picture_match/allData.dart';
import 'package:picture_match/main.dart';

class LevelPage extends StatefulWidget {
  String gameName;
  LevelPage(this.gameName,{super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {

  late int levelNum;

  @override
  Widget build(BuildContext context) {
    if(widget.gameName=="NO TIME LIMIT"){
      levelNum=Preferences.getNoTimeLimitLevel();
    }else if(widget.gameName=="NORMAL"){
      levelNum=Preferences.getNormalLevel();
    }else{
      levelNum=Preferences.getHardLevel();
    }
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: allData.darkGreen,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: Icon(
          //     Icons.arrow_back_rounded,
          //     color: allData.lightGreen,
          //   )
          // ),
          title: Text("Select Level"),
          titleTextStyle: TextStyle(
              color: allData.lightGreen,
              fontSize: 23,
              fontWeight: FontWeight.bold
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "${widget.gameName}",
                style: TextStyle(
                  color: allData.lightGreen,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: allData.lightGreen,
        body: Container(
          alignment: Alignment.center,
          child: Stack(
              alignment: Alignment.center,
              children:[
                Image.asset(
                    "assets/image/background_image.png"
                ),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, mainIndex) {
                    return Container(
                      width: 220,
                      margin: EdgeInsets.only(
                          top: 50,
                          bottom: 50,
                          left: (mainIndex==0)?80:30,
                          right: (mainIndex==5)?80:0
                      ),
                      decoration: BoxDecoration(
                        color: allData.lightGreen,
                        border: Border.all(
                            color: allData.darkGreen,
                            width: 4
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "${(mainIndex==0 || mainIndex==1)?"MATCH 2":(mainIndex==2 || mainIndex==3)?"MATCH 3":"MATCH 4"}",
                              style: TextStyle(
                                  color: allData.darkGreen,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 2,
                            color: allData.darkGreen,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, subIndex) {
                                return InkWell(
                                  onTap: () {
                                    if((mainIndex*10+subIndex+1)<=levelNum){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayPage(mainIndex*10+subIndex,widget.gameName),));
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.only(top: 10,bottom: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: ((mainIndex*10+subIndex+1)<=levelNum)?allData.darkGreen:allData.disabledBtn,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)
                                        )
                                    ),
                                    child: Text(
                                      "Level ${mainIndex*10+subIndex+1} ${(widget.gameName=="NORMAL")?Preferences.getNormalList()[mainIndex*10+subIndex]:(widget.gameName=="HARD")?Preferences.getHardList()[mainIndex*10+subIndex]:""}",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: allData.lightGreen,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]
          ),
        ),
      ),
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      },
    );
  }
}


// mainIndex:0,1,2,3,4,5
// subIndex:0,1,2,3,4,5,6,7,8,9
// Logic:
// mainIndex*10+subIndex+1

// 0*10+0+1=0+1=1
// 0*10+1+1=0+2=2

// 1*10+0+1=10+1=11
// 1*10+1+1=10+2=12
// 1*10+9+1=10+10=20


// 5*10+0+1=50+1=51
// 5*10+1+1=50+2=52