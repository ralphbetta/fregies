import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fregies/config/route_config.dart';
import 'package:fregies/models/card_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum ApplicationLoginState {
  loggedOut,
  emailExist,
  register,
  registered,
  emailNotExist,
  loggedIn,
}

enum ApplicationUpdateState {
  username,
  phone,
  profileImage,
  email,
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  String? _tempNumber;
  String? get tempNumber => _tempNumber;

  // final PhoneAuthCredential _phone = "" as PhoneAuthCredential;
  // PhoneAuthCredential get phone => _phone;

  List<User> _activeUser = [];
  UnmodifiableListView<User> get activeUser =>
      UnmodifiableListView(_activeUser);

  Future<void> init() async {
    print("this is from the product provider init");
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        print("this is from the firebase initialization");
        print(user);
        _activeUser = [user];
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailExist;
    notifyListeners();
  }

  verifyEmail(String email,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        print("user exist");

        _loginState = ApplicationLoginState.emailExist;
        notifyListeners();
      } else {
        print("account dose not exist");
        _loginState = ApplicationLoginState.register;
        notifyListeners();
      }
      _email = email;
      notifyListeners();
      return (methods);
    } on FirebaseAuthException catch (e) {
      print("did not work");
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print("worked");
    } on FirebaseAuthException catch (e) {
      print("did not work");
      errorCallback(e);
    }
  }

  cancelRegistration() {
    //_loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String displayName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _loginState = ApplicationLoginState.loggedIn;
      notifyListeners();
      // await credentials.user!.updateProfile(displayName: displayName);
      //await credentials.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void UpdateUsename(String username,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void updateTempNumber(String number) {
    _tempNumber = number;
    notifyListeners();
  }

  void UpdatePhone(PhoneAuthCredential phoneCredential,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePhoneNumber(phoneCredential);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void verifyPhoneNumber(String phoneNumber,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(minutes: 2),
          verificationCompleted: (credential) async {
            await FirebaseAuth.instance.currentUser!
                .updatePhoneNumber(credential);
          },
          verificationFailed: (verificationFailed) async {
            print("code not verified");
            print(verificationFailed.code);
          },
          codeSent: (verificationId, resendingToken) async {
            print("code sent");
            print(verificationId);
            print(resendingToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print(verificationId);
          });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void updateEmail(
    String newEmail,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void uploadFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(
        file,
        SettableMetadata(customMetadata: {
          'uploaded_by': 'admin',
          'description': 'this section is not important'
        }));
    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('this is the image download link');
    print(urlDownload);

    await FirebaseAuth.instance.currentUser!.updatePhotoURL(urlDownload);
    notifyListeners();
  }

  void fetchAllStorageFiles() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().child('files').list();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    //this is the files we'll be making use of
    print("this is the result list");
    print(files);
    notifyListeners();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
