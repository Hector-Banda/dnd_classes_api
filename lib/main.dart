import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

Future<Classes> fetchClass() async {
  final response = await http.get('https://www.dnd5eapi.co/api/classes');

  if (response.statusCode == 200) {
    return Classes.fromJson(json.decode(response.body));
  } else {
    throw Exception('No se pudo encontrar información');
  }
}

class Classes {
  final int count;
  final List<dynamic> results;

  Classes({this.count, this.results});

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
      count: json['count'],
      results: json['results'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Clases Dungeons&Dragons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Classes> futureClass;

  @override
  void initState() {
    super.initState();
    futureClass = fetchClass();
  }

  Widget classToInfo(String clase) {
    switch (clase) {
      case "barbarian":
        return Text('Guerrero feroz de origen primitivo');
      case "bard":
        return Text('Mago inspirador basado en musica');
      case "cleric":
        return Text('Campeon sacerdotal con magia divina');
      case "druid":
        return Text('Sacerdote con poder de la naturaleza');
      case "fighter":
        return Text('Maestro del combate marcial');
      case "monk":
        return Text('Maestro de artes marciales');
      case "paladin":
        return Text('Guerrero santo, juramento sagrado');
      case "ranger":
        return Text('Defensor de fronteras');
      case "rogue":
        return Text('Guerrero embustero');
      case "sorcerer":
        return Text('Lanzador de conjuros');
      case "warlock":
        return Text('Portador magico derivado de un pacto');
      case "wizard":
        return Text('Mago capaz de manipular la realidad');
      default:
        return Text("No data");
    }
  }

  Widget classToImg(String clase) {
    switch (clase) {
      case "barbarian":
        return Image.asset(
          "images/barbarian.jpg",
          width: 50,
          height: 50,
        );
      case "bard":
        return Image.asset(
          "images/bard.jpg",
          width: 50,
          height: 50,
        );
      case "cleric":
        return Image.asset(
          "images/cleric.jpg",
          width: 50,
          height: 50,
        );
      case "druid":
        return Image.asset(
          "images/druid.jpg",
          width: 50,
          height: 50,
        );
      case "fighter":
        return Image.asset(
          "images/fighter.jpg",
          width: 50,
          height: 50,
        );
      case "monk":
        return Image.asset(
          "images/monk.jpg",
          width: 50,
          height: 50,
        );
      case "paladin":
        return Image.asset(
          "images/paladin.jpg",
          width: 50,
          height: 50,
        );
      case "ranger":
        return Image.asset(
          "images/ranger.jpg",
          width: 50,
          height: 50,
        );
      case "rogue":
        return Image.asset(
          "images/rogue.jpg",
          width: 50,
          height: 50,
        );
      case "sorcerer":
        return Image.asset(
          "images/sorcerer.jpg",
          width: 50,
          height: 50,
        );
      case "warlock":
        return Image.asset(
          "images/warlock.jpg",
          width: 50,
          height: 50,
        );
      case "wizard":
        return Image.asset(
          "images/wizard.jpg",
          width: 50,
          height: 50,
        );
      default:
        return Text("No data");
    }
  }

  Widget classTile(Classes clase, int count) {
    var clases = Text(
      clase.results[count]["count"].toString(),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              classToImg(clase.results[count]["index"].toString()),
              classToInfo(clase.results[count]["index"].toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: FutureBuilder<Classes>(
                  future: futureClass,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          classTile(snapshot.data, 0),
                          classTile(snapshot.data, 1),
                          classTile(snapshot.data, 2),
                          classTile(snapshot.data, 3),
                          classTile(snapshot.data, 4),
                          classTile(snapshot.data, 5),
                          classTile(snapshot.data, 6),
                          classTile(snapshot.data, 7),
                          classTile(snapshot.data, 8),
                          classTile(snapshot.data, 9),
                          classTile(snapshot.data, 10),
                          classTile(snapshot.data, 11),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      );
                    } else {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
