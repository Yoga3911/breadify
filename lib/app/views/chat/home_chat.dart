import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../view_model/user_prodvider.dart';
import 'room.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  String _connectionStatus = "";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldnt check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        _connectionStatus = "Mobile";
        break;
      case ConnectivityResult.ethernet:
        _connectionStatus = "Ethernet";
        break;
      case ConnectivityResult.bluetooth:
        _connectionStatus = "Bluetooth";
        break;
      case ConnectivityResult.wifi:
        _connectionStatus = "Wifi";
        break;
      case ConnectivityResult.none:
        _connectionStatus = "No internet connection";
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No internet connection",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _debouncer.run(() => initConnectivity());
    final user = Provider.of<UserProvider>(context, listen: false).getUser;
    final CollectionReference getUser =
        FirebaseFirestore.instance.collection("user");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Breadify",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: (_connectionStatus == "Wifi")
                  ? const Text(
                      "Wifi",
                      style: TextStyle(color: Colors.white),
                    )
                  : (_connectionStatus == "Mobile")
                      ? const Text(
                          "Mobile",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          "Airplane",
                          style: TextStyle(color: Colors.white),
                        ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: (_connectionStatus == "Wifi")
                ? const Icon(
                    Icons.wifi_rounded,
                    color: Colors.white,
                  )
                : (_connectionStatus == "Mobile")
                    ? const Icon(
                        Icons.signal_cellular_alt_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.airplanemode_active_rounded,
                        color: Colors.white,
                      ),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: getUser
                .doc(user.id)
                .collection("chats")
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final userData = (snapshot.data!.docs[index].data()
                      as Map<String, dynamic>);
                  return StreamBuilder<DocumentSnapshot>(
                    stream: getUser.doc(userData["user_id"]).snapshots(),
                    builder: (_, snapshot2) {
                      if (!snapshot2.hasData) {
                        return const SizedBox();
                      }
                      final UserModel userModel = UserModel.fromJson(
                          snapshot2.data!.data() as Map<String, dynamic>);
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("chat")
                            .doc(snapshot.data!.docs[index].id)
                            .collection("message")
                            .orderBy("date", descending: false)
                            .snapshots(),
                        builder: (_, snapshot2) {
                          if (!snapshot2.hasData) {
                            return const SizedBox();
                          }
                          if (snapshot2.data!.docs.isEmpty) {
                            return const SizedBox();
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: userModel.imageUrl,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (userData["unread"] == 0)
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.greenAccent,
                                            shape: BoxShape.circle),
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          userData["unread"].toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(height: 5),
                                ((DateTime.now().month ==
                                            (userData["date"] as Timestamp)
                                                .toDate()
                                                .month) &&
                                        DateTime.now().day ==
                                            (userData["date"] as Timestamp)
                                                .toDate()
                                                .day)
                                    ? Text(
                                        DateFormat.Hm().format(
                                          (userData["date"] as Timestamp)
                                              .toDate(),
                                        ),
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    : ((DateTime.now().month ==
                                                (userData["date"] as Timestamp)
                                                    .toDate()
                                                    .month) &&
                                            DateTime.now().day -
                                                    (userData["date"]
                                                            as Timestamp)
                                                        .toDate()
                                                        .day ==
                                                1)
                                        ? const Text(
                                            "Kemarin",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        : Text(
                                            DateFormat("dd/MM/yyyy").format(
                                              (userData["date"] as Timestamp)
                                                  .toDate(),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                              ],
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  userModel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 3),
                                ((userData["isTyping"]))
                                    ? const Text(
                                        "Sedang mengetik ...",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    : (user.email !=
                                            (snapshot2.data!.docs.last.data()
                                                    as Map<String, dynamic>)[
                                                "user"])
                                        ? Flexible(
                                            child: Text(
                                              (snapshot2.data!.docs.last.data()
                                                      as Map<String, dynamic>)[
                                                  "message"],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              ((snapshot2.data!.docs.last.data()
                                                      as Map<String,
                                                          dynamic>)["isRead"])
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    )
                                                  : const Icon(
                                                      Icons.check,
                                                      size: 20,
                                                    ),
                                              const SizedBox(width: 5),
                                              Flexible(
                                                child: Text(
                                                  (snapshot2.data!.docs.last
                                                          .data()
                                                      as Map<String,
                                                          dynamic>)["message"],
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                              ],
                            ),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("user")
                                  .doc(userModel.id)
                                  .collection("chats")
                                  .doc(snapshot.data!.docs[index].id)
                                  .update({
                                "onRoom": true,
                              });
                              FirebaseFirestore.instance
                                  .collection("user")
                                  .doc(user.id)
                                  .collection("chats")
                                  .doc(snapshot.data!.docs[index].id)
                                  .update({
                                "unread": 0,
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RoomChat(
                                    userModel: userModel,
                                    docId: snapshot.data!.docs[index].id,
                                    onRoom: (snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>)["onRoom"],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
