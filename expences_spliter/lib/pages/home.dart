import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  // Lista grup
  final List<String> _groups = ['Group 1', 'Group 2', 'Group 3'];

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home Page',
    ),
  ];

  void _addGroup() {
    setState(() {
      _groups.add('Group ${_groups.length + 1}');
    });
  }

  void _deleteGroup(int index) {
    setState(() {
      _groups.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _selectedIndex == 1 ? groupsPage() : _widgetOptions.elementAt(0),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget groupsPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _groups.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Margines między grupami
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue[600],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                      ),
                      child: Text(
                        _groups[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 8), // Odstęp między przyciskiem a ikoną kosza
                    IconButton(
                      onPressed: () => _deleteGroup(index),
                      icon: const Icon(Icons.delete, color: Colors.red),
                      iconSize: 32,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: _addGroup,
                label: const Text(
                  '+ Add Group',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
      backgroundColor: const Color(0xFF76BBBF),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // Define your onTap behavior here
        },
        child: Container(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/ArrowLeft2.svg',
            height: 20,
            width: 20,
            color: Colors.white,
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
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Groups',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[700],
      backgroundColor: const Color(0xFF76BBBF),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
