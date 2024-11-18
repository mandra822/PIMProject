import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 1;
  
  static final List<Widget> _widgetOptions = <Widget> [

    const Text(
      'Home Page'
    ),

    Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Rozdziela elementy
        children: [

          Column(
            children: [

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                ),
                child: const Text(
                  'Group 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                ),
                child: const Text(
                  'Group 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                ),
                child: const Text(
                  'Group 3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    '+ Add Group',
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




  


  

  



//old version of body 
  // body: Center(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () {},
  //             child: const Text('Add New Group'),
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () {},
  //             child: const Text('Open Groups'),
  //           ),
  //         ],
  //       ),
  //     ),

  // old version of AppBar
  // AppBar appBar() {
  //   return AppBar(
  //     title: const Text(
  //       'Expenses Splitter',
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 24,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     backgroundColor: Colors.white,
  //     centerTitle: true,
  //     leading: GestureDetector(
  //       onTap: () {
  //         // Define your onTap behavior here
  //       },
  //       child: Container(
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           color: const Color.fromARGB(255, 248, 247, 247),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: SvgPicture.asset(
  //           'assets/icons/ArrowLeft2.svg',
  //           height: 20,
  //           width: 20,
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       GestureDetector(
  //         onTap: () {
  //           // Define your onTap behavior here
  //         },
  //         child: Container(
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //             color: const Color.fromARGB(255, 248, 247, 247),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: SvgPicture.asset(
  //             'assets/icons/dots.svg',
  //             height: 5, // Adjusted for better visibility
  //             width: 5, // Adjusted for better visibility
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
