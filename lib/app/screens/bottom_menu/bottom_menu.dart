import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ykapay/app/screens/home/home_screen.dart';
import 'package:ykapay/utils/shader_mask_custom.dart';
import '../../controllers/home_controller.dart';

// ignore: must_be_immutable
class BottomMenu extends GetView<HomeController> {
  late DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WillPopScope(child: BottomNavBar(), onWillPop: onWillPop));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    // var currentBackPressTime;
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tap back again to leave');
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 2;
  List<Widget> listWidget = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return
        // AdvancedDrawer(
        //   backdropColor: Colors.grey.shade900,
        //   controller: controller.advancedDrawerController,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: const Duration(milliseconds: 300),
        //   animateChildDecoration: true,
        //   rtlOpening: false,
        //   disabledGestures: false,
        //   childDecoration: BoxDecoration(
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.shade900,
        //         blurRadius: 20.0,
        //         spreadRadius: 5.0,
        //         offset: const Offset(-20.0, 0.0),
        //       ),
        //     ],
        //     borderRadius: BorderRadius.circular(30),
        //   ),
        // drawer: SafeArea(
        //   child: Container(
        //     padding: const EdgeInsets.only(top: 20),
        //     child: ListTileTheme(
        //       textColor: Colors.white,
        //       iconColor: Colors.white,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //               width: 80.0,
        //               height: 80.0,
        //               margin: const EdgeInsets.only(
        //                 left: 20,
        //                 top: 24.0,
        //               ),
        //               clipBehavior: Clip.antiAlias,
        //               decoration: BoxDecoration(
        //                 color: Colors.grey.shade800,
        //                 shape: BoxShape.circle,
        //               ),
        //               child: Image.network(
        //                   'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png')),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           // Padding(
        //           //   padding: const EdgeInsets.only(left: 30.0),
        //           //   child: Obx(
        //           //     () => controller.isLoading.value
        //           //         ? const CircularProgressIndicator(
        //           //             color: Colors.red,
        //           //           )
        //           //         : Text(
        //           //             "${controller.user.value.fullName}",
        //           //             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        //           //           ),
        //           //   ),
        //           // ),
        //           const Spacer(),
        //           Divider(
        //             color: Colors.grey.shade800,
        //           ),
        //           ListTile(
        //             onTap: () {
        //               // controller.handleUser();
        //               Get.toNamed('home');
        //             },
        //             leading: const Icon(Iconsax.home),
        //             title: const Text('Dashboard'),
        //           ),
        //           ListTile(
        //             onTap: () {},
        //             leading: const Icon(Iconsax.chart_2),
        //             title: const Text('Analytics'),
        //           ),
        //           ListTile(
        //             onTap: () {},
        //             leading: const Icon(Iconsax.profile_2user),
        //             title: const Text('Contacts'),
        //           ),
        //           ListTile(
        //             onTap: () {
        //               // controller.box.remove('token');
        //               // Get.offAllNamed('login');
        //             },
        //             leading: const Icon(Iconsax.logout),
        //             title: const Text('Logout'),
        //           ),
        //           const SizedBox(
        //             height: 50,
        //           ),
        //           Divider(color: Colors.grey.shade800),
        //           ListTile(
        //             onTap: () {
        //               Get.toNamed('setting');
        //             },
        //             leading: const Icon(Iconsax.setting_2),
        //             title: const Text('Settings'),
        //           ),
        //           ListTile(
        //             onTap: () {},
        //             leading: const Icon(Iconsax.support),
        //             title: const Text('Support'),
        //           ),
        //           const Spacer(),
        //           Padding(
        //             padding: const EdgeInsets.all(20.0),
        //             child: Text(
        //               'Version 1.0.0',
        //               style: TextStyle(color: Colors.grey.shade500),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // child:
        Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: <Widget>[
          ShaderMaskCustom(
            text: _page == 0 ? null : 'Khách hàng',
            icon: Icons.folder_shared_sharp,
            size: 30,
          ),
          ShaderMaskCustom(
            text: _page == 1 ? null : 'Cộng tác viên',
            icon: Icons.person_add,
            size: 30,
          ),
          ShaderMaskCustom(
            text: _page == 2 ? null : 'Trang chủ',
            icon: Icons.home,
            size: 50,
          ),
          ShaderMaskCustom(
            text: _page == 3 ? null : 'Cộng đồng',
            icon: Icons.share,
            size: 30,
          ),
          ShaderMaskCustom(
            text: _page == 4 ? null : 'Thiết lập',
            icon: Icons.settings,
            size: 30,
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: Get.size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: Get.size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: Get.size.width * 0.3,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
          ),
          listWidget[_page],
        ],
      ),
      // ),
    );
  }
}
