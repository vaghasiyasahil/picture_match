import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picture_match/Level_Page.dart';
import 'package:picture_match/allData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        showDialog(barrierDismissible: false,context: context, builder: (context) {
          return AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
            titlePadding: EdgeInsets.zero,
            title: Container(
              color: allData.darkGreen,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                "EXIT?",
                style: TextStyle(fontSize: 20, color: allData.lightGreen),
              ),
            ),
            content: Text(
              "ARE YOU SURE YOU WANT TO EXTI?"
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
                  Navigator.pop(context);
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
                  SystemNavigator.pop();
                }, child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20, color: allData.lightGreen),
                )),
              )
            ],
          );
        },);
      },
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: allData.darkGreen,
            title: Text("Select Mode"),
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: allData.lightGreen,
              fontSize: 23,
            ),
          ),
          backgroundColor: allData.lightGreen,
          body: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/image/background_image.png"),
                Container(
                  height: 220,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: allData.lightGreen,
                      border: Border.all(color: allData.darkGreen, width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LevelPage("NO TIME LIMIT"),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: allData.darkGreen,
                              borderRadius: BorderRadius.all(Radius.circular(3))),
                          child: Text(
                            "NO TIME LIMIT",
                            style: TextStyle(
                                color: allData.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LevelPage("NORMAL"),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: allData.darkGreen,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(3)
                              )
                          ),
                          child: Text(
                            "NORMAL",
                            style: TextStyle(
                                color: allData.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LevelPage("HARD"),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: allData.darkGreen,
                              borderRadius: BorderRadius.all(Radius.circular(3))),
                          child: Text(
                            "HARD",
                            style: TextStyle(
                                color: allData.lightGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
