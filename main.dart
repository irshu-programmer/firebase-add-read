import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

final Future<FirebaseApp> app = FirebaseApp.configure();
final reference = FirebaseDatabase.instance.reference();
List<WeightEntry> weightSaves = new List();
void main() => runApp(new MyApp());
var myList = FirebaseAnimatedList(
              query: reference,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(weightSaves[index].name),
                  subtitle: Text(weightSaves[index].message),
                );
              },
            );
var nameController = TextEditingController();
var messageController = TextEditingController();
var count = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firebase operation",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    reference.child("users").onChildAdded.listen(_onEntryAdded);
  }
//   }
  _onEntryAdded(Event event) {
    setState(() {
      weightSaves.add(new WeightEntry.fromSnapshot(event.snapshot));
      //  myList = myList;
    });
  }

  _addData() {
    setState(() {
      // print(nameController.text+" "+messageController.text);
      final entry = User(nameController.text, messageController.text);
      reference.child("users").push().set(entry.toJson());
      myList = myList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Firebase"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: messageController,
            decoration: InputDecoration(labelText: 'Message'),
          ),
          RaisedButton(
            onPressed: () {
              _addData();
            },
            child: Text('Add'),
          ),
          Flexible(
            child: myList
          ),
        ],
      ),
    );
  }
}

class User {
  String name;
  String message;

  User(this.name, this.message);

  toJson() {
    return {"name": name, "message": message};
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// final Future<FirebaseApp> app = FirebaseApp.configure();

// final reference = FirebaseDatabase.instance.reference();

// void main() => runApp(new MyApp());

// var nameController = TextEditingController();
// var messageController = TextEditingController();

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: "Getting Firebase",
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase"),
//       ),
//       body: Column(
//         children: <Widget>[
//           TextField(
//             controller: nameController,
//             decoration: InputDecoration(labelText: 'Name'),
//           ),
//           TextField(
//             controller: messageController,
//             decoration: InputDecoration(labelText: 'Message'),
//           ),
//           RaisedButton(
//             onPressed: _addData,
//             child: Text('Add'),
//           )
//         ],
//       ),
//     );
//   }

//   _addData() {
//     setState(() {
//       var entry = WeightEntry(nameController.text.toString(),messageController.text.toString());
//       // var entry = WeightEntry(nameController.text, messageController.text);
//       reference.child("users").push().set(entry);
//     });
//   }
// }

// class WeightEntry {
//   String name;
//   String message;
//   WeightEntry(this.name, this.message);
//   toJson() {
//     return {"name": name, "message": message};
//   }
// }
// }
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<WeightEntry> weightSaves = new List();
//   _HomePageState() {
//     reference.child("users").onChildAdded.listen(_onEntryAdded);
//   }

//   _onEntryAdded(Event event) {
//     setState(() {
//       weightSaves.add(new WeightEntry.fromSnapshot(event.snapshot));

//       print(weightSaves);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Column(
//         children: <Widget>[

//         ],
//       ),
//     );
//   }
// }

class WeightEntry {
  String key;
  // DateTime dateTime;
  // double weight;
  String message;
  String name;

  WeightEntry(this.message, this.name);

  WeightEntry.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,

        // new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        message = snapshot.value["message"],
        name = snapshot.value["name"];

  toJson() {
    return {"message": message, "name": name};
  }
}
