import 'package:bill/components/drawer.dart';
import 'package:bill/src/auth/auth_util.dart';
import 'package:bill/src/auth/firebase_user_provider.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/bill/internationalization.dart';
import 'package:bill/src/views/screens/facture/facture_screen.dart';
import 'package:bill/src/views/screens/home/home_screen.dart';
import 'package:bill/src/views/screens/login/login_screen.dart';
import 'package:bill/src/views/screens/profil/profil_screen.dart';
import 'package:bill/src/views/screens/scan/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await BillTheme.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = BillTheme.themeMode;

  late Stream<BillFirebaseUser> userStream;
  BillFirebaseUser? initialUser;
  bool displaySplashImage = true;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    userStream = billFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    // jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        BillTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bill',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('fr'),
      ],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: initialUser == null || displaySplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.transparent,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            )
          : currentUser!.loggedIn
              ? const NavBarPage()
              : const LoginScreen(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': const HomeScreen(),
      'factures': const FactureScreen(),
      'Scan': const ScanScreen(),
      'Profil': const ProfilScreen(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      key: scaffoldKey,
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: BillTheme.of(context).secondaryBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: BillTheme.of(context).primaryColor,
          ),
          iconSize: 30,
        ),
      ),
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: BillTheme.of(context).secondaryBackground,
        selectedItemColor: BillTheme.of(context).primaryColor,
        unselectedItemColor: BillTheme.of(context).primaryText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 24,
            ),
            label: 'Acceuil',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_copy,
              size: 24,
            ),
            label: 'Factures',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_enhance,
              size: 24,
            ),
            label: 'Scan',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 24,
            ),
            label: 'Mon compte',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
