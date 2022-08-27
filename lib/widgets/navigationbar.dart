import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:soulrelief/pages/explorepage.dart';
import 'package:soulrelief/pages/home.dart';
import 'package:soulrelief/pages/playlists.dart';
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      ExplorePage(),
      PlayList()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon:Icon(Icons.home),
        // Material(
        //   color: Colors.transparent,
        //   child: Tab(
        //     icon: Image.asset(
        //       'assets/images/homeIconActive.png',
        //       height: 20,
        //       width: 20,
        //       // fit: BoxFit.contain,
        //       // color: Color(AppColors.mainColor),
        //     ),
        //   ),
        // ),
        title: ("Home"),
        // inactiveIcon: Material(
        //   color: Colors.transparent,
        //   child: Tab(
        //     icon: Image.asset(
        //       'assets/images/homeIconInactive.png',
        //       height: 20,
        //       width: 20,
        //       // fit: BoxFit.contain,
        //       // color: Color(AppColors.mainColor),
        //     ),
        //   ),
        // ),

        activeColorPrimary: Color(0xffdf99da),
        inactiveColorPrimary: Color(0xFF5F7185),
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.navigation_outlined),
        // Material(
        //   color: Colors.transparent,
        //   child: Tab(
        //     icon: Image.asset(
        //       'assets/images/qoutesIconActive.png',
        //       height: 20,
        //       width: 20,
        //       //  fit: BoxFit.contain,
        //       //   color: Color(AppColors.mainColor),
        //     ),
        //   ),
        // ),
        title: ("Explore"),
        // inactiveIcon: Material(
        //   color: Colors.transparent,
        //   child: Tab(
        //     icon: Image.asset(
        //       'assets/images/qoutesIcon.png',
        //       height: 20,
        //       width: 20,
        //       //  fit: BoxFit.contain,
        //       //   color: Color(AppColors.mainColor),
        //     ),
        //   ),
        // ),
        activeColorPrimary: Color(0xffdf99da),
         inactiveColorPrimary: Color(0xFF5F7185),
      ),
      PersistentBottomNavBarItem(
        icon:Icon(Icons.library_music),
        // Material(
        //   color: Colors.transparent,
        //   child: Tab(
        //     icon: Image.asset(
        //       'assets/images/bellIconActive.png',
        //       height: 20,
        //       width: 20,
        //       //fit: BoxFit.contain,
        //       //   color: Color(AppColors.mainColor),
        //     ),
        //   ),
        // ),
        title: ("Playlist"),
        // inactiveIcon: Material(
        //   color: Colors.transparent,
        //   child: Tab(
        //     icon: Image.asset(
        //       'assets/images/bellIcon.png',
        //       height: 20,
        //       width: 20,
        //       //fit: BoxFit.contain,
        //       //   color: Color(AppColors.mainColor),
        //     ),
        //   ),
        // ),
        activeColorPrimary: Color(0xffdf99da),
        inactiveColorPrimary: Color(0xFF5F7185),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.neumorphic, // Choose the nav bar style with this property.
    );
  }
}
