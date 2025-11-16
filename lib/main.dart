import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trip_misr/utils/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ShPref.init();

  await Supabase.initialize(
    url: 'https://wctjfsezefulwjxfyntu.supabase.co',
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjdGpmc2V6ZWZ1bHdqeGZ5bnR1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU0NDYwNjMsImV4cCI6MjA3MTAyMjA2M30.6Ur6A2NKHHN9R6Jeyn--xGp99zZ3RYsz9h8Gee-lwng",
  );

runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
