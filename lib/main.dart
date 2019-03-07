import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbus Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AIR-BUZZ'),
    );
  }
}

class MyHomePageRoute extends CupertinoPageRoute {
  MyHomePageRoute()
    : super(builder: (BuildContext context) => new MyHomePage());
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List list = List();
  var isLoading = false;

  /*_fetchMenu() async {
    final response = await http.get("https://airbus-aerothon.herokuapp.com/aerothon/program");

    if (response.statusCode == 200) {
      list = json.decode(response.body) as List;
    } else {
      throw Exception('Failed to load');
    }
  }*/

  _fetchData() async {

    setState(() {
      isLoading = true;
    });

    final response = await http.get("https://airbus-aerothon.herokuapp.com/aerothon/news");

    if (response.statusCode == 200) {
      list = json.decode(response.body) as List;
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  void choiceAction(String choice) {
    if(choice ==Constants.A320) {
      Navigator.of(context).push(new A320PageRoute());
    }
    else if(choice ==Constants.A330) {
      Navigator.of(context).push(new A330PageRoute());
    }
    else if(choice ==Constants.A350) {
      Navigator.of(context).push(new A350PageRoute());
    }
    else if(choice ==Constants.search){
      Navigator.of(context).push(new SearchPageRoute());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
            child: new Text("Refresh Feed"),
            onPressed: _fetchData,
          ),
      ),

      body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index]['newsHeadline']),
                    subtitle: new Text(list[index]['newsText']),
                  );
                }
              ),
    );
  }
}

class A320PageRoute extends CupertinoPageRoute {
  A320PageRoute()
    : super(builder: (BuildContext context) => new A320Page());
}

class A320Page extends StatefulWidget {

