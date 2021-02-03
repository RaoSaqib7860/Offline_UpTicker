import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:upticker/Pages/Graph.dart';

class GraphSubBucketProvider extends ChangeNotifier {
  List<SalesData> _listOfGraphline = [];
  List get listOfGraphline => _listOfGraphline;
  setlistOfGraph(List list) {
    _listOfGraphline.clear();
    for (var i = 0; i < list.length; i++) {
      Map map = list[i];
      var entryList = map.entries.toList();
      print(entryList[0].key);
      String value = double.parse('${entryList[0].value['percentage']}')
          .toStringAsFixed(2);
      var newDt =
          DateFormat.yMMMEd().format(DateTime.parse('${entryList[0].key}'));
      print('$newDt');
      // _listOfGraphline.add(SalesData(
      //     _period == 'day'
      //         ? '${newDt.split(',')[0]}'
      //         : _period == 'week'
      //             ? '${newDt.split(',')[1]}'
      //             : _period == 'month'
      //                 ? '${newDt.split(',')[1]}'
      //                 : '${newDt.split(',')[2]}',
      //     double.parse(value)));
      _listOfGraphline
          .add(SalesData('${entryList[0].key}', double.parse(value)));
    }
  }

  String _period = 'day';
  String get period => _period;
  setPeriod(String p) {
    _period = p;
    notifyListeners();
  }

  bool _lineChartis = true;
  bool get lineChart => _lineChartis;
  setLineChart(bool v) {
    _lineChartis = v;
    notifyListeners();
  }

  bool _barCharts = false;
  bool get barCharts => _barCharts;
  setbarCharts(bool v) {
    _barCharts = v;
    notifyListeners();
  }

  bool _pieChart = false;
  bool get pieChart => _pieChart;
  setpieChart(bool v) {
    _pieChart = v;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool v) {
    _loading = v;
    notifyListeners();
  }

  bool _loadingBucket = false;
  bool get loadingBucket => _loadingBucket;
  setloadingBucket(bool v) {
    _loadingBucket = v;
    notifyListeners();
  }

  bool _loadingSubBucket = false;
  bool get loadingSubBucket => _loadingSubBucket;
  setloadingSubBucket(bool v) {
    _loadingSubBucket = v;
    notifyListeners();
  }

  bool _day = true;
  bool get day => _day;
  setdays(bool v) {
    _day = v;
    notifyListeners();
  }

  bool _week = false;
  bool get week => _week;
  setweek(bool v) {
    _week = v;
    notifyListeners();
  }

  bool _month = false;
  bool get month => _month;
  setmonth(bool v) {
    _month = v;
    notifyListeners();
  }

  bool _year = false;
  bool get year => _year;
  setyear(bool v) {
    _year = v;
    notifyListeners();
  }

  setAllDays() {
    setdays(false);
    setmonth(false);
    setweek(false);
    setyear(false);
    notifyListeners();
  }

  setAllCharts() {
    setLineChart(false);
    setbarCharts(false);
    setpieChart(false);
    notifyListeners();
  }
}
