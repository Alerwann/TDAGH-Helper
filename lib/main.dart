import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/ProfilsPages/profil.dart';
import 'package:flutter_application_1/pages/Bingo/homepage.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/providers/bingo_provider.dart';
import 'package:flutter_application_1/providers/heures_profil_provider.dart';
import 'package:flutter_application_1/providers/profil_provider.dart';
import 'package:flutter_application_1/providers/sound_provider.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BingoProvider()),
        ChangeNotifierProvider(create: (context) => HeureProfilProvider()),
        ChangeNotifierProvider(create: (context) => ProfilProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final soundProvider = SoundProvider();
            soundProvider .initialize(); // Lance l'initialisation dès la création
            return soundProvider;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyBingoProvider();
}

class _MyBingoProvider extends State<MyApp> {
  int _currentindex = 0;

  final ScrollController _scrollController = ScrollController();

  setCurrentIndex(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(181, 212, 149, 216),
          primary: Color.fromARGB(195, 0, 0, 0),
          secondary: const Color.fromARGB(255, 6, 110, 75),
          primaryContainer: const Color.fromARGB(155, 193, 187, 187),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,

            iconSize: 40,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            side: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
      ),
      home: Scaffold(
        
        body: 
        
        [HomeGlobalPage(), HomeBingoPage(), ProfilPage()][_currentindex],
        bottomNavigationBar: DotCurvedBottomNav(
          scrollController: _scrollController,
          hideOnScroll: true,
          indicatorColor: Colors.blue,
          backgroundColor: const Color.fromARGB(155, 193, 187, 187),
          animationDuration: const Duration(milliseconds: 200),
          animationCurve: Curves.ease,
          selectedIndex: _currentindex,
          indicatorSize: 5,
          borderRadius: 25,
          height: 70,
          onTap: (index) {
            setState(() => _currentindex = index);
          },
          items: [
            Icon(
              Icons.home,
              color: _currentindex == 0
                  ? const Color.fromARGB(255, 88, 151, 142)
                  : const Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
            Icon(
              HugeIconsSolid.gameController02,
              color: _currentindex == 1
                  ? const Color.fromARGB(255, 88, 151, 142)
                  : const Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
            Icon(
              HugeIconsSolid.settings01,
              color: _currentindex == 2
                  ? const Color.fromARGB(255, 88, 151, 142)
                  : const Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
