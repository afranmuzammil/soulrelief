
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:soulrelief/pages/playlists.dart';
import 'package:soulrelief/pages/songpage.dart';
import 'package:we_slide/we_slide.dart';
import 'package:get/get.dart';
import '../contollers/currentSongContoller.dart';
import '../contollers/sliderController.dart';
import '../widgets/navigationbar.dart';
import 'explorepage.dart';
import 'flotingAudio.dart';
import 'home.dart';

class SlideSongPage extends StatefulWidget {
  const SlideSongPage({Key? key}) : super(key: key);

  @override
  State<SlideSongPage> createState() => _SlideSongPageState();
}

class _SlideSongPageState extends State<SlideSongPage> {
  CurrnetSongController currnetSongController = Get.put(CurrnetSongController());
  SliderControl sliderControl = Get.put(SliderControl());
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
  int IndexValue=0;
  
  @override
  Widget build(BuildContext context) {
    final WeSlideController _controller = WeSlideController();
    final double _panelMinSize = 127.0;
    final double _panelMaxSize = MediaQuery
        .of(context)
        .size
        .height;

    PersistentTabController tabBarController;

    tabBarController = PersistentTabController(initialIndex: 0);
    
    

    return Scaffold(
      body: WeSlide(
        controller: sliderControl.sliderController,
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        overlayOpacity: 0.9,
        overlay: true,
        isDismissible: true,
        body: _buildScreens()[IndexValue],
        panelHeader: MiniPlayer(onTap: sliderControl.sliderController.show,songId: currnetSongController.currentSongID ,),
        panel: SongPage(onTap: sliderControl.sliderController.hide,songID: "1rMHGBUIIxHxFX43Wef7Xhx97RlU_NHQ9",),
        footer: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem( icon:Icon(Icons.navigation_outlined), label: 'Explore'),
            BottomNavigationBarItem(
                icon:Icon(Icons.library_music), label: 'Playlist'),
          ],
          currentIndex : IndexValue,
          // unselectedFontSize: 0.0,
          // selectedFontSize: 0.0,
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:  Color(0xffdf99da),
          unselectedItemColor: Color(0xFF5F7185),
          onTap: (index) {
            setState(() {
              IndexValue = index;
            });
          },
        ),
        // PersistentTabView(
        //   context,
        //   controller: tabBarController,
        //   screens: _buildScreens(),
        //   items: _navBarsItems(),
        //   confineInSafeArea: true,
        //   backgroundColor: Colors.white,
        //   // Default is Colors.white.
        //   handleAndroidBackButtonPress: true,
        //   // Default is true.
        //   resizeToAvoidBottomInset: true,
        //   // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        //   stateManagement: true,
        //   // Default is true.
        //   hideNavigationBarWhenKeyboardShows: true,
        //   // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        //   decoration: NavBarDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     colorBehindNavBar: Colors.white,
        //   ),
        //   popAllScreensOnTapOfSelectedTab: true,
        //   popActionScreens: PopActionScreensType.all,
        //   itemAnimationProperties: ItemAnimationProperties(
        //     // Navigation Bar's items animation properties.
        //     duration: Duration(milliseconds: 200),
        //     curve: Curves.ease,
        //   ),
        //   screenTransitionAnimation: ScreenTransitionAnimation(
        //     // Screen transition animation on change of selected tab.
        //     animateTabTransition: true,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 200),
        //   ),
        //   navBarStyle: NavBarStyle.neumorphic, // Choose the nav bar style with this property.
        // ),
        blur: true,
        //blurSigma: 5.0,
        // appBar: AppBar(
        //   backgroundColor: Colors.red,
        //   title: Text("Title"),
        // ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: IndexValue==1?Icon(Icons.navigation_outlined,color:Color(0xffdf99da)): Icon(Icons.navigation_outlined,color:Color(0xFF5F7185),), label: 'Explore'),
      //     BottomNavigationBarItem(
      //         icon:Icon(Icons.library_music), label: 'Playlist'),
      //   ],
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Color(0xffdf99da),
      //   unselectedItemColor:  Color(0xFF5F7185),
      //   onTap: (index) {
      //     setState(() {
      //       IndexValue = index;
      //     });
      //   },
      // ),
    );
  }
}