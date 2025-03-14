import 'package:flutter/material.dart';
import 'novi.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'recept.dart';
void main() {
  Gemini.init(apiKey: 'AIzaSyD18Rmm1gGqt3Pyx6TkIxJeqd5EvtC68eo');
 
  runApp(const MainApp());
}

void buildRecept(BuildContext context, List<Sastojak> sastojci) {
  String recept = '';
  for (int i = 0; i < sastojci.length; i++) {
    recept += '${sastojci[i].getTekst()} - ${sastojci[i].getKolicina()}\n';
  }
  Gemini.instance.prompt(parts: [
    Part.text('Give me a recepie only using these ingredients:'),
    Part.text(recept),
  ]).then((value) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ReceptScreen(recept: value?.output ?? '')),
    );
  });
}

class Sastojak {
  String tekst;
  String kolicina;

  Sastojak(this.tekst, this.kolicina){
    this.tekst = tekst;
    this.kolicina = kolicina;
  }

  String getTekst() {
    return tekst;
  }

  String getKolicina() {
    return kolicina;
  }

}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Sastojak> sastojci = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('AI Recept Generator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
              child:
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 2),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: sastojci.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.green[500],
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Sastojak ${index+1}: ${sastojci[index].getTekst()}'),
                          ),
                          ElevatedButton(
                          onPressed: () {
                          sastojci.removeAt(index);
                          setState(() {});
                          },
                          child: const Icon(Icons.delete),
                          ),
                          Expanded(
                            child: Text('Količina: ${sastojci[index].getKolicina()}'),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              ),
              ),
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Builder(
    builder: (context) =>
    ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddTaskScreen(addTaskCallback: (text, kolicina) {
            setState(() {
              sastojci.add(Sastojak(text, kolicina));
            });
          })),
        );
      },
      child: const Text('Novi sastojak'),
    ),
    ),
    Builder(
    builder: (context) =>
    ElevatedButton(
      onPressed: () {
        buildRecept(context, sastojci
        );
      },
      child: const Text('Generiraj recept'),
    ),
    ),
    ElevatedButton(
      onPressed: () {
        sastojci.clear();
        setState(() {});
      },
      child: const Icon(Icons.delete),
    ),
  ],
),

            ],
          ),
        ),
      ),
    );
  }
}
