// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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

    // Single Group View
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                // Settlement Strings
                const Text(
                  'You are owed XX zł',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),

                const SizedBox(height: 8),

                const Text(
                  'UserA owes you YY zł',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  )
                ),

                const SizedBox(height: 4),

                const Text(
                  'UserB owes you ZZ zł',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  )
                ),
                
                const SizedBox(height: 12),

                // Settlement Button
                ElevatedButton(
                  onPressed: () {
                    // settlement functionality
                  }, 
                  style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    'Settle It All',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16
                    )
                  )
                ),

                const SizedBox(height: 12),

                // Expences List
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Card(
                        child: ListTile(

                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                '07.10.2024',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                              )

                            ],
                          ),

                          title: Text(
                            'Papier toaletowy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue
                            ),
                          ),

                          subtitle: Text (
                            "UserA paid 10 zł",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),

                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "You borrowed 3,33 zł",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue
                                ),
                              )
                            ],

                          )

                        )
                      ),

                      Card(
                        child: ListTile(

                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                '04.10.2024',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),
                              )

                            ],
                          ),

                          title: Text(
                            'Tabletki do zmywarki',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue
                            ),
                          ),

                          subtitle: Text (
                            "You paid 40 zł",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),

                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "You lent 26,66 zł",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue
                                ),
                              )
                            ],

                          )

                        )
                      ),

                    ]
                  ),

              ]
            ) 
          ) 
        ),

        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                FloatingActionButton.extended(
                  onPressed: () {},
                  label: const Text(
                    '+ Add Expence',
                    style: TextStyle(
                      color: Colors.blue,
                    )
                  ),
                )

                // ElevatedButton(
                //   onPressed: () {},
                //   child: const Text('Delete Group'),
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 20, vertical: 15),
                //   ),
                // ),

              ],
            ),
          ),

      ],
    ),

    // Group Settings View
    Center(
      child: Column(
        children: [

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              // settlement functionality
            }, 
            style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15),
            ),
            child: const Text(
              'Edit Group Name',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              )
            )
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              // settlement functionality
            }, 
            style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 15),
            ),
            child: const Text(
              'Edit Group Members',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              )
            )
          ),

          const SizedBox(height: 12),
        ]
    )
    ),

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
        'Group X',

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
          label: 'Group',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings
            ),
          label: 'Settings'
        )
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[700],
      backgroundColor: const Color(0xFF76BBBF),
      onTap: _onItemTapped
    );
  }

}
