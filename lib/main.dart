import 'package:flutter/material.dart';
import 'dbhelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.dark().copyWith(
          secondary: Colors.tealAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: Dictionary(),
    );
  }
}

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  String searchQuery = '';
  late Future<List<Word>> _wordList;

  @override
  void initState() {
    super.initState();
    _wordList = DatabaseHelper().getData();
  }

  void _search() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(
          "Search Results",
          style: TextStyle(color: Colors.tealAccent),
        ),
           IconButton(
           onPressed: () {
             Navigator.pop(context);
           },
           icon: Icon(Icons.exit_to_app, color: Colors.tealAccent),
              ),
          ],
             ),
        content: FutureBuilder<List<Word>>(
          future: DatabaseHelper().search(searchQuery),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data found', style: TextStyle(color: Colors.white));
            } else {
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Word word = snapshot.data![index];
                    List<String> words = word.amh.split(' ').map((word) => word.replaceAll(RegExp(r'\d\.'), '').replaceAll(RegExp(r'\d'), '')).toList();
                    String firstTwoWords = words.length > 1
                        ? '${words[0]} ${words[1]}'
                        : words.isNotEmpty ? words[0] : '';

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Word: ${word.id}",
                                  style: TextStyle(fontSize: 20, color: Colors.tealAccent),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.exit_to_app, color: Colors.tealAccent),
                                ),
                              ],
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ትርጉም: ${word.amh}",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                   Text(
                                    "Definition: ${word.en}",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Material(
                        elevation: 10.0,
                        color:  Color.fromARGB(255, 26, 25, 25),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                word.id,
                                style: TextStyle(fontSize: 20, color: Colors.tealAccent),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                firstTwoWords,
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ Text("Dictionary"),
         IconButton(onPressed: (){
            showDialog(context: context, builder: (context)=>AlertDialog(
              backgroundColor:  Color.fromARGB(255, 26, 25, 25),
              title: Text("Group members",style: TextStyle(color: Color.fromRGBO(224, 224, 224, 1.0),fontSize: 20),),
              content: Column(mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1.Neserelah Mussa ,ID: 0623",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("2.Silamlak Desalegn ,ID: 0712",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("3.Hilina Woldu ,ID: 0435",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("4.Eden Bazezew ,ID: 0274",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("5.Habtamu Biks ,ID: 0369",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("6.Semels Police ,ID: 0710",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("7.Mahilet Alenew ,ID: 0911",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("8.Leuseged molla ,ID: 0524",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
                Text("9.Tofik Muhdin ,ID: 0780",style: TextStyle(fontSize: 15,color: Color.fromRGBO(224, 224, 224, 1.0)),),
                SizedBox(height: 5,),
              ],
              ),
            ));
        }, icon: Icon(Icons.info,color: Color.fromRGBO(224, 224, 224, 1.0),))
        ]),
        foregroundColor: Color.fromRGBO(224, 224, 224, 1.0),
        backgroundColor:  Color.fromARGB(255, 26, 25, 25),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Search",
                      hintText: "Apple",
                      labelStyle: TextStyle(color: Colors.tealAccent),
                      hintStyle: TextStyle(color: Colors.tealAccent),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: _search,
                  icon: Icon(Icons.search, color: Colors.tealAccent),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Word>>(
                future: _wordList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data found', style: TextStyle(color: Colors.white));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        Word word = snapshot.data![index];
                        List<String> words = word.amh.split(' ').map((word) => word.replaceAll(RegExp(r'\d\.'), '').replaceAll(RegExp(r'\d'), '')).toList();
                        String firstTwoWords = words.length > 1
                            ? '${words[0]} ${words[1]}'
                            : words.isNotEmpty ? words[0] : '';

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:  Color.fromARGB(255, 26, 25, 25),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Word: ${word.id}",
                                      style: TextStyle(fontSize: 20, color: Colors.tealAccent),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.exit_to_app, color: Colors.tealAccent),
                                    ),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                    "ትርጉም: ${word.amh}",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                   Text(
                                    "Definition: ${word.en}",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Material(
                            elevation: 0.0,
                            color:  Color.fromARGB(255, 26, 25, 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    word.id,
                                    style: TextStyle(fontSize: 20, color: Colors.tealAccent),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    firstTwoWords,
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
    );
  }
}
