import 'package:bill/Views/Facture/facturescreen.dart';
import 'package:bill/Views/profile/profile_screen.dart';
import 'package:bill/Views/scan/scan_screen.dart';
import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/services/database.dart';
import 'package:flutter/material.dart';
import 'package:bill/models/user_app.dart';
import 'commons/custom_tab_bar.dart';
import 'home/home_page.dart';

class NavScreen extends StatefulWidget {
  int index;
  UserApp user;

  NavScreen({Key? key, required this.user, required this.index})
      : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    Map cars = DataBase().getMapCars(widget.user);

    final List<Widget> _screens = [
      HomeScreen(
        user: widget.user,
      ),
      FactureScreen(
        user: widget.user,
      ),
      PhotoScreen(
        user: widget.user,
        cars: cars,
      ),
      ProfilScreen(
        user: widget.user,
      ),
    ];

    List<IconData> _icons = const [
      Icons.home,
      Icons.file_copy,
      Icons.camera,
      Icons.person,
    ];

    int _selectedIndex = widget.index;

    return DefaultTabController(
      initialIndex: widget.index,
      length: _icons.length,
      child: FutureBuilder(
        future: DataBase().getUser(widget.user.id),
        builder: (BuildContext context, AsyncSnapshot<UserApp> user) {
          debugPrint("build tab controller");
          if (user.hasData) {
            UserApp _userApp = UserApp(
              id: user.data!.id,
              nom: user.data!.nom,
              email: user.data!.email,
              phone: user.data!.phone,
            );
            return Scaffold(
              body: TabBarView(
                children: _screens,
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CustomTabBar(
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    user: _userApp,
                    onTap: (index) => setState(() => {
                          _selectedIndex = index,
                          debugPrint(index.toString())
                        })),
              ),
            );
          } else {
            return const Loading(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}
