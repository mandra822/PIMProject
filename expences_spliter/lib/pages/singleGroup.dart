import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleGroup extends StatefulWidget {
  const SingleGroup({super.key});

  @override
  State<SingleGroup> createState() => _SingleGroupState();
}

class _SingleGroupState extends State<SingleGroup> {

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget> [

    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),

        )
      ],
    ),

    const Text(
      'Group Settings'
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: bottomBar()
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Expenses Splitter',

        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),

      ),
      backgroundColor: const Color(0xFF8D86F3),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // Define your onTap behavior here
        },
        child: Container(
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   color: const Color.fromARGB(255, 248, 247, 247),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: SvgPicture.asset(
            'assets/icons/ArrowLeft2.svg',
            height: 20,
            width: 20,
            color: Colors.white
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // Define your onTap behavior here
          },
          child: Container(
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 248, 247, 247),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5, // Adjusted for better visibility
              width: 5, // Adjusted for better visibility
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home
            ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings
            ),
          label: 'Groups'
        )
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[700],
      backgroundColor: const Color(0xFF8D86F3),
      onTap: _onItemTapped
    );
  }
  
}
