import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:upticker/ApiConfig/APiUtil.dart';
import 'package:upticker/ColorsThems/ThemesColors.dart';
import 'package:upticker/FCharts.dart/FBarChart.dart';
import 'package:upticker/Provider/GraphProvider.dart';
import 'package:upticker/ServicesForApp/FireBaseAnalytics.dart';

class SalesData {
  SalesData(this.year, this.sales, [this.color]);

  final String year;
  final double sales;
  final Color color;
}

class Graph extends StatefulWidget {
  Graph({Key key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final List<SalesDatas> chartData = [
    SalesDatas(10.5, 10),
    SalesDatas(11.5, 28),
    SalesDatas(12.5, 100),
    SalesDatas(13.5, 20),
    SalesDatas(14.5, 50)
  ];

  @override
  void initState() {
    final _provider = Provider.of<GraphProvider>(context, listen: false);
    apiCaling(_provider);
    FireBaseAnalyticsServices.setCurrentScreen(
        screenName: 'Graph', screenClass: 'Graph class');
    super.initState();
  }

  apiCaling(GraphProvider provider) {
    DateTime date = DateTime.now();
    ApiUtils.getGraphData(
        period: 'day',
        provider: provider,
        date: '${date.year}-${date.month}-${date.day}');
    ApiUtils.getGraphDataBucket(
        period: 'day',
        provider: provider,
        date: '${date.year}-${date.month}-${date.day}');
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<GraphProvider>(
      context,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(width / 30),
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
                      _provider.setloadingBucket(false);
                      _provider.setloadingBucket(false);
                      _provider.setPeriod('day');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphData(
                          period: 'day',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');
                      ApiUtils.getGraphDataBucket(
                          period: 'day',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');
                      _provider.setloadingSubBucket(false);
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
                      _provider.setloadingBucket(false);
                      _provider.setPeriod('week');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphData(
                          period: 'week',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');

                      ApiUtils.getGraphDataBucket(
                          period: 'week',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');
                      _provider.setloadingSubBucket(false);
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
                      _provider.setloadingBucket(false);
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphData(
                          period: 'month',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');

                      ApiUtils.getGraphDataBucket(
                          period: 'month',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');
                      _provider.setloadingSubBucket(false);
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
                      _provider.setloadingBucket(false);
                      _provider.setPeriod('year');
                      DateTime date = DateTime.now();
                      ApiUtils.getGraphData(
                          period: 'year',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');

                      ApiUtils.getGraphDataBucket(
                          period: 'year',
                          provider: _provider,
                          date: '${date.year}-${date.month}-${date.day}');
                      _provider.setloadingSubBucket(false);
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
                  ? SizedBox()
                  : _provider.lineChart == true
                      ? Column(
                          children: [
                            Container(
                              width: width,
                              height: height / 2,
                              child: SfCartesianChart(
                                  primaryYAxis:
                                      NumericAxis(minimum: 0, maximum: 100),
                                  primaryXAxis: CategoryAxis(
                                      // Axis labels will be rotated to 90 degree
                                      labelRotation: 90),
                                  title: ChartTitle(
                                      backgroundColor: Colors.white,
                                      text:
                                          'Task percentage on ${_provider.period == 'day' ? 'daily' : _provider.period == 'week' ? 'weekly' : 'monthly'} basis'),
                                  enableAxisAnimation: true,
                                  // Enable legend
                                  legend: Legend(isVisible: true),
                                  // Enable tooltip
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
                                        // Enable data label
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
              SizedBox(
                height: height / 40,
              ),
              _provider.loadingBucket == true
                  ? Container(
                      height: height / 1.7,
                      child: SfCircularChart(
                          onPointTapped: (PointTapArgs args) {
                            print("${args.pointIndex}");
                            print(
                                '${_provider.listOfSubBucket[args.pointIndex]}');
                            _provider.setlistOfSubBucketfinal(
                                _provider.listOfSubBucket[args.pointIndex]);
                            _provider.setloadingSubBucket(true);
                          },
                          legend: Legend(
                              isVisible: true,
                              isResponsive: true,
                              height: '100%',
                              orientation: LegendItemOrientation.vertical,
                              position: LegendPosition.bottom,
                              alignment: ChartAlignment.center),
                          title: ChartTitle(
                              backgroundColor: Colors.white,
                              text:
                                  'Bucket percentage on ${_provider.period == 'day' ? 'daily' : _provider.period == 'week' ? 'weekly' : 'monthly'} basis'),
                          series: <CircularSeries>[
                            PieSeries<SalesData, String>(
                                dataSource: _provider.listOfBucket,
                                pointColorMapper: (SalesData data, _) =>
                                    data.color,
                                name: 'Bucket',
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                                xValueMapper: (SalesData data, _) => data.year,
                                yValueMapper: (SalesData data, _) =>
                                    data.sales),
                          ]),
                    )
                  : SizedBox(),
              SizedBox(
                height: height / 40,
              ),
              _provider.loadingSubBucket == true
                  ? Container(
                      height: height / 1.7,
                      child: SfCircularChart(
                          onPointTapped: (PointTapArgs args) {
                            // print("${args.pointIndex}");
                            // print(
                            //     '${_provider.listOfSubBucket[args.pointIndex]}');
                            // _provider.setlistOfSubBucketfinal(
                            //     _provider.listOfSubBucket[args.pointIndex]);
                            // _provider.setloadingSubBucket(true);
                          },
                          legend: Legend(
                              isVisible: true,
                              isResponsive: true,
                              height: '100%',
                              orientation: LegendItemOrientation.vertical,
                              position: LegendPosition.bottom,
                              alignment: ChartAlignment.center),
                          title: ChartTitle(
                              backgroundColor: Colors.white,
                              text:
                                  'SubBucket percentage on ${_provider.period == 'day' ? 'daily' : _provider.period == 'week' ? 'weekly' : 'monthly'} basis'),
                          series: <CircularSeries>[
                            PieSeries<SalesData, String>(
                                dataSource: _provider.listOfSubBucketfinal,
                                pointColorMapper: (SalesData data, _) =>
                                    data.color,
                                name: 'SubBucket',
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                                xValueMapper: (SalesData data, _) => data.year,
                                yValueMapper: (SalesData data, _) =>
                                    data.sales),
                          ]),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
// SfCartesianChart(
//                               primaryYAxis:
//                                   NumericAxis(minimum: 10, maximum: 100),
//                               title: ChartTitle(
//                                   backgroundColor: Colors.white,
//                                   text:
//                                       'Task percentage on ${_provider.period == 'day' ? 'daily' : _provider.period == 'week' ? 'weekly' : 'monthly'} basis'),
//                               series: <ChartSeries>[
//                                 ColumnSeries<SalesDatas, double>(
//                                     dataSource: _provider.listOfGraphChart,
//                                     xValueMapper: (SalesDatas sales, _) =>
//                                         sales.year,
//                                     name: 'task',
//                                     // Enable data label
//                                     dataLabelSettings:
//                                         DataLabelSettings(isVisible: true),
//                                     yValueMapper: (SalesDatas sales, _) =>
//                                         sales.sales),
//                               ],
//                               tooltipBehavior: TooltipBehavior(
//                                   enable: true,
//                                   activationMode: ActivationMode.singleTap,
//                                   tooltipPosition: TooltipPosition.auto),
//                             )
