import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase/ShowDataPage.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete((){
      print('Connected to firebase.');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Constants.blueLight,
        leading: Padding(
          padding: EdgeInsets.only(top: 6.0, left: 6.0, bottom: 6.0),
          child: FlatButton(
            color: Colors.white.withOpacity(0.3),
            child: Icon(Icons.keyboard_backspace, color: Colors.white),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title:  Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
            )
        ),
      ),
      backgroundColor: Constants.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('path').where('document', isEqualTo: id).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(child:Text('Error: ${snapshot.error}'));
          }
          else{
            switch(snapshot.connectionState){
              case(ConnectionState.waiting):{
                return Center(child: CircularProgressIndicator(),);
              }
              default: return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: InkWell(
                          child:Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [BoxShadow(
                                color: Colors.white,
                              )]
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.icon,
                                size: 100.0,
                                color: Constants.textDark,),
                              SizedBox(width: 10.0,),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.textDark
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                            ],
                          ),
                        ),
                          onTap: (){},
                    ),
                      ),
                    );
                  });
            }
          }
        },
      ),
    );
  }
}
