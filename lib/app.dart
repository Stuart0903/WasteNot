
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wastenot/bindings/general_bindings.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/theme/theme.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: WNAppTheme.lightTheme,
      darkTheme: WNAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      ///show Loader or circular progress indicator
      home: const Scaffold(backgroundColor: WNColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white),),)
    );
  }
}
