import 'package:flutter/material.dart';
import 'package:fregies/provider/application_state.dart';
import 'package:fregies/provider/card_provider.dart';
import 'package:fregies/provider/cart_provider.dart';
import 'package:fregies/provider/product_provider.dart';
import 'package:fregies/provider/remote_config.dart';
import 'package:fregies/provider/stream_provider.dart';
import 'package:fregies/provider/theme_notifier.dart';
import 'package:fregies/provider/user_provider.dart';
import 'package:fregies/screen/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartNotifier()),
      ChangeNotifierProvider(create: (_) => CardNotifier()),
      ChangeNotifierProvider(create: (_) => UserNotifier()),
      ChangeNotifierProvider(create: (_) => ApplicationState()),
      ChangeNotifierProvider(create: (_) => RemoteState()),
      ChangeNotifierProvider(create: (_) => ProductNotifier()),
      StreamProvider(
          create: (_) => getAllProducts(), initialData: myInitialData)

      //StreamProvider(create: (_) => getSessionTime(), initialData: 0, ),
      // StreamProvider.value(value: getProducts(), initialData: []),
    ],
    child: const MyApp(),
  ));
}

// void main() {
//   runApp(
//     const MyApp(),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeClass.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: currentMode,
            theme: ThemeClass.lightTheme,
            darkTheme: ThemeClass.darkTheme,
            home: const MainScreen(),
          );
        });
  }
}
