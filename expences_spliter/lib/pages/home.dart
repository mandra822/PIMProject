import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expences_spliter/pages/singleGroup.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class HomePageContent extends StatefulWidget {
  final List<Map<String, dynamic>> groups;  
  final Function(String) onGroupTap;
  final Function(String) onAddGroup;

  const HomePageContent({
    Key? key,
    required this.groups,
    required this.onGroupTap,
    required this.onAddGroup,
  }) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final TextEditingController _groupNameController = TextEditingController();

  void _addGroup() {
    String groupName = _groupNameController.text;
    if (groupName.isNotEmpty) {
      widget.onAddGroup(groupName);
      _groupNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _groupNameController,
            decoration: const InputDecoration(
              labelText: 'Enter group name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _addGroup,
          child: const Text('Create Group'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: widget.groups.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.groups[index]['groupName']),
                onTap: () {
                  widget.onGroupTap(widget.groups[index]['groupId']);  // Use groupId here
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _groups = []; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  void _fetchGroups() async {
    var snapshot = await _firestore.collection('groups').get();
    setState(() {
      _groups = snapshot.docs.map((doc) {
        return {
          'groupId': doc['groupId'],
          'groupName': doc['groupName'],
        };
      }).toList();
    });
  }

  void _addGroup(String groupName) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    }

    // Tworzymy grupę i dodajemy użytkownika do listy członków
    DocumentReference groupRef = await _firestore.collection('groups').add({
      'groupId': _firestore.collection('groups').doc().id,
      'groupName': groupName,
      'usersIDs': [user.uid], 
      'groupMembers': [user.displayName], 
      'expensesIDs': [],
    });

    var groupSnapshot = await groupRef.get();

    setState(() {
      _groups.add({
        'groupId': groupSnapshot['groupId'],
        'groupName': groupSnapshot['groupName'],
      });
    });
  }

  void _navigateToGroupDetails(String groupId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleGroup(groupId: groupId), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: HomePageContent(
        groups: _groups,
        onGroupTap: _navigateToGroupDetails,
        onAddGroup: _addGroup,
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Expenses Splitter'),
      backgroundColor: Colors.blue[600],
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
