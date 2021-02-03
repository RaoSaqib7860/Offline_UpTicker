import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/FCharts.dart/FBarChart.dart';
import 'package:upticker/Provider/ProviderGraphSubBucket.dart';

import 'Graph.dart';

class GraphSubBucket extends StatefulWidget {
  final String id;
  GraphSubBucket({Key key, this.id}) : super(key: key);

  @override
  _GraphSubBucketState createState() => _GraphSubBucketState();
}

class _GraphSubBucketState extends State<GraphSubBucket> {
  @override
  void initState() {
    final _provider =
        Provider.of<GraphSubBucketProvider>(context, listen: false);
    apiCalling(_provider);
    super.initState();
  }

  apiCalling(GraphSubBucketProvider provider) {
    DateTime date = DateTime.now();
    ApiUtils.getGraphDataSubBucket(
        period: 'day',
        provider: provider,
        date: '${date.year}-${date.month}-${date.day}',
        id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _provider = Provider.of<GraphSubBucketProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(left: width / 30, right: width / 30),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _provider.setAllDays();
                      _provider.setdays(true);
                      _provider.setloading(false);
                      _provider.setPeriod('day');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphDataSubBucket(
                          period: 'day',
                          provider: _provider,
                          id: widget.id,
                          date: '${date.year}-${date.month}-${date.day}');
                    },
                    splashColor: Colors.white,
                    hoverColor: Colors.white,
                    child: Container(
                        height: height / 25,
                        width: width / 5,
                        child: Center(
                          child: Text(
                            'Day',
                            style: TextStyle(
                                color: _provider.day == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: ColorsThemes.mailColors),
                            color: _provider.day == true
                                ? ColorsThemes.mailColors
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  InkWell(
                    onTap: () {
                      _provider.setAllDays();
                      _provider.setweek(true);
                      _provider.setloading(false);
                      _provider.setPeriod('week');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphDataSubBucket(
                          period: 'week',
                          provider: _provider,
                          id: widget.id,
                          date: '${date.year}-${date.month}-${date.day}');
                    },
                    splashColor: Colors.white,
                    hoverColor: Colors.white,
                    child: Container(
                        height: height / 25,
                        width: width / 5,
                        child: Center(
                          child: Text(
                            'Week',
                            style: TextStyle(
                                color: _provider.week == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: ColorsThemes.mailColors),
                            color: _provider.week == true
                                ? ColorsThemes.mailColors
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  InkWell(
                    onTap: () {
                      _provider.setAllDays();
                      _provider.setmonth(true);
                      _provider.setloading(false);
                      _provider.setPeriod('month');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphDataSubBucket(
                          period: 'month',
                          provider: _provider,
                          id: widget.id,
                          date: '${date.year}-${date.month}-${date.day}');
                    },
                    splashColor: Colors.white,
                    hoverColor: Colors.white,
                    child: Container(
                        height: height / 25,
                        width: width / 5,
                        child: Center(
                          child: Text(
                            'Months',
                            style: TextStyle(
                                color: _provider.month == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: ColorsThemes.mailColors),
                            color: _provider.month == true
                                ? ColorsThemes.mailColors
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  InkWell(
                    onTap: () {
                      _provider.setAllDays();
                      _provider.setyear(true);
                      _provider.setloading(false);
                      _provider.setPeriod('year');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphDataSubBucket(
                          period: 'year',
                          provider: _provider,
                          id: widget.id,
                          date: '${date.year}-${date.month}-${date.day}');
                    },
                    splashColor: Colors.white,
                    hoverColor: Colors.white,
                    child: Container(
                        height: height / 25,
                        width: width / 5,
                        child: Center(
                          child: Text(
                            'year',
                            style: TextStyle(
                                color: _provider.year == true
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: ColorsThemes.mailColors),
                            color: _provider.year == true
                                ? ColorsThemes.mailColors
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ],
              ),
              SizedBox(
                height: height / 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: width / 20, right: width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _provider.setAllCharts();
                        _provider.setLineChart(true);
                      },
                      splashColor: Colors.white,
                      hoverColor: Colors.white,
                      child: Container(
                          height: height / 25,
                          width: width / 5,
                          child: Center(
                            child: Text(
                              'Line Chart',
                              style: TextStyle(
                                  color: _provider.lineChart == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: _provider.lineChart == true
                                  ? ColorsThemes.mailColors
                                  : Colors.white,
                              border: Border.all(
                                  width: 1.5, color: ColorsThemes.mailColors),
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      width: width / 15,
                    ),
                    InkWell(
                      onTap: () {
                        _provider.setAllCharts();
                        _provider.setbarCharts(true);
                      },
                      splashColor: Colors.white,
                      hoverColor: Colors.white,
                      child: Container(
                          height: height / 25,
                          width: width / 5,
                          child: Center(
                            child: Text(
                              'BarChart',
                              style: TextStyle(
                                  color: _provider.barCharts == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 10),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: _provider.barCharts == true
                                  ? ColorsThemes.mailColors
                                  : Colors.white,
                              border: Border.all(
                                  width: 1.5, color: ColorsThemes.mailColors),
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _provider.setAllCharts();
                    //     _provider.setpieChart(true);
                    //   },
                    //   splashColor: Colors.white,
                    //   hoverColor: Colors.white,
                    //   child: Container(
                    //       height: height / 25,
                    //       width: width / 5,
                    //       child: Center(
                    //         child: Text(
                    //           'PieChart',
                    //           style: TextStyle(
                    //               color: _provider.pieChart == true
                    //                   ? Colors.white
                    //                   : Colors.black,
                    //               fontSize: 10),
                    //         ),
                    //       ),
                    //       decoration: BoxDecoration(
                    //           color: _provider.pieChart == true
                    //               ? ColorsThemes.mailColors
                    //               : Colors.white,
                    //           border: Border.all(
                    //               width: 1.5, color: ColorsThemes.mailColors),
                    //           borderRadius: BorderRadius.circular(5))),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              _provider.loading == false
                  ? Container(
                      height: height / 2,
                      child: Center(child: CupertinoActivityIndicator()))
                  : _provider.lineChart == true
                      ? Column(
                          children: [
                            Container(
                              width: width,
                              height: height / 2,
                              child: SfCartesianChart(
                                  primaryYAxis:
                                      NumericAxis(minimum: 0, maximum: 100),
                                  primaryXAxis: CategoryAxis(labelRotation: 90),
                                  title: ChartTitle(
                                      backgroundColor: Colors.white,
                                      text:
                                          'Task percentage on ${_provider.period == 'day' ? 'daily' : _provider.period == 'week' ? 'weekly' : 'monthly'} basis'),
                                  enableAxisAnimation: true,
                                  legend: Legend(isVisible: true),
                                  tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                      activationMode: ActivationMode.singleTap,
                                      tooltipPosition: TooltipPosition.auto),
                                  series: <ChartSeries<SalesData, String>>[
                                    LineSeries<SalesData, String>(
                                        dataSource: _provider.listOfGraphline,
                                        xValueMapper: (var sales, _) =>
                                            sales.year,
                                        yValueMapper: (SalesData sales, _) =>
                                            sales.sales,
                                        name: 'task',
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true))
                                  ]),
                            ),
                          ],
                        )
                      : _provider.barCharts == true
                          ? Column(
                              children: [
                                Container(
                                    child: BarChartSample3(
                                  list: _provider.listOfGraphline,
                                )),
                                SizedBox(
                                  height: height / 100,
                                ),
                                Row(
                                  children: _provider.listOfGraphline.map((e) {
                                    SalesData data = e;
                                    return RotatedBox(
                                      quarterTurns: 1,
                                      child: Text(
                                        '${data.year}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    );
                                  }).toList(),
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                )
                              ],
                            )
                          : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
