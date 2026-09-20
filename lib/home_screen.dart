import 'package:flutter/material.dart';

List<String> titles = ["calls", "camira", "chat"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const ContactScreen(),
    const CameraScreen(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
            icon: Icon(Icons.info_outline_rounded),
          ),
        ],
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Camera",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Center(child: Text("This is About page")),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCard(list: contacts, index: index);
        },
      ),
    );
  }
}

List<Map<String, String>> contacts = [
  {"title": "ahmed", "subtitle": "Missed call"},
  {"title": "mohamed", "subtitle": "Missed call"},
  {"title": "ali", "subtitle": "Missed call"},
];

class ContactCard extends StatelessWidget {
  final int index;
  final List list;
  final VoidCallback? func;

  const ContactCard({
    super.key,
    required this.list,
    required this.index,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            child: Text(list[index]["title"]!.trim()[0].toUpperCase()),
          ),

          title: Text(list[index]["title"]!),

          subtitle: Text(list[index]["subtitle"]!),

          trailing: const Icon(Icons.call),
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt, size: 100, color: Colors.teal),
          Text("Images taken $count", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Text("Take image"),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> chats = [
  {"title": "flutter developers", "subtitle": "Missed call"},
  {"title": "developer", "subtitle": "Missed call"},
  {"title": "softwer", "subtitle": "Missed call"},
];

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ContactCard(
          list: chats,
          index: index,
          func: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage(text: "${chats[index]["title"]}");
                },
              ),
            );
          },
        );
      },
    );
  }
}

class ChatPage extends StatelessWidget {
  final String text;

  const ChatPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("chat page")),
      body: Center(child: Text(text)),
    );
  }
}
