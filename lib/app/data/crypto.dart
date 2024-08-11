import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';

Crypto cryptoFromJson(String str) => Crypto.fromJson(json.decode(str));

class Crypto {
  String? icon;
  String? s;
  num? p;
  num? q;
  num? dc;
  num? dd;
  int? t;
  double? maxY;
  double? minY;
  DateTime? updatedAt;
  List<FlSpot>? chart;

  Crypto({
    this.s,
    this.icon,
    this.p,
    this.q,
    this.dc,
    this.dd,
    this.t,
    this.updatedAt,
    this.chart,
    this.maxY,
    this.minY,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        s: json["s"],
        icon: json["icon"],
        p: num.tryParse(json["p"] ?? "0"),
        q: num.tryParse(json["q"] ?? "0"),
        dc: num.tryParse(json["dc"] ?? "0"),
        dd: num.tryParse(json["dd"] ?? "0"),
        t: json["t"],
        maxY: json["maxY"] ?? 0,
        minY: json["minY"] ?? 0,
        chart: json["chart"] ?? [],
        updatedAt: json["t"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                json["t"],
              ),
      );
}
