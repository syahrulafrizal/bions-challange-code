import 'dart:convert';

Crypto cryptoFromJson(String str) => Crypto.fromJson(json.decode(str));

String cryptoToJson(Crypto data) => json.encode(data.toJson());

class Crypto {
  String? s;
  String? p;
  String? q;
  String? dc;
  String? dd;
  int? t;
  DateTime? dateTime;

  Crypto({this.s, this.p, this.q, this.dc, this.dd, this.t, this.dateTime});

  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        s: json["s"],
        p: json["p"],
        q: json["q"],
        dc: json["dc"],
        dd: json["dd"],
        t: json["t"],
        dateTime: json["t"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                json["t"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "s": s,
        "p": p,
        "q": q,
        "dc": dc,
        "dd": dd,
        "t": t,
        "dateTime": dateTime,
      };
}
