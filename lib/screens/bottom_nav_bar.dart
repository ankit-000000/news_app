import 'package:flutter/material.dart';
import 'package:news_app/screens/bookmark_page.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/screens/profile_page.dart';
import 'package:news_app/screens/search_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;

    final List<Widget> children = [
      const NewsScreen(),
      const SearchPage(),
      const ProfilePage(),
      const BookmarkPage(),
    ];

    void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      body: Column(
        children: [
          children[currentIndex],
          const Spacer(),
          CustomBottomNavigationBar(
              currentIndex: currentIndex, onTap: onTabTapped),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xff393939), // Dark background color
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 0, onTap), // Home Icon
          _buildNavItem(Icons.search, 1, onTap), // Search Icon
          _buildNavItem(Icons.bookmark, 2, onTap), // Bookmark Icon
        ],
      ),
    );
    // return BottomNavigationBar(
    //   backgroundColor: Colors.black,
    //   currentIndex: currentIndex,
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.grey,
    //   onTap: onTabTapped,
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.search),
    //       label: 'Search',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.person),
    //       label: 'Profile',
    //     ),
    //   ],
    // );
  }

  _buildNavItem(IconData icon, int index, Function onItemTap) {
    return GestureDetector(
      onTap: () => onItemTap(index), // Handle tap event
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.white
              : Colors.transparent, // Change color if selected
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: currentIndex == index
              ? Colors.black
              : Colors.white, // Change icon color if selected
        ),
      ),
    );
  }
}
