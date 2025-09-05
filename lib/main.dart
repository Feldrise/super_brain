import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/intl_standalone.dart';
import 'package:super_brain/features/navigation/routes.dart';
import 'package:super_brain/firebase_options.dart';
import 'package:super_brain/theme/theme.dart';

Future<void> main() async {
  usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  await findSystemLocale();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final router = ref.watch(routerProvider);
    final materialTheme = MaterialTheme(Theme.of(context).textTheme);

    // return MaterialApp(
    //   title: "Test App",
    //   theme: materialTheme.light(),
    //   darkTheme: materialTheme.dark(),
    //   themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    //   home: Scaffold(body: const Center(child: Text('Hello World'))),
    // );

    return MaterialApp.router(
      title: 'SuperBrain',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: const [Locale('en', ''), Locale('fr', '')],
    );
  }
}
