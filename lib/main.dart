import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:home_widget/home_widget.dart';
import 'package:homescreen_widget/pages/StockShow.dart';
import 'package:homescreen_widget/pages/Total.dart';
import 'package:homescreen_widget/types/Stonks.dart';
import 'package:homescreen_widget/waste/Waste.dart';
import 'package:http/http.dart' as http;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
  
}

List<String> titles = <String>[
  'Календарь  ',
  'Домашняя',
  'Курс'
];
var dateTime = DateTime.now();
var day = dateTime.day;
var month = dateTime.month;
var year = dateTime.year;
List<String> phases = <String>[
  'Советы мы принимаем каплями, зато раздаём ведрами',
  'Побороть дурные привычки можно только сегодня, а не завтра.',
  'Три вещи никогда не возвращаются обратно – время, слово, возможность. Поэтому: не теряй времени, выбирай слова, не упускай возможность.',
  ' Благородный человек предъявляет требования к себе, низкий человек предъявляет требования к другим',
  ' Люди в древности не любили много говорить. Они считали позором для себя не поспеть за собственными словами',
  '.Я не огорчаюсь, если люди меня не понимают, — огорчаюсь, если я не понимаю людей.',
  'Если ты ненавидишь – значит тебя победили',
  'Перед тем как мстить, вырой две могилы',
  ' В стране, где есть порядок, будь смел и в действиях, и в речах. В стране, где нет порядка, будь смел в действиях, но осмотрителен в речах',
  'На самом деле, жизнь проста, но мы настойчиво её усложняем',
  ' Лишь когда приходят холода, становится ясно, что сосны и кипарисы последними теряют свой убор .',
  'Счастье — это когда тебя понимают, большое счастье — это когда тебя любят, настоящее счастье — это когда любишь ты',
  'Красота есть во всем, но не всем дано это видеть',
  'Если тебе плюют в спину, значит ты впереди',
  'Давай наставления только тому, кто ищет знаний, обнаружив свое невежество',
  ' Не тот велик, кто никогда не падал, а тот велик – кто падал и вставал',
];
  var random = Random();
  var randomIndex =  random.nextInt(phases.length);
  var randomElement = phases[randomIndex];
