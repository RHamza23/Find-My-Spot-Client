import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/colors.dart';
import '../../view/Dashboard/dashboard.dart';


Widget CustomNavigationBar1({required IconData icon , required Function onClick2ndicon}) {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  return BottomAppBar(
      shape: CircularNotchedRectangleWithCorners(),
      notchMargin: 0.05,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: kBottomNavigationBarHeight * 0.98,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: BottomAppBar(
            color: bottomNavigationBarColor.withOpacity(0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {Get.to(Dashboard());},
                    icon: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {onClick2ndicon();},
                    icon: Icon(
                        icon,
                      size: 30,
                      color: Colors.white
                    )),
              ],
            ),
          ),
        ),
      ));
}

class CircularNotchedRectangleWithCorners implements NotchedShape {
  const CircularNotchedRectangleWithCorners();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final Path path = Path();
    path.addRRect(
      RRect.fromRectAndCorners(
        host,
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    );
    if (guest != null && !guest.isEmpty) {
      path.addRRect(
        RRect.fromRectAndCorners(
          guest,
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      );
    }
    return path;
  }
}