  A320Page({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _A320PageState createState() => _A320PageState();
}

class _A320PageState extends State<A320Page> {

  TextEditingController msn = new TextEditingController();
  TextEditingController flightNo = new TextEditingController();
  TextEditingController harnessLength = new TextEditingController();
  TextEditingController grossWeight = new TextEditingController();
  TextEditingController atmP = new TextEditingController();
  TextEditingController roomTemp = new TextEditingController();
  TextEditingController airport = new TextEditingController();
  TextEditingController fcapLwing = new TextEditingController();
  TextEditingController fcapRwing = new TextEditingController(); 
  TextEditingController fquantLwing = new TextEditingController();
  TextEditingController fquantRwing = new TextEditingController();
  TextEditingController maxAltitude = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A320'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('SEND', style: TextStyle(color: CupertinoColors.white,)),
              onPressed: () {
              },
              color: Colors.blue,
            ),
        ],
      ),
      body: Container(
        width: 400.0,
        padding: EdgeInsets.only(top: 20.0, left: 20.0),
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'MSN',
                hintText: 'MSN'
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'Flight No',
                hintText: 'Flight No'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Harness Length',
                hintText: 'Harness Length'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Gross Weight',
                hintText: 'Gross Weight'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Atm Press',
                hintText: 'Atmospheric Pressure'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Room Temp',
                hintText: 'Room Temperature'
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'Airport',
                hintText: 'Airport'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Cap (L)',
                hintText: 'Fuel Capacity (Left Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Cap (R)',
                hintText: 'Fuel Capacity (Right Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Quant (L)',
                hintText: 'Fuel Quantity (Left Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Quant (R)',
                hintText: 'Fuel Quantity (Right Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Max Target Altitude',
                hintText: 'Maximum altitude to be reached'
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class A330PageRoute extends CupertinoPageRoute {
  A330PageRoute()
    : super(builder: (BuildContext context) => new A330Page());
}

class A330Page extends StatefulWidget {

  A330Page({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _A330PageState createState() => _A330PageState();
}

class _A330PageState extends State<A330Page> {

  TextEditingController msn = new TextEditingController();
  TextEditingController flightNo = new TextEditingController();
  TextEditingController harnessLength = new TextEditingController();
  TextEditingController grossWeight = new TextEditingController();
  TextEditingController atmP = new TextEditingController();
  TextEditingController roomTemp = new TextEditingController();
  TextEditingController airport = new TextEditingController();
  TextEditingController fcapLwing = new TextEditingController();
  TextEditingController fcapRwing = new TextEditingController(); 
  TextEditingController fquantLwing = new TextEditingController();
  TextEditingController fquantRwing = new TextEditingController();
  TextEditingController maxAltitude = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A330'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('SEND', style: TextStyle(color: CupertinoColors.white,)),
              onPressed: () {
              },
              color: Colors.blue,
            ),
        ],
      ),
      body: Container(
        width: 400.0,
        padding: EdgeInsets.only(top: 20.0, left: 20.0),
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'MSN',
                hintText: 'MSN'
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'Flight No',
                hintText: 'Flight No'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Harness Length',
                hintText: 'Harness Length'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Gross Weight',
                hintText: 'Gross Weight'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Atm Press',
                hintText: 'Atmospheric Pressure'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Room Temp',
                hintText: 'Room Temperature'
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'Airport',
                hintText: 'Airport'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Cap (L)',
                hintText: 'Fuel Capacity (Left Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Cap (R)',
                hintText: 'Fuel Capacity (Right Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Quant (L)',
                hintText: 'Fuel Quantity (Left Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Quant (R)',
                hintText: 'Fuel Quantity (Right Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Max Target Altitude',
                hintText: 'Maximum altitude to be reached'
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class A350PageRoute extends CupertinoPageRoute {
  A350PageRoute()
    : super(builder: (BuildContext context) => new A350Page());
}

class A350Page extends StatefulWidget {

  A350Page({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _A350PageState createState() => _A350PageState();
}

class _A350PageState extends State<A350Page> {

  TextEditingController msn = new TextEditingController();
  TextEditingController flightNo = new TextEditingController();
  TextEditingController harnessLength = new TextEditingController();
  TextEditingController grossWeight = new TextEditingController();
  TextEditingController atmP = new TextEditingController();
  TextEditingController roomTemp = new TextEditingController();
  TextEditingController airport = new TextEditingController();
  TextEditingController fcapLwing = new TextEditingController();
  TextEditingController fcapRwing = new TextEditingController(); 
  TextEditingController fquantLwing = new TextEditingController();
  TextEditingController fquantRwing = new TextEditingController();
  TextEditingController maxAltitude = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A350'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('SEND', style: TextStyle(color: CupertinoColors.white,)),
              onPressed: () {
              },
              color: Colors.blue,
            ),
        ],
      ),
      body: Container(
        width: 400.0,
        padding: EdgeInsets.only(top: 20.0, left: 20.0),
        child: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'MSN',
                hintText: 'MSN'
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'Flight No',
                hintText: 'Flight No'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Harness Length',
                hintText: 'Harness Length'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Gross Weight',
                hintText: 'Gross Weight'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Atm Press',
                hintText: 'Atmospheric Pressure'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Room Temp',
                hintText: 'Room Temperature'
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                labelText: 'Airport',
                hintText: 'Airport'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Cap (L)',
                hintText: 'Fuel Capacity (Left Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Cap (R)',
                hintText: 'Fuel Capacity (Right Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Quant (L)',
                hintText: 'Fuel Quantity (Left Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Fuel Quant (R)',
                hintText: 'Fuel Quantity (Right Wing)'
              ),
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Max Target Altitude',
                hintText: 'Maximum altitude to be reached'
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class SearchPageRoute extends CupertinoPageRoute {
  SearchPageRoute()
    : super(builder: (BuildContext context) => new SearchPage());
}

class SearchPage extends StatefulWidget {

  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search & Filter'),
      ),
      body: Container(
        child: Text('Search & Filter Page Details'),
      ),
    );
  }
}
