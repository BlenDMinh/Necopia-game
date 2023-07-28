import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseService {
  Future<void> reloadUser();
  Future<UserCredential> signIn(
      {required String userEmail, required String userPassword});
  Future<UserCredential> signUp(
      {required String userEmail, required String userPassword});
  Future<void> sendEmailVerification();
  Future<void> resetPassword({required String email});
  Future<void> signOut();
  Future<void> deleteCurrentUser();
}

class FirebaseService implements IFirebaseService {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  static final FirebaseService _instance = FirebaseService._();
  FirebaseService._();
  factory FirebaseService() {
    return _instance;
  }

  String _handleExceptionMessage(String errorCode) {
    switch (errorCode) {
      case "auth/invalid-email-verified":
        return "The provided value for the emailVerified user property is invalid";
      case "auth/invalid-email":
        return "Email is invalid!";
      case "email-already-in-use":
        return "The provided emailis alreadly in use by an existing user.";
      case "auth/invalid-password":
        return "Invalid Password! It must be a string with at least six characters.";
      case "wrong-password":
        return "Wrong Password! Please click to icon \"LOCK\" to show password and try again!";
      case "user-not-found":
        return "Email-account is not found";
      case "too-many-request":
        return "Too Many Request! Please wait a few minutes.";
    }
    return "Error code: $errorCode";
  }

  User? get currentUser {
    return _fbAuth.currentUser;
  }

  bool isLogin() {
    bool result = currentUser != null;
    _fbAuth.authStateChanges().listen((User? user) {
      result = (user == null) ? false : true;
    });
    return result;
  }

  @override
  Future<void> reloadUser() async {
    try {
      _fbAuth.currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      throw Exception(_handleExceptionMessage(e.code));
    }
  }

  @override
  Future<UserCredential> signIn(
      {required String userEmail, required String userPassword}) async {
    try {
      return _fbAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      throw Exception(_handleExceptionMessage(e.code));
    }
  }

  @override
  Future<UserCredential> signUp(
      {required String userEmail, required String userPassword}) async {
    try {
      return _fbAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      throw Exception(_handleExceptionMessage(e.code));
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      return _fbAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      throw Exception(_handleExceptionMessage(e.code));
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      return _fbAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      throw Exception(_handleExceptionMessage(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    return _fbAuth.signOut();
  }

  @override
  Future<void> deleteCurrentUser() async {
    try {
      print(currentUser?.email.toString());
      return _fbAuth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      throw Exception(_handleExceptionMessage(e.code));
    }
  }
}
