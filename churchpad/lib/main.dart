import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Add this line
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0000FF)),
      ),
      home: const MyHomePage(title: 'Churchpad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 44,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your notes',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Notification badge like the screenshot (static "8")
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26)],
              ),
              alignment: Alignment.center,
              child: const Text(
                '8',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // Filter chips row
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: const [
                    _PillChip(label: 'All', icon: Icons.circle, isFilled: true),
                    _PillChip(label: 'Favorites', icon: Icons.star_border),
                    _PillChip(label: 'Tags', icon: Icons.label_outline),
                  ],
                ),
                const SizedBox(height: 16),
                // Sort row and grid icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text('Last modified '),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                    const Icon(Icons.grid_view),
                  ],
                ),
                const SizedBox(height: 48),
                // Illustration placeholder
                Center(
                  child: Column(
                    children: const [
                      _EmptyIllustration(),
                      SizedBox(height: 24),
                      Text(
                        'Start creating your first note here.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          // Small circular + button (bottom-right, above the large button)
          Positioned(
            right: 16,
            bottom: 12,
            child: FloatingActionButton(
              onPressed: () {},
              mini: false,
              backgroundColor: Color(0xFF0000FF) ,
              child: const Icon(Icons.add),
            ),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Shared'),
          BottomNavigationBarItem(icon: Icon(Icons.delete_outline), label: 'Bin'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}

class _PillChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isFilled;
  const _PillChip({required this.label, required this.icon, this.isFilled = false});

  @override
  Widget build(BuildContext context) {
    final bg = isFilled
        ? Theme.of(context).colorScheme.primary.withOpacity(0.12)
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final fg = isFilled ? Theme.of(context).colorScheme.primary : null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: fg)),
        ],
      ),
    );
  }
}

class _EmptyIllustration extends StatelessWidget {
  const _EmptyIllustration();
  @override
  Widget build(BuildContext context) {
    // Placeholder drawing using icons to mimic the screenshot's playful art.
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          Icon(Icons.tablet_mac, size: 160, color: Colors.black12),
          Positioned(top: 12, left: 24, child: Icon(Icons.lightbulb_outline, size: 36, color: Colors.amber)),
          Positioned(right: 24, top: 36, child: Icon(Icons.star, size: 36, color: Colors.blue)),
          Positioned(bottom: 24, right: 48, child: Icon(Icons.edit, size: 28, color: Colors.black45)),
          Positioned(bottom: 28, left: 36, child: Icon(Icons.local_cafe, size: 28, color: Colors.brown)),
        ],
      ),
    );
  }
}
