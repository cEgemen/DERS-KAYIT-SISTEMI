import 'package:flutter/material.dart';
import 'core/inits/postgreSql_init/postgreSql_init.dart';
import 'core/constants/app_constant_dimensions/app_dimensions.dart';
import 'pages/main_panel/view/main_panel_page.dart';

void main() {
  PostgreSql.sqlInit();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.green.shade200,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppConstantsDimensions.appRadiusMedium))),
          ),
          appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Colors.transparent, iconTheme: IconThemeData(color: Colors.black)),
          cardTheme: const CardTheme(
            elevation: 0,
          ),
          listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
            color: Colors.black.withOpacity(.4),
          )))),
      home: MainPanelPage(),
    );
  }
}