String increaseTimeByOneHour(String timeString) {
  List<String> timeParts = timeString.split(":");
  
  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);
  int seconds = int.parse(timeParts[2]);
  
  hours = (hours + 1) % 24; // увеличиваем часы на 1 и обрабатываем переход через полночь
  
  String newTimeString = "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  
  return newTimeString;
}
// TODO завтра доделать , то есть добавить 4 компании и апк загрузить
// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {
SecuritiesData companyOne;
SecuritiesData companyTwo;
SecuritiesData companyThree;
SecuritiesData companyFour;
SecuritiesData companyFive;
   final tatneft = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/TATN.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (tatneft.statusCode == 200) {
    var jsonData = json.decode(tatneft.body);
    companyOne = SecuritiesData.fromJson(jsonData);
  } else {
    throw Exception('Ошибка в загрузке данных о Tatneft');
  }
     final alrosa = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/ALRS.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (alrosa.statusCode == 200) {
    var jsonData = json.decode(alrosa.body);
    companyTwo= SecuritiesData.fromJson(jsonData);
  } else {
    throw Exception('Ошибка в загрузке данных о alrosa');
  }
       final rusal = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/RUAL.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (rusal.statusCode == 200) {
    var jsonData = json.decode(rusal.body);
    companyThree= SecuritiesData.fromJson(jsonData);
  } else {
    throw Exception('Ошибка в загрузке данных о rusal');
  }
     final apteka = await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/APTK.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (apteka.statusCode == 200) {
    var jsonData = json.decode(apteka.body);
    companyFour= SecuritiesData.fromJson(jsonData);
  } else {
    throw Exception('Ошибка в загрузке данных о apteka');
  }
       final mmk= await http.get(Uri.parse('https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities/MAGN.json?iss.meta=off&iss.only=marketdata&securities.columns=LAST'));
     if (mmk.statusCode == 200) {
    var jsonData = json.decode(mmk.body);
    companyFive= SecuritiesData.fromJson(jsonData);
  } else {
    throw Exception('Ошибка в загрузке данных о mmk');
  }
  if (uri?.host == 'updatecounter') {
    int counter = 0;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      counter = value!;
      counter++;
    });

    await HomeWidget.saveWidgetData<int>('_counter', counter);
    if(companyOne.marketdata.data[0][12] == null){
                   await HomeWidget.getWidgetData("_company1", defaultValue:"")
    .then((value){
value  = "Не загрузилось";
    });
      await HomeWidget.getWidgetData<String>("_price1", defaultValue:"")
    .then((value){
value  = ".....";
    });
    await HomeWidget.getWidgetData<String>("_change1", defaultValue:"")
    .then((value){
value  = ".....";
    });
       await HomeWidget.getWidgetData<String>("_time", defaultValue:"")
    .then((value){
value  = ".....";
    });
    }  
    else{
             await HomeWidget.getWidgetData("_company1", defaultValue:"")
    .then((value){
value  = companyOne.marketdata.data[0][0] ;
    });
        await HomeWidget.saveWidgetData<String>("_company1", companyOne.marketdata.data[0][0]);
        await HomeWidget.saveWidgetData<String>("_price1", companyOne.marketdata.data[0][12].toString() );
     await HomeWidget.saveWidgetData<String>("_change1", companyOne.marketdata.data[0][40].toString() );
     var time = increaseTimeByOneHour( companyOne.marketdata.data[0][32].toString());
      await HomeWidget.saveWidgetData<String>("_time", time );
    }
     if(companyTwo.marketdata.data[0][12] == null){
                   await HomeWidget.getWidgetData("_company2", defaultValue:"")
    .then((value){
value  = "Не загрузилось";
    });
      await HomeWidget.getWidgetData<String>("_price2", defaultValue:"")
    .then((value){
value  = ".....";
    });
    await HomeWidget.getWidgetData<String>("_change2", defaultValue:"")
    .then((value){
value  = ".....";
    });
    }  
    else{
             await HomeWidget.getWidgetData("_company2", defaultValue:"")
    .then((value){
value  = companyTwo.marketdata.data[0][0] ;
    });
        await HomeWidget.saveWidgetData<String>("_company2", companyTwo.marketdata.data[0][0]);
        await HomeWidget.saveWidgetData<String>("_price2", companyTwo.marketdata.data[0][12].toString() );
     await HomeWidget.saveWidgetData<String>("_change2", companyTwo.marketdata.data[0][40].toString() );
    }
         if(companyThree.marketdata.data[0][12] == null){
                   await HomeWidget.getWidgetData("_company3", defaultValue:"")
    .then((value){
value  = "Не загрузилось";
    });
      await HomeWidget.getWidgetData<String>("_price3", defaultValue:"")
    .then((value){
value  = ".....";
    });
    await HomeWidget.getWidgetData<String>("_change3", defaultValue:"")
    .then((value){
value  = ".....";
    });
    }  
    else{
             await HomeWidget.getWidgetData("_company3", defaultValue:"")
    .then((value){
value  = companyThree.marketdata.data[0][0] ;
    });
        await HomeWidget.saveWidgetData<String>("_company3", companyThree.marketdata.data[0][0]);
        await HomeWidget.saveWidgetData<String>("_price3", companyThree.marketdata.data[0][12].toString() );
     await HomeWidget.saveWidgetData<String>("_change3", companyThree.marketdata.data[0][40].toString() );
    }
             if(companyFour.marketdata.data[0][12] == null){
                   await HomeWidget.getWidgetData("_company4", defaultValue:"")
    .then((value){
value  = "Не загрузилось";
    });
      await HomeWidget.getWidgetData<String>("_price4", defaultValue:"")
    .then((value){
value  = ".....";
    });
    await HomeWidget.getWidgetData<String>("_change4", defaultValue:"")
    .then((value){
value  = ".....";
    });
    }  
    else{
             await HomeWidget.getWidgetData("_company4", defaultValue:"")
    .then((value){
value  = companyFour.marketdata.data[0][0] ;
    });
        await HomeWidget.saveWidgetData<String>("_company4", companyFour.marketdata.data[0][0]);
        await HomeWidget.saveWidgetData<String>("_price4", companyFour.marketdata.data[0][12].toString() );
     await HomeWidget.saveWidgetData<String>("_change4", companyFour.marketdata.data[0][40].toString() );
    }
                 if(companyFive.marketdata.data[0][12] == null){
                   await HomeWidget.getWidgetData("_company5", defaultValue:"")
    .then((value){
value  = "Не загрузилось";
    });
      await HomeWidget.getWidgetData<String>("_price5", defaultValue:"")
    .then((value){
value  = ".....";
    });
    await HomeWidget.getWidgetData<String>("_change5", defaultValue:"")
    .then((value){
value  = ".....";
    });
    }  
    else{
             await HomeWidget.getWidgetData("_company5", defaultValue:"")
    .then((value){
value  = companyFive.marketdata.data[0][0] ;
    });
        await HomeWidget.saveWidgetData<String>("_company5", companyFive.marketdata.data[0][0]);
        await HomeWidget.saveWidgetData<String>("_price5", companyFive.marketdata.data[0][12].toString() );
     await HomeWidget.saveWidgetData<String>("_change5", companyFive.marketdata.data[0][40].toString() );
    }



    
    await HomeWidget.updateWidget(
        //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Приложения для просмотра акций MOEX ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Moex Stonks Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String company = "Акции";
String price = "Цены";
String change = "И их изменения";
  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData(); // This will load data from widget every time app is opened
  }

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value!;
    });
    await HomeWidget.getWidgetData("_company1", defaultValue:"")
    .then((value){
company  = value!;
    });
        await HomeWidget.getWidgetData("_price1", defaultValue:"")
    .then((value){
price  = value!;
    });
            await HomeWidget.getWidgetData("_change1", defaultValue:"")
    .then((value){
change  = value!;
    });
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.saveWidgetData<String>('_company1', company);
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    updateAppWidget();
  }

  @override
  Widget build(BuildContext context) {
     const int tabsCount = 3;
  return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          /*
          Сделать завтра красивое появление цитат добавить функциональность добавления заметок и отметку дней в календаре
          */
          title: Text("Приложение для просмотра цен акции биржи MOEX",style: const TextStyle(fontSize: 24 , fontFamily: 'italic'),),
          
        
          actions: 
            <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'MOEX',
            onPressed: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StockWidget ()),
            );
            },
          ),
          ],
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.calendar_today),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.home),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.monetization_on),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
           CalendarDart(context),
   // ignore: prefer_const_constructors
   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          // ignore: prefer_const_constructors
          Text(
               'Здравствуйте , Александр ' ,
            ),     
          ],
        ),
        StockWidget()
          ],),
         floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
      ),
    );
  }
}

Widget CalendarDart (BuildContext  context){
  return Container(
    child: Column(
      children: [
        hintForAdd(context),
        HeatMap(
  datasets: {
    DateTime(year, month, day): 3,

  },
  colorMode: ColorMode.opacity,
startDate: DateTime.now().add(const Duration(days:-60)),
endDate:DateTime.now().add(const Duration(days:30)),
size: 40,
  showText: true,
  scrollable: true,
defaultColor: Color.fromARGB(255, 206, 220, 208),
  colorsets: {
    1: Color.fromARGB(255, 128, 237, 4),
    3: Colors.green,
    5: Colors.yellow,
    7: Colors.green,
    9: Colors.blue,
    11: Colors.indigo,
    13: Colors.purple,
  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
)
      ],
    ),
  );
  }
Widget hintForAdd ( BuildContext context){
  return  Text(randomElement,   style: TextStyle(
  color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  ),
  textAlign: TextAlign.center,
  overflow: TextOverflow.clip,
  maxLines: 3,);
}