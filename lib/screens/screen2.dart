// import 'dart:async';

// import 'package:apicall_rest_api/local_database/database_provider.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../local_database/model_class.dart';
// import '../model/user.dart';
// import '../services/user_api.dart';

// // class Homepage extends StatefulWidget {
// //   const Homepage({super.key, required this.data});
// //   final String data;
// //   @override
// //   State<Homepage> createState() => _HomepageState();
// // }

// // class _HomepageState extends State<Homepage> {
// //   late SharedPreferences sp;
// //   List<User> user = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     getdata();
// //   }

// //   void getdata() async {
// //     sp = await SharedPreferences.getInstance();
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Save Data')),
// //       body: Text('$user'),
// //     );
// //   }
// // }

// class Homescreenpage extends StatefulWidget {
//   @override
//   State<Homescreenpage> createState() => _HomescreenpageState();
// }

// class _HomescreenpageState extends State<Homescreenpage> {
//   List<UserDbModel> user = [];
//   late SharedPreferences sp;

//   late StreamSubscription subscription;
//   var isdeviceConnected = false;
//   bool isAleartset = false;
//   bool isloding = false;

//   @override
//   void initState() {
//     super.initState();
//     checkConnectivity().then((value) async {
//       if (value) {
//         fetchUser();
//       }
//       getdata();
//     });
//   }

//   void getdata() async {
//     sp = await SharedPreferences.getInstance();
//   }

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 207, 214, 207),
//       appBar: AppBar(
//         title: const Text('REST API call'),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//           itemCount: user.length,
//           itemBuilder: (context, index) {
//             final users = user[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.deepOrange,
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(users.name),
//                   Text(users.gender),
//                   Text(users.cell),
//                   Text(users.phone),
//                   Text(users.email),
//                 ],
//               ),
//             );
//           }),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Navigator.push(
//       //         context,
//       //         MaterialPageRoute(
//       //             builder: (context) => Homepage(data: user.toString())));
//       //     ResultDatabase.db.getUsers();
//       //     // String username = usernames.text;
//       //   },
//       // ),
//     );
//   }

//   showDialogbox() => showCupertinoDialog<String>(
//       context: context,
//       builder: ((BuildContext context) => CupertinoAlertDialog(
//             title: Text('No internet'),
//             content: Text('please cheack your connectivity'),
//             actions: [
//               TextButton(
//                   onPressed: (() async {
//                     Navigator.pop(context, 'cancle');
//                     setState(() {
//                       isAleartset == false;
//                     });
//                     isdeviceConnected =
//                         await InternetConnectionChecker().hasConnection;
//                     if (!isdeviceConnected) {
//                       showDialogbox();
//                       setState(() {
//                         isAleartset == true;
//                       });
//                     }
//                   }),
//                   child: Text('Ok'))
//             ],
//           )));

//   void fetchUser() async {
//     final response = await ResultDatabase.readAllNotes();
//     setState(() {
//       user = response;
//     });
//   }

//   Future<bool> checkConnectivity() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       showDialogbox();
//       return false;
//     } else {
//       return true;
//     }
//   }
// }
