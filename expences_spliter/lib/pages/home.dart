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

  void removeGroup(String groupId) async {
    await FirebaseFirestore.instance.collection('groups').doc(groupId).delete();
  }

  void _addGroup() {
    String groupName = _groupNameController.text;
    if (groupName.isNotEmpty) {
      widget.onAddGroup(groupName);
      _groupNameController.clear();
    }
  }

  void _showNewGroupModal(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("New Group"),
        content: TextField(
          controller: _groupNameController,
          decoration: const InputDecoration(labelText: 'New Group Name'),
        ),
        actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _addGroup();
                Navigator.of(context).pop();
              },
            ),
          ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: widget.groups.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(widget.groups[index]['groupName']),
                  onTap: () {
                  widget.onGroupTap(
                      widget.groups[index]['groupId']); // Use groupId here
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    onPressed: () {
                      setState(() {
                        removeGroup(widget.groups[index]['groupId']);
                        widget.groups.removeAt(index);
                      });
                    },
                  ),
                )
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
                onPressed: () {
                  _showNewGroupModal(context);
                },
                label:
                    const Text('+ Add new group', style: TextStyle(color: Colors.blue)),
              ),
            ],
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
    var snapshot = await _firestore
        .collection('groups')
        .where('userID', isEqualTo: _auth.currentUser!.uid)
        .get();
    setState(() {
      _groups = snapshot.docs.map((doc) {
        return {
          'groupId': doc.id,
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
      // 'groupId': _firestore.collection('groups').doc().id,
      'groupName': groupName,
      'userID': user.uid,
      'groupMembers': [],
      'expensesIDs': [],
    });

    var groupSnapshot = await groupRef.get();

    setState(() {
      _groups.add({
        'groupId': groupSnapshot.id,
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
      title: Text('Expenses Splitter',
          style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
          )
        ),
      backgroundColor: const Color(0xFF76BBBF),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[700],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      backgroundColor: const Color(0xFF76BBBF),
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
