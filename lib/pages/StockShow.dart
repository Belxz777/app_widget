import 'package:flutter/material.dart';
import 'package:homescreen_widget/types/Stonks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockWidget extends StatefulWidget {

  @override
  _StockWidgetState createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  SecuritiesData? tatneftCurs;//TATN
    SecuritiesData? rusalCurs;//RUAL
        SecuritiesData? aptekaCurs;//APTK
            SecuritiesData? mmkCurs;//MAGN
                SecuritiesData? alrosaCurs;//ALRS
                SecuritiesData? vkCurs;//VKCO
                SecuritiesData? sberCurs; //SBER
  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

    Future<void> fetchStockData() async {
    final response = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/TATN.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
setState(() {
        tatneftCurs = SecuritiesData.fromJson(jsonData);
      });
  } else {
    throw Exception('Failed to load data');
  }
      final rusal = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/RUAL.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (rusal.statusCode == 200) {
    var jsonData = json.decode(rusal.body);
setState(() {
        rusalCurs = SecuritiesData.fromJson(jsonData);
      });
  } else {
    throw Exception('Failed to load data');
  }
    final apteka = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/APTK.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (apteka.statusCode == 200) {
    var jsonData = json.decode(apteka.body);
setState(() {
        aptekaCurs = SecuritiesData.fromJson(jsonData);
      });
  } else {
    throw Exception('Failed to load data');
  }
  final alrosa = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/ALRS.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (alrosa.statusCode == 200) {
    var jsonData = json.decode(alrosa.body);
setState(() {
        alrosaCurs= SecuritiesData.fromJson(jsonData);
      });
  } else {
    throw Exception('Failed to load data');
  }  
  final mmk = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/MAGN.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (mmk.statusCode == 200) {
    var jsonData = json.decode(mmk.body);
setState(() {
        mmkCurs = SecuritiesData.fromJson(jsonData);
      });
  } else {
    throw Exception('Failed to load data');
  }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Information')),
      body: Center(
        child: tatneftCurs !=null && rusalCurs !=null && aptekaCurs !=null && alrosaCurs !=null && mmkCurs !=null 
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Название акции: ${tatneftCurs!.marketdata.data[0][0]}'),
                  Text('Цена: ${tatneftCurs!.marketdata.data[0][12]} ₽'),
                   Text('Изменение проценты: ${tatneftCurs!.marketdata.data[0][25]} %'),
                      Text('Изменение рубли: ${tatneftCurs!.marketdata.data[0][40]} ₽'),
                  Text('Название акции: ${rusalCurs!.marketdata.data[0][0]}'),
                  Text('Цена: ${rusalCurs!.marketdata.data[0][12]} ₽'),
                  Text('Название акции: ${aptekaCurs!.marketdata.data[0][0]}'),
                  Text('Цена: ${aptekaCurs!.marketdata.data[0][12]} ₽'),
                  Text('Название акции: ${alrosaCurs!.marketdata.data[0][0]}'),
                  Text('Цена: ${alrosaCurs!.marketdata.data[0][12]} ₽'),
                  Text('Изменение проценты: ${alrosaCurs!.marketdata.data[0][25]} %'),
                      Text('Изменение рубли: ${alrosaCurs!.marketdata.data[0][40]} ₽'),
                  Text('Название акции: ${mmkCurs!.marketdata.data[0][0]}'),
                  Text('Цена: ${mmkCurs!.marketdata.data[0][12]} ₽'),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}