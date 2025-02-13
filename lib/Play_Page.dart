import 'dart:math';
import 'package:flutter/material.dart';
import 'package:picture_match/Level_Page.dart';
import 'package:picture_match/allData.dart';
import 'package:picture_match/main.dart';

class PlayPage extends StatefulWidget {
  String gameName;
  int levelNum;
  PlayPage(this.levelNum,this.gameName, {super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> with TickerProviderStateMixin {
  List<String> imageList = [];
  List<int> imageShow = [];
  int lastLength = 0;
  bool imageClick = true;
  bool time = true;
  bool showDialogTemp = true;
  late int numberOfItem;
  late int numberOfImageMatch;
  late Animation animation;
  late int timeStart;
  int timeEnd = 5;
  late List<String> levelList;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    setData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showDialogTemp) {
      Future.delayed(Duration.zero).then(
        (value) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
                titlePadding: EdgeInsets.zero,
                title: Container(
                  color: allData.darkGreen,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "TIME: ${widget.gameName=="NO TIME LIMIT"?"NO TIME LIMIT":(widget.gameName=="NORMAL")?"${30+widget.levelNum} s":"${15+widget.levelNum} s"}",
                    style: TextStyle(fontSize: 20, color: allData.lightGreen),
                  ),
                ),
                content: Text(
                  "YOU HAVE 5 SECONDS TO MERORIZE ALL IMAGES",
                  style: TextStyle(
                  ),
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: allData.darkGreen,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: TextButton(onPressed: () {
                      print("click 1");
                      Navigator.pop(context);
                      print("click 2");
                      showDialogTemp = false;
                      print("click 3");
                      setData();
                      print("click 4");
                      setState(() { });
                    }, child: Text(
                        "OK",
                        style: TextStyle(fontSize: 20, color: allData.lightGreen),
                    )),
                  )
                ],
              );
            },
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LevelPage(widget.gameName),));
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: allData.darkGreen,
          title: Text("Time: ${animation.value.toInt()}/$timeEnd"),
          titleTextStyle: TextStyle(
              color: allData.lightGreen,
              fontSize: 23,
              fontWeight: FontWeight.bold),
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
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: allData.darkGreen, width: 2)),
              margin: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
              height: 8,
              child: LinearProgressIndicator(
                value: (time)
                    ? 1 - animationController.value
                    : animationController.value,
                backgroundColor: allData.lightGreen,
                color: allData.darkGreen,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberOfItem == 12 ? 3 : 4,
                ),
                itemCount: numberOfItem,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (imageClick && !imageShow.contains(index)) {
                        imageShow.add(index);
                      }
                      if (imageShow.length == lastLength + numberOfImageMatch &&
                          imageClick) {
                        //change
                        int cnt = 0;
                        for (int i = 1; i < numberOfImageMatch; i++) {
                          print(imageShow);
                          if (imageList[imageShow[imageShow.length - i]] == imageList[imageShow[imageShow.length - i - 1]]) {
                            cnt++;
                          }
                        }
                        if (cnt == numberOfImageMatch - 1) {
                          imageClick = true;
                          lastLength += numberOfImageMatch; //change
                        } else {
                          imageClick = false;
                          Future.delayed(
                            Duration(milliseconds: 300),
                                () {
                              for (int i = 0; i < numberOfImageMatch; i++) {
                                imageShow.removeLast();
                              }
                              imageClick = true;
                              setState(() {});
                            },
                          );
                        }
                        if (imageList.length == imageShow.length) {
                          if(widget.gameName=="NORMAL"){
                            if(widget.levelNum>=Preferences.getNormalLevel()-1){
                              levelList[Preferences.getNormalLevel()-1]=" - ${animation.value.toInt()} s";
                              Preferences.setNormalList(levelList);
                            }
                          }else if(widget.gameName=="HARD"){
                            if(widget.levelNum>=Preferences.getHardLevel()-1){
                              levelList[Preferences.getHardLevel()-1]=" - ${animation.value.toInt()} s";
                              Preferences.setHardList(levelList);
                            }
                          }

                          animationController.stop();
                          print(Preferences.getNormalList());
                          if(widget.gameName=="NO TIME LIMIT"){
                            if(widget.levelNum>=Preferences.getNoTimeLimitLevel()-1){
                              Preferences.setNoTimeLimitLevel(Preferences.getNoTimeLimitLevel()+1);
                            }
                          }else if(widget.gameName=="NORMAL"){
                            if(widget.levelNum>=Preferences.getNormalLevel()-1){   //0>=1-1 0>0 true   0>=2-1 0>=1 false   1>=2-1 1>=1 false
                              Preferences.setNormalLevel(Preferences.getNormalLevel()+1);
                            }
                          }else{
                            if(widget.levelNum>=Preferences.getHardLevel()-1){
                              Preferences.setHardLevel(Preferences.getHardLevel()+1);
                            }
                          }
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
                                titlePadding: EdgeInsets.zero,
                                title: Container(
                                  color: allData.darkGreen,
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${widget.gameName=="NO TIME LIMIT"?"NEW RECORD!":"LEVEL COMPLETED"}",
                                    style: TextStyle(fontSize: 20, color: allData.lightGreen),
                                  ),
                                ),
                                content: Text(
                                  "${widget.gameName=="NO TIME LIMIT"?"NO TIME LIMIT\nLEVEL 1\nWELL DONE!":"Congratualtions!!!"}",
                                  style: TextStyle(
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    decoration: BoxDecoration(
                                        color: allData.darkGreen,
                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                    child: TextButton(onPressed: () {
                                        Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LevelPage(widget.gameName),));
                                    }, child: Text(
                                      "OK",
                                      style: TextStyle(fontSize: 20, color: allData.lightGreen),
                                    )),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: (imageShow.contains(index) && !showDialogTemp)
                              ? Colors.white
                              : allData.darkGreen,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: (imageShow.contains(index) && !showDialogTemp)
                          ? Image.asset("assets/image/${imageList[index]}")
                          : null,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }

  void setData() {
    print("set data called");
    print(widget.levelNum);

    if(widget.gameName=='NORMAL'){
      levelList=Preferences.getNormalList();
    }else if(widget.gameName=="HARD"){
      levelList=Preferences.getHardList();
    }

    if(widget.levelNum>=0 && widget.levelNum<10 || widget.levelNum>=21 && widget.levelNum<30 || widget.levelNum>=41 && widget.levelNum<50) {
      numberOfItem = 12;
    } else {
      numberOfItem = 24;
    }
    if (widget.levelNum>=0 && widget.levelNum<=20) {
      numberOfImageMatch=2;
    } else if (widget.levelNum>=21 && widget.levelNum<=40) {
      numberOfImageMatch=3;
    } else {
      numberOfImageMatch=4;
    }

    if(showDialogTemp){
      print("showDialogTemp is true");
      animationController =
          AnimationController(vsync: this, duration: Duration(seconds: 10));
      animation = Tween<double>(begin: 5, end: 5).animate(animationController);
    }else {
      print("showDialogTemp is false");
      animationController=AnimationController(vsync: this, duration: Duration(seconds: 10));
      animation=Tween<double>(begin: 6.0, end: 0).animate(animationController);
      animationController.forward();
      animation.addListener(
            () {
          setState(() {
            if (animation.isCompleted) {
              if (widget.gameName == "NO TIME LIMIT") {
                timeStart = 0;
                timeEnd = 0;
              } else if (widget.gameName == "NORMAL") {
                timeStart = 0;
                timeEnd = 30+widget.levelNum;
              } else {
                timeStart = 0;
                timeEnd = 15+widget.levelNum;
              }
              imageShow.clear();
              time = false;
              animationController = AnimationController(vsync: this, duration: Duration(seconds: timeEnd));
              animation = Tween<double>(begin: timeStart.toDouble(), end: timeEnd.toDouble()).animate(animationController);
              animationController.forward();
              animation.addListener(
                    () {
                      if (animation.isCompleted) {
                        showDialog(barrierDismissible: false,context: context, builder: (context) {
                          return AlertDialog(
                            shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
                            titlePadding: EdgeInsets.zero,
                            title: Container(
                              color: allData.darkGreen,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Text(
                                "TIME OUT",
                                style: TextStyle(fontSize: 20, color: allData.lightGreen),
                              ),
                            ),
                            content: Text(
                              "TRY AGAIN?"
                              ,textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: [
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                decoration: BoxDecoration(
                                    color: allData.darkGreen,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: TextButton(onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LevelPage(widget.gameName),));
                                }, child: Text(
                                  "CANCEL",
                                  style: TextStyle(fontSize: 20, color: allData.lightGreen),
                                )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                decoration: BoxDecoration(
                                    color: allData.darkGreen,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: TextButton(onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    return PlayPage(widget.levelNum,widget.gameName);
                                  },));
                                }, child: Text(
                                  "OK",
                                  style: TextStyle(fontSize: 20, color: allData.lightGreen),
                                )),
                              )
                            ],
                          );
                        },);
                      }
                  setState(() {});
                },
              );
            }
          });
        },
      );
      print("showDialogTemp is false finised");
    }

    do {
      if(!showDialogTemp){
        return;
      }
      int r = Random().nextInt(allData.image.length);
      if (!imageList.contains(allData.image[r])) {
        for (int i = 0; i < numberOfImageMatch; i++) {
          imageList.add(allData.image[r]);
        }
      }
      if (imageList.length == numberOfItem) {
        //change
        imageList.shuffle();
        break;
      }
    }while(true);
    print("setData start finsied");
    for(int i=0;i<numberOfItem;i++) {
      //change
      imageShow.add(i);
    }
    print("setData finished");
  }
}

// 1 to 10:itemCount=12 		crossAxisCount=3
// 11 to 20:itemCount=24 		crossAxisCount=4
