class MarketData {
  List<String> columns;
  List<List<dynamic>> data;

  MarketData({required this.columns, required this.data});

  factory MarketData.fromJson(Map<String, dynamic> json) {
    return MarketData(
      columns: List<String>.from(json['columns']),
      data: List<List<dynamic>>.from(json['data'].map((data) => List<dynamic>.from(data))),
    );
  }
}

class SecuritiesData {
  MarketData marketdata;

  SecuritiesData({required this.marketdata});

  factory SecuritiesData.fromJson(Map<String, dynamic> json) {
    return SecuritiesData(
      marketdata: MarketData.fromJson(json['marketdata']),
    );
  }
}