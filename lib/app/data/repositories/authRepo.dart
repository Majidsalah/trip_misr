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
          '555302915003-efhkoqsud7pgfnu4pd9lketk83eskrtt.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: webClientId,
        scopes: [
          'email',
          'profile',
        ],
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
      final userAvatar = supaBaseUser.identities.first.identityData.avatarUrl;

      await ShPref.saveUserAvatar(userAvatar);

      // -------------------------------
      //     CHECK IF PROFILE EXISTS
      // -------------------------------
      final existingProfile = await supabase
          .from('profiles')
          .select()
          .eq('id', supaBaseUser.id)
          .maybeSingle();

      if (existingProfile == null) {
        // INSERT ONLY IF NOT EXISTS
        await supabase.from('profiles').insert({
          'id': supaBaseUser.id,
          'full_name': supaBaseUser.identities.first.identityData.name,
          'role': 'customer',
          'avatar_url': supaBaseUser.identities.first.identityData.avatarUrl
        });
      }

      return right(supaBaseUser);
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }

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
