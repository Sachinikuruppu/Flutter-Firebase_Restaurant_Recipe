import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB9Nuj91UflgN448KHBr72v-H1jhM3xG-w",
            authDomain: "inclass14ys1.firebaseapp.com",
            projectId: "inclass14ys1",
            storageBucket: "inclass14ys1.appspot.com",
            messagingSenderId: "997441661820",
            appId: "1:997441661820:web:8c9df7ccaa604f8c0712f9",
            measurementId: "G-RQEJYQTWFS"));
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.cyan),
      home: MyWidget(),
    ));
  } else {
    await Firebase.initializeApp();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late String title, description, ingredients;

  gettitle(Title) {
    this.title = Title;
  }

  getdescription(Description) {
    this.description = Description;
  }

  getingredients(Ingredients) {
    this.ingredients = Ingredients;
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myinclassproject1").doc(title);

    Map<String, dynamic> recepies = {
      title: "title",
      description: "description",
      ingredients: "ingredients"
    };

    documentReference.set(recepies).whenComplete(() => print("Recipe Created"));
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myinclassproject1").doc(title);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot["title"]);
      print(datasnapshot["description"]);
      print(datasnapshot["ingredients"]);
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myinclassproject1").doc(title);

    Map<String, dynamic> recepies = {
      "title": title,
      "description": description,
      "ingredients": ingredients,
    };

    documentReference.set(recepies).whenComplete(() {
      print("$title Updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myinclassproject1").doc(title);

    documentReference.delete().whenComplete(() {
      print("Recepie Deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inclass Activity 1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Title",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String Title) {
                  gettitle(Title);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Description",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String Description) {
                  getdescription(Description);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Ingredients",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String Ingredients) {
                  getingredients(Ingredients);
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    createData();
                  },
                  child: Text('ADD'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    primary: Colors.green,
                    onPrimary: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    readData();
                  },
                  child: Text('VIEW'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateData();
                  },
                  child: Text('EDIT'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteData();
                  },
                  child: Text('DELETE'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection("myinclassproject1").snapshots(),
            //   builder: (context, snapshot) {

            //       return ListView.builder(
            //         shrinkWrap: true,
            //           itemCount: snapshot.data?.docs.length,
            //           itemBuilder: ((context, index) {
            //             DocumentSnapshot documentSnapshot =
            //                 snapshot.data!.docs[index];
            //             return Row(
            //               children: [
            //                 Expanded(
            //                     child: Text(documentSnapshot["title"])),
            //                 Expanded(
            //                     child: Text(documentSnapshot["description"])),
            //                 Expanded(
            //                     child:
            //                         Text(documentSnapshot["ingredients"])),

            //               ],
            //             );
            //           })
            //       );
            //     },

            // )
          ],
        ),
      ),
    );
  }
}
