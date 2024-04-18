import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../excption/auth_exception.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> resgiste(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains("password")) {
          throw AuthException(
              message: "E-mail ja utilizado, por favor escolha outro E-mal");
        } else {
          throw AuthException(message: "Voce se cadastrou pelo google");
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuario');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? "erro ao realizar login");
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? "erro ao realizar login");
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginTypes.contains("password")) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains("google")) {
        throw AuthException(message: "Voce se cadastrou pelo google");
      } else {
        throw AuthException(message: "E-mail nao cadastrado");
      }
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? "error ");
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains("password")) {
          throw AuthException(message: "ultilizar a senha para fazer o login");
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredencial =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredencial.user;
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw AuthException(message: '''
Login invalido, voce se registrou no todoList com os seguintes provedores: ${loginMethods?.join(",")}
''');
      } else {
        throw AuthException(message: "erro ao realizar login");
      }
    }
  }

  @override
  Future<void> googleLogout() async {
    try {
      await GoogleSignIn().signIn();
      _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(message: "Error inesperado");
    }
  }
}
