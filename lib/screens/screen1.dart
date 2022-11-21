import 'dart:async';
import 'package:apicall_rest_api/model/user.dart';
import 'package:apicall_rest_api/screens/favorite.dart';
import 'package:apicall_rest_api/services/user_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:favorite_button/favorite_button.dart';

import '../local_database/database_provider.dart';
import '../local_database/model_class.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> user = [];
  late SharedPreferences sp;

  late StreamSubscription subscription;
  var isdeviceConnected = false;
  bool isAleartset = false;
  bool isloding = false;
  bool isFavoritee = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity().then((value) async {
      if (value) {
        fetchUser();
      }
      getdata();
    });
  }

  void getdata() async {
    sp = await SharedPreferences.getInstance();
  }

  // @override
  // void dispose() {
  //   subscription.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // void savedata(int index) {
    //   User(
    //       picture: user[index].picture,
    //       location: user[index].location,
    //       dob: user[index].dob,
    //       name: user[index].name,
    //       gender: user[index].gender,
    //       email: user[index].email,
    //       phone: user[index].phone,
    //       cell: user[index].cell,
    //       nat: user[index].nat);
    // }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 214, 207),
      appBar: AppBar(
        title: const Text('REST API call'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            final users = user[index];
            return ListTile(
              trailing: IconButton(
                icon: Icon(Icons.favorite_outline),
                onPressed: () {
                  ResultDatabase.db.create(UserDbModel(
                    name: user[index].fullname,
                    gender: user[index].gender,
                    email: user[index].email,
                    phone: user[index].phone,
                    cell: user[index].cell,
                  ));
                },
              ),
              // trailing: FavoriteButton(
              //     valueChanged: () {
              //       ResultDatabase.db.create(UserDbModel(
              //         name: user[index].fullname,
              //         gender: user[index].gender,
              //         email: user[index].email,
              //         phone: user[index].phone,
              //         cell: user[index].cell,
              //       ));
              //     },
              // iconColor: Colors.green,
              // iconSize: 45,
              // iconDisabledColor: Colors.grey,
              // isFavorite: isFavoritee),
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: ClipOval(child: Image.network(users.picture.thumbnail)),
              ),
              title: Text(users.fullname),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('country:  ${users.nat}'),
                  Text('gender: ${users.gender}'),
                  Text('cell no: ${users.cell}'),
                  Text('phone no:${users.phone}'),
                  Text('email:${users.email}'),
                  Text('city: ${users.location.city}'),
                  Text('state:${users.location.state}'),
                  Text('country:${users.location.country}'),
                  Text('postcode:${users.location.postcode}'),
                  Text('street no:${users.location.street.number.toString()}'),
                  Text('street name: ${users.location.street.name.toString()}'),
                  Text('timezone: ${users.location.timezone.description}'),
                  Text('+GMT: ${users.location.timezone.offset}'),
                  Text('Location :${users.location.coordinates.latitude}'),
                  Text('         :${users.location.coordinates.longitude}')
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Favourite()));
        },
      ),
    );
  }

  showDialogbox() => showCupertinoDialog<String>(
      context: context,
      builder: ((BuildContext context) => CupertinoAlertDialog(
            title: Text('No internet'),
            content: Text('please cheack your connectivity'),
            actions: [
              TextButton(
                  onPressed: (() async {
                    Navigator.pop(context, 'cancle');
                    setState(() {
                      isAleartset == false;
                    });
                    isdeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isdeviceConnected) {
                      showDialogbox();
                      setState(() {
                        isAleartset == true;
                      });
                    }
                  }),
                  child: Text('Ok'))
            ],
          )));

  void fetchUser() async {
    EasyLoading.show();
    final response = await UseraApi.fetchUsers();
    setState(() {
      user = response;
    });
    EasyLoading.dismiss();
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialogbox();
      return false;
    } else {
      return true;
    }
  }
}
