import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:upticker/Pages/Graph.dart';

class BarChartSample3 extends StatefulWidget {
  final List<SalesData> list;
  const BarChartSample3({Key key, this.list}) : super(key: key);
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.black,
        child: BarChart(
          BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 120,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipBottomMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 15,
                  getTextStyles: (value) => const TextStyle(
                      color: Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 8),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return '';
                      case 1:
                        return 'Te';
                      case 2:
                        return 'Wd';
                      case 3:
                        return 'Tu';
                      case 4:
                        return 'Fr';
                      case 5:
                        return 'St';
                      case 6:
                        return 'Sn';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: widget.list.map((e) {
                SalesData data = e;
                return BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        borderRadius: BorderRadius.circular(0),
                        y: data.sales,
                        colors: [
                          Color.fromARGB(255, 253, 85, 20),
                        ],
                        width: 30)
                  ],
                  showingTooltipIndicators: [0],
                );
              }).toList()),
        ),
      ),
    );
  }
}
