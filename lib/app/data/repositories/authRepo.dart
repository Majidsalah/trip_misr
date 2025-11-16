import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trip_misr/app/data/models/failureModel.dart';
import 'package:trip_misr/app/data/models/user_model.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:trip_misr/utils/shared_pref.dart';
import 'package:trip_misr/utils/user_type.dart';



class Authrepo {
   final supabase = Supabase.instance.client;
  Future<Either<Failure, SupabaseUser>> googleLogIn() async {
    try {
      const webClientId =
          '555302915003-p57k3qmdg1jmc09cusmiij02k8qfqfuo.apps.googleusercontent.com';
      const iosClientId = '236040982536‑camrlfiqqovonjt45qc4djkgda7238fd';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      final user = response.user;
      if (user == null) {
        return left(Failure('No user found after login.'));
      }

      final supaBaseUser = SupabaseUser.fromJson(user.toJson());
      final userAvatar = supaBaseUser.identities.first.identityData.name;
      await ShPref.saveUserAvatar(userAvatar);
      // await supabase.from('profiles').insert({
      //   'id': supaBaseUser.id,
      //   'full_name': supaBaseUser.identities.first.identityData.name,
      //   'role': 'customer',
      //   'avatar_url': supaBaseUser.identities.first.identityData.avatarUrl
      // });

      return right(supaBaseUser);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  // final supabase = Supabase.instance.client;

  // Future<Either<Failure, User>> googleLogIn() async {
  //   try {
  //     const webClientId =
  //         '555302915003-efhkoqsud7pgfnu4pd9lketk83eskrtt.apps.googleusercontent.com';
  //     const iosClientId = '236040982536‑camrlfiqqovonjt45qc4djkgda7238fd';

  //     // احصل على Singleton instance
  //     final GoogleSignIn signIn = GoogleSignIn.instance;
  //     await GoogleSignIn.instance.signOut();
  //     await GoogleSignIn.instance.disconnect();

  //     // استدعاء initialize قبل أي عملية تسجيل دخول
  //     await signIn.initialize(
  //       clientId: iosClientId,
  //       serverClientId: webClientId,
  //     );

  //     // محاولة تسجيل الدخول – باستخدام authenticate أو fallback حسب المنصة
  //     if (signIn.supportsAuthenticate()) {
  //       // بعض المنصات قد تتطلب authenticate()
  //       final GoogleSignInAccount? account = await signIn.authenticate();
  //       if (account == null) {
  //         return left(Failure('User cancelled Google Sign‑In.'));
  //       }

  //       final auth = await account.authentication;
  //       final idToken = auth.idToken;
  //       final accessToken = auth.idToken;

  //       if (idToken == null) {
  //         return left(Failure('No ID token returned.'));
  //       }

  //       final response = await Supabase.instance.client.auth.signInWithIdToken(
  //         provider: OAuthProvider.google,
  //         idToken: idToken,
  //         accessToken: accessToken,
  //       );

  //       final user = response.user;
  //       if (user == null) {
  //         return left(Failure('Supabase returned null user.'));
  //       }

  //       return right(user);
  //     } else {
  //       // في حالة لا تدعم authenticate، استخدم طريقة بديلة (مثلاً واجهة زر Web)
  //       final GoogleSignInAccount? account = await signIn.authenticate();
  //       if (account == null) {
  //         return left(Failure('User cancelled Google Sign‑In.'));
  //       }

  //       final auth = await account.authentication;
  //       final idToken = auth.idToken;
  //       final accessToken = auth.idToken;

  //       if (idToken == null) {
  //         return left(Failure('No ID token returned.'));
  //       }

  //       final response = await Supabase.instance.client.auth.signInWithIdToken(
  //         provider: OAuthProvider.google,
  //         idToken: idToken,
  //         accessToken: accessToken,
  //       );

  //       final user = response.user;
  //       if (user == null) {
  //         return left(Failure('Supabase returned null user.'));
  //       }

  //       return right(user);
  //     }
  //   } catch (e, st) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  Future<Either<Failure, SupabaseUser>> organizerLogIn(
      String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = response.user;
      if (user == null) {
        return left(Failure("Login failed. No user returned."));
      }

      final supaBaseUser = SupabaseUser.fromJson(user.toJson());

      final profile = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (profile == null) {
        try {
          await supabase.from('profiles').insert({
            'id': response.user!.id,
            'full_name': supaBaseUser.email.trim().toString(),
            'role': 'organizer',
            'avatar_url': supaBaseUser.identities.first.identityData.avatarUrl
          }).select();
        } catch (e) {
          if (e is PostgrestException) {
            log('Supabase Error: ${e.message}');
            return left(Failure(e.message));
          } else {
            log('Unexpected Error: $e');
            return left(Failure(e.toString()));
          }
        }
        return left(Failure("Profile not found for this user."));
      }
      return right(supaBaseUser);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> userLogOut(
      UserType currentUserType, BuildContext context) async {
    switch (currentUserType) {
      case UserType.normal:
      // await _googleSignIn.signOut();
      case UserType.oragnizer:
        await supabase.auth.signOut();
      case UserType.guest:
        await GoRouter.of(context).push(AppRouter.kWelcome);
        break;
      default:
    }
    await ShPref.clearUserType();
  }

  bool userChecker() {
    final session = Supabase.instance.client.auth.currentSession;
    return session != null;
  }
}
