import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import 'auth_user.dart';
import 'auth_provider.dart';
import 'auth_exceptions.dart';

class FireBaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExceptions();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == "too-many-requests") {
        throw TooManyRequestsAuthException();
      } else if (e.code == "weak-password") {
        throw WeakPasswordAuthException();
      } else if (e.code == "channel-error") {
        throw ChannelErrorAuthException();
      } else {
        throw GenericAuthExceptions();
      }
    } catch (_) {
      throw GenericAuthExceptions();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExceptions();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw UserNotFoundAuthException();
      } else if (e.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else if (e.code == "too-many-requests") {
        throw TooManyRequestsAuthException();
      } else if (e.code == "user-disabled") {
        throw UserDisabledAuthException();
      } else if (e.code == "channel-error") {
        throw ChannelErrorAuthException();
      } else {
        throw GenericAuthExceptions();
      }
    } catch (_) {
      throw GenericAuthExceptions();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthExceptions();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExceptions();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
  @override
  Future<void> sendPasswordReset({required String toEmail}) async { 
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    }on FirebaseAuthException catch (e){
      switch (e.code){
        case "firebase_auth/invalid-email":
        throw InvalidEmailAuthException();
        case "firebase_auth/user-not-found":
        throw UserNotFoundAuthException();
        default:
        throw GenericAuthExceptions();
      }
    }
    catch (_){
      throw GenericAuthExceptions();
    }
  }
}
