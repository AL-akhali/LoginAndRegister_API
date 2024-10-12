import 'package:bloc/bloc.dart';
import 'package:ecommerce/modules/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/modules/auth_screens/login.dart';
import 'package:ecommerce/modules/auth_screens/register.dart';
import 'package:ecommerce/modules/home_screen.dart';
import 'package:ecommerce/shared/bloc_observer/bloc_observer.dart';
import 'package:ecommerce/shared/component/constants/constants.dart';
import 'package:ecommerce/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInit();
  token = CacheNetwork.GetCacheDate(key: "token");
  print(token);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
              token != null && token != "" ? const HomeScreen() : LoginScreen(),
        ),
      ),
    );
  }
}
