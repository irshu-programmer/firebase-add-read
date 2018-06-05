# firebase-add-read

![screen shot 2018-06-05 at 1 40 47 pm](https://user-images.githubusercontent.com/39940314/40963452-316ff852-68c6-11e8-9ef3-a5d5bbb00951.png)


in pubspec.yamal 

                   
                       firebase_auth:
                       firebase_database:
                       firebase_core:


1) Configure firebase app
                      final Future<FirebaseApp> app = FirebaseApp.configure();

2) Database Reference
                      final reference = FirebaseDatabase.instance.reference();

3) in home state
  
                     class _MyHomePageState extends State<MyHomePage> {
                          _addData() {
                           setState(() {
                            final entry = User(nameController.text, messageController.text);
                           reference.child("users").push().set(entry.toJson());
                           myList = myList;
                          });
                       }

5) this is the model class to organize data
        
                     class User {
                               String name;
                               String message;
                               User(this.name, this.message);
                              toJson() {
                                    return {"name": name, "message": message};
                                   }
                         }



Reading data
                    List<WeightEntry> weightSaves = new List();

                      _MyHomePageState() {
                               reference.child("users").onChildAdded.listen(_onEntryAdded);
                          }

                            _onEntryAdded(Event event) {
                              setState(() {
                              weightSaves.add(new WeightEntry.fromSnapshot(event.snapshot));
      
                             });

This is the model class to fetc data
                     
                          class WeightEntry {
                                  String key;
                                  String message;
                                  String name;
                                  WeightEntry(this.message, this.name);
                                  WeightEntry.fromSnapshot(DataSnapshot snapshot)
                                     : key = snapshot.key,
                                    message = snapshot.value["message"],
                                     name = snapshot.value["name"];
                                      toJson() {
                                     return {"message": message, "name": name};
                                     } 
                               }

if you get any doubts please contact me programmerirshad@gmail.com
