import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int activeIconIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({super.key, this.activeIconIndex = 0, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF557F9F),
      child: BottomNavigationBar(
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        backgroundColor: Color(0xFF557F9F),
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon( activeIconIndex == 0 ? MdiIcons.home : MdiIcons.homeOutline),
            label: "Home",
            backgroundColor: Color(0xFF557F9F),
          ),
          BottomNavigationBarItem(
            icon: Icon(activeIconIndex == 1 ? MdiIcons.bookmark : MdiIcons.bookmarkOutline),
            label: "Saved",
            backgroundColor: Color(0xFF557F9F),
          ),
          BottomNavigationBarItem(
            icon: Icon(activeIconIndex == 2 ? MdiIcons.plusCircle: MdiIcons.plusCircleOutline),
            label: "Create",
            backgroundColor: Color(0xFF557F9F),
          ),
          BottomNavigationBarItem(
            icon: Icon(activeIconIndex == 3 ? MdiIcons.calendar : MdiIcons.calendarBlankOutline),
            label: "Plan",
            backgroundColor: Color(0xFF557F9F),
          ),
          BottomNavigationBarItem(
            icon: Icon(activeIconIndex == 4
                ? MdiIcons.basket
                : MdiIcons.basketOutline),
            label: "List",
            backgroundColor: Color(0xFF557F9F),
          ),
        ],
        currentIndex: activeIconIndex,
         onTap: onTap,       
    ),
    );
  }
}
