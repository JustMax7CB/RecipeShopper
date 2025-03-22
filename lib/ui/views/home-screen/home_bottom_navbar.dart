import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class HomeBottomNavbar extends StatefulWidget {
  const HomeBottomNavbar({super.key});

  @override
  State<HomeBottomNavbar> createState() => _HomeBottomNavbarState();
}

class _HomeBottomNavbarState extends State<HomeBottomNavbar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.09,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ImageResource(ImageRes.appbarBg),
          fit: BoxFit.fill,
        ),
      ),
      child: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
            showUnselectedLabels: false,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            currentIndex: selectedIndex,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Container(
                  padding: selectedIndex == 0 ? EdgeInsets.all(8) : null,
                  decoration: selectedIndex == 0
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(217, 217, 217, 0.5),
                        )
                      : null,
                  child: SvgIcon(
                    icon: LocalIcons.home,
                    width: 20,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Search",
                icon: Container(
                  padding: selectedIndex == 1 ? EdgeInsets.all(8) : null,
                  decoration: selectedIndex == 1
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(217, 217, 217, 0.5),
                        )
                      : null,
                  child: SvgIcon(
                    icon: LocalIcons.search,
                    width: 20,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Favorites",
                icon: Container(
                  padding: selectedIndex == 2 ? EdgeInsets.all(8) : null,
                  decoration: selectedIndex == 2
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(217, 217, 217, 0.5),
                        )
                      : null,
                  child: SvgIcon(
                    icon: LocalIcons.favorites,
                    width: 20,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Container(
                  padding: selectedIndex == 3 ? EdgeInsets.all(8) : null,
                  decoration: selectedIndex == 3
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(217, 217, 217, 0.5),
                        )
                      : null,
                  child: SvgIcon(
                    icon: LocalIcons.settings,
                    width: 20,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Container(
                  padding: selectedIndex == 4 ? EdgeInsets.all(8) : null,
                  decoration: selectedIndex == 4
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(217, 217, 217, 0.5),
                        )
                      : null,
                  child: SvgIcon(
                    icon: LocalIcons.profile,
                    width: 20,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
