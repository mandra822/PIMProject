import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleGroup extends StatelessWidget {
  const SingleGroup({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Rozdziela elementy
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Group 1'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: null,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit Expenses'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 210, 176, 236),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit people in the group'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 210, 176, 236),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Split expenses'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 210, 176, 236),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
}
