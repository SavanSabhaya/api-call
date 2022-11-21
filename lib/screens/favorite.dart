import 'package:apicall_rest_api/local_database/model_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../local_database/database_provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<UserDbModel> user = [];
  @override
  void initState() {
    super.initState();
  }

  Future fetchUser() async {
    user.clear();
    return await ResultDatabase.readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourite'),
      ),
      body: FutureBuilder(
        future: fetchUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print('savan');
            return ListView(
              children: List.generate(
                snapshot.data.length,
                (index) {
                  return ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever),
                      onPressed: () async {
                        await ResultDatabase.db
                            .delete(snapshot.data[index].email);

                        setState(() {});
                      },
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                    ),
                    title: Text(
                      snapshot.data[index].name,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data[index].gender),
                        Text(snapshot.data[index].email),
                        Text(snapshot.data[index].phone),
                        Text(snapshot.data[index].cell),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            print("No Data Found...");
            return Text("No Data Found...");
          }
          print("Loading");
          return Text("Loading...");
        },
      ),
    );
  }
}
