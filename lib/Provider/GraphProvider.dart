import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:upticker/Pages/Graph.dart';

class GraphProvider extends ChangeNotifier {
  List<SalesData> _listOfGraphline = [];
  List get listOfGraphline => _listOfGraphline;
  setListOfGraph(List list) {
    if (_period == 'day' || period == 'week') {
      for (var i in list) {
        Map map = i;
        var entryList = map.entries.toList();
        var per = double.parse('${entryList[0].value['percentage']}')
            .toStringAsFixed(2);
        print(entryList[0].key);
        print(entryList[0].value['percentage']);
        var newDt =
            DateFormat.yMMMEd().format(DateTime.parse('${entryList[0].key}'));
        print('${newDt.split(',')[1]}');
        _listOfGraphline.add(SalesData((entryList[0].key), double.parse(per)));
      }
    } else if (_period == 'month' || _period == 'year') {
      for (var i in list) {
        Map map = i;
        var entryList = map.entries.toList();
        var per = double.parse('${entryList[0].value['percentage']}')
            .toStringAsFixed(2);
        print(entryList[0].key);
        print(entryList[0].value['percentage']);
        _listOfGraphline
            .add(SalesData('${entryList[0].key}', double.parse(per)));
      }
    }
    notifyListeners();
  }

  List _listOfSubBucket = [];
  List get listOfSubBucket => _listOfSubBucket;
  setlistOfSubBucket(var data) {
    _listOfSubBucket.add(data);
    notifyListeners();
  }

  List<SalesData> _listOfBucket = [];
  List get listOfBucket => _listOfBucket;
  setlistOfBucket(Map map) {
    List entryList = map.entries.toList();
    for (var i = 0; i < entryList.length; i++) {
      print('key is = ${entryList[i].key}');
      var data = double.parse('${entryList[i].value['percentage']}')
          .toStringAsFixed(2);
      var cc = entryList[i].value['sub_buckets'];
      setlistOfSubBucket(cc);
      _listOfBucket.add(SalesData('${entryList[i].key}', double.parse(data)));
    }
    notifyListeners();
  }

  List<SalesData> _listOfSubBucketfinal = [];
  List get listOfSubBucketfinal => _listOfSubBucketfinal;
  setlistOfSubBucketfinal(Map map) {
    _listOfSubBucketfinal.clear();
    List entryList = map.entries.toList();
    for (var i = 0; i < entryList.length; i++) {
      print('key is = ${entryList[i].key}');
      String d = double.parse('${entryList[i].value['percentage']}')
          .toStringAsFixed(2);
      var data = double.parse(d);
      _listOfSubBucketfinal.add(SalesData('${entryList[i].key}', data));
    }
    notifyListeners();
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

class SalesDatas {
  SalesDatas(this.year, this.sales);
  final double year;
  final double sales;
}

List listofMonth = [
  '',
  'Jan',
  'Feb',
  'March',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
