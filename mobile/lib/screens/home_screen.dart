import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              shadowColor: Colors.indigo.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/languages');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      child: const Text('Gerenciar Idiomas'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/lessons');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      child: const Text('Gerenciar Lições'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/languages');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/lessons');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Idiomas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lições',
          ),
        ],
      ),
    );
  }
}
