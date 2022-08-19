import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tracker/model/tracker_data_model.dart';
import 'package:tracker/provider/add_data_provider.dart';
import 'package:tracker/res/colors.dart';
import 'package:tracker/utils/routes/route_name.dart';

import '../database/db_handler.dart';
import '../provider/home_data_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  DBHelper? dbHelper;
  bool isEmpty = false;
  Future<List<TrackerDataModel>>? trackerData;
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    trackerData = dbHelper!.getNotesList();
    WidgetsBinding.instance.addPostFrameCallback((_) => initData(context));
  }

  initData(BuildContext context){
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    var list = dbHelper?.getNotesListOnly();
    setState(() {

    });
  }

  final colorList = <Color>[
    const Color(0xffde5246),
    const Color(0xff1aa206),
    const Color(0xffd6d6d6),
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final addDataProvider =
        Provider.of<AddDataProvider>(context, listen: false);
    final widthVariable = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                //color: Colors.grey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            addDataProvider.setTime("");
                            addDataProvider.setDate("");
                            addDataProvider.setAmountFieldEmpty();
                            Navigator.pushNamed(context, RoutesName.addData);
                          },
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.greyColor.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(1, 4),
                                  )
                                ]
                            ),
                            child: const Center(
                                child: Text(
                              "+  Add",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: AppColor.whiteColor,
                                  fontSize: 15),
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      height: 170,
                      width: widthVariable,
                      child: PieChart(
                        dataMap: {
                          "Expense": getTotalExpense(context, "Expense"), //homeProvider.getNumberChart("Expense"),
                          "Income": getTotalExpense(context, "Income"),
                          "Savings": 5
                        },
                        animationDuration: const Duration(seconds: 2),
                        colorList: colorList,
                        chartType: ChartType.ring,
                        chartRadius: MediaQuery.of(context).size.width / 3.0,
                        chartValuesOptions: const ChartValuesOptions(showChartValues: false)
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: FutureBuilder(
                    future: homeProvider.getDataFromDevice,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TrackerDataModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            // reverse: true,
                            //   shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              int itemCount = snapshot.data?.length ?? 0;
                              int reversedIndex = itemCount - 1 - index;
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: AppColor.redColor,
                                  child: const Icon(Icons.delete_forever),
                                ),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    dbHelper!.delete(snapshot.data![reversedIndex].id!);
                                    snapshot.data!
                                        .remove(snapshot.data![reversedIndex]);
                                  });
                                },
                                key: ValueKey<int>(snapshot.data![reversedIndex].id!),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                  ),
                                  shadowColor: AppColor.greyColor.withOpacity(0.8),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              AppColor.avatarBackgroundColor,
                                          radius: 25,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: snapshot.data![reversedIndex]
                                                          .expense ==
                                                      "Expense"
                                                  ? Image.asset(
                                                      'images/red_arrow.png')
                                                  : Image.asset(
                                                      'images/green_arrow.png')),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 180,
                                              child: Text(
                                                snapshot.data![reversedIndex].title
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 180,
                                              child: Text(
                                                snapshot
                                                    .data![reversedIndex].description
                                                    .toString(),
                                                style: const TextStyle(
                                                    color:
                                                        AppColor.darkGreyColor,
                                                    fontFamily: "Poppins",
                                                    fontSize: 13),
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data![reversedIndex].date.toString()} at ${snapshot.data![reversedIndex].time.toString()}",
                                              style: const TextStyle(
                                                  color: AppColor.greyColor,
                                                  fontFamily: "Poppins",
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          snapshot.data![reversedIndex].amount
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15),
                                        ),
                                        // const SizedBox(
                                        //   width: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getTotalExpense(BuildContext context, String type) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    var expense = homeProvider.totalExpense.toDouble();
    var income = homeProvider.totalIncome.toDouble();
    if(type == "Expense"){
      return expense;
    }else if(type == "Income"){
      return income;
    }
  }
}
