import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum Attending { unknown, yes, know }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
      } else {}
      notifyListeners();
    });
  }

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  //List<GuestBookMessage> _guestBookMessages = [];
  ////////////////////////////////////////////////////
  final int _attendees = 0;
  int get attendees => _attendees;
  final Attending _attending = Attending.unknown;
  Attending get attending => _attending;
/////////////////////////////////////////////////////////

  void readGuestBook() {
    //this has not been setup
    var pen = FirebaseFirestore.instance
        .collection("guestbook")
        .orderBy("timestamp", descending: true)
        .limit(100);
  }

  void addToGuestBook(
      void Function(FirebaseAuthException e) errorCallback) async {
    //this is not in use
    await FirebaseFirestore.instance.collection("guestbook").add({
      "text": "",
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "name": FirebaseAuth.instance.currentUser!.displayName,
      "userID": FirebaseAuth.instance.currentUser!.uid,
    });
  }

  void attendingAction() {
    final userDoc = FirebaseFirestore.instance
        .collection("attendees")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set({"attending": true});
    } else {
      userDoc.set({"attending": false});
    }
    notifyListeners();
  }

  void countAllAttendee() async {
    final docs = await FirebaseFirestore.instance
        .collection("attendees")
        .where("attending", isEqualTo: true);
    Future<int> count = docs.snapshots().length;

    notifyListeners();
  }
}
