import 'package:doctor_dreams/widgets/animated_chart/chart/chart_line.dart';
import 'package:doctor_dreams/widgets/animated_chart/chart/datetime_series_converter.dart';
import 'package:doctor_dreams/widgets/animated_chart/chart/line_chart.dart';
import 'package:doctor_dreams/widgets/animated_chart/common/dates.dart';
import 'package:doctor_dreams/widgets/animated_chart/common/pair.dart';
import 'package:flutter/rendering.dart';

class AreaLineChart extends LineChart {
  Map<int, Path> _areaPathMap = Map();
  final FontWeight? tapTextFontWeight;
  final String? yAxisName;
  final List<Pair<Color, Color>>? _gradients;

  AreaLineChart(List<ChartLine> lines, Dates fromTo, this._gradients,
      {this.tapTextFontWeight, this.yAxisName})
      : super(lines, fromTo,
            tapTextFontWeight: tapTextFontWeight, yAxisName: yAxisName);

  factory AreaLineChart.fromDateTimeMaps(List<Map<DateTime, double>> series,
      List<Color> colors, List<String> units,
      {List<Pair<Color, Color>>? gradients,
      FontWeight? tapTextFontWeight,
      String? yAxisName}) {
    assert(series.length == colors.length);
    assert(series.length == units.length);

    Pair<List<ChartLine>, Dates> convertFromDateMaps =
        DateTimeSeriesConverter.convertFromDateMaps(series, colors, units);
    return AreaLineChart(
        convertFromDateMaps.left, convertFromDateMaps.right, gradients,
        tapTextFontWeight: tapTextFontWeight, yAxisName: yAxisName);
  }

  List<Pair<Color, Color>>? get gradients => _gradients;

  Path? getAreaPathCache(int index) {

      Path pathCache = getPathCache(index)!;

      Path areaPath = Path();



      _areaPathMap[index] = areaPath;
      return areaPath;
    }

}
