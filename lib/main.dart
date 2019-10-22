import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ping What Mattrs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Ping What Mattrs',
      ),
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
  String dropdownValue = 'Chase';
  List<String> players = ['Chase', 'Josh'];

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text('Already have an account?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.account_circle),
              iconSize: 32,
              elevation: 16,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
              ),
              underline: Container(
                height: 2,
                color: Colors.blueGrey,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: players.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Text(
              'Or create a new Player!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              width: 215.0,
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: myController,
                maxLength: 25,
                style: TextStyle(color: Colors.blueAccent),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                onSubmitted: (text) {
                  setState(() {
                    players.add('$text');
                    dropdownValue = text;
                  });
                },
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  String text = myController.text;
                  players.add('$text');
                  // debugPrint(text);
                  dropdownValue = myController.text;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpponentPage(
                            dropdownValue: dropdownValue, players: players)));
              },
              color: Colors.blue,
              child: Text('Let\'s GO!', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class OpponentPage extends StatelessWidget {
  final String dropdownValue;
  final List players;

  OpponentPage({
    Key key,
    @required this.dropdownValue,
    @required this.players,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$dropdownValue, who'd you play against?",
        ),
      ),
      body: ListView.builder(
        reverse: false,
        itemCount: this.players.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultsPage(
                            dropdownValue: dropdownValue,
                            opponent: this.players[index])));
              },
              title: Text(this.players[index]),
            ),
          );
        },
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final String dropdownValue;
  final String opponent;

  ResultsPage({
    Key key,
    @required this.dropdownValue,
    @required this.opponent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "And the final score?",
        ),
      ),
      body: Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0.0, 0.0),
            width: 200,
            height: 50,
            child: Text(
              dropdownValue,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment(0.0, 0.0),
            width: 200,
            height: 50,
            child: Text(
              opponent,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
