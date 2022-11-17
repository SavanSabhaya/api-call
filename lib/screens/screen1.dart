import 'dart:async';
import 'package:apicall_rest_api/local_database/database_provider.dart';
import 'package:apicall_rest_api/model/user.dart';
import 'package:apicall_rest_api/screens/screen2.dart';
import 'package:apicall_rest_api/services/user_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: ClipOval(child: Image.network(users.picture.thumbnail)),
              ),
              title: Text(users.fullname),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(users.nat),
                  Text(users.gender),
                  Text(users.cell),
                  Text(users.phone),
                  Text(users.email),
                  Text(users.location.city),
                  Text(users.location.state),
                  Text(users.location.country),
                  Text(users.location.postcode),
                  Text(users.location.street.number.toString()),
                  Text(users.location.street.name.toString()),
                  Text(users.location.timezone.description),
                  Text(users.location.timezone.offset),
                  Text(users.location.coordinates.latitude),
                  Text(users.location.coordinates.longitude)
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Homescreenpage()));
          ResultDatabase.db.getUsers();
          // String username = usernames.text;
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
