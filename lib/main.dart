import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hover_menu/hover_menu.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Shader Demo',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.standard,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const AppPage(),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomePage(),
        Center(
          child: Text("Profile"),
        ),
        Center(
          child: Text("Settings"),
        ),
      ][selected],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        elevation: 20,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (value) {
          setState(() {
            selected = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person_outline),
                ),
                title: Text("Sami"),
                subtitle: Text("Man I love Flutter"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 200,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HoverMenu(
                      title: ElevatedButton.icon(
                        onPressed: () {},
                        label: Text("Like"),
                        icon: Icon(Icons.thumb_up_rounded),
                      ),
                      items: [
                        Card(
                          child: Row(
                            children: [
                              HoverGrowWidget(
                                child: IconButton(
                                  icon: Icon(Icons.thumb_up_rounded),
                                  onPressed: () {},
                                ),
                              ),
                              HoverGrowWidget(
                                child: IconButton(
                                  icon: Icon(Icons.celebration_rounded),
                                  onPressed: () {},
                                ),
                              ),
                              HoverGrowWidget(
                                child: IconButton(
                                  icon: Icon(Icons.favorite_rounded),
                                  onPressed: () {},
                                ),
                              ),
                              HoverGrowWidget(
                                child: IconButton(
                                  icon: Icon(Icons.lightbulb),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.comment_rounded),
                      label: Text("Comment"),
                      onPressed: () {},
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.loop_rounded),
                      label: Text("Like"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HoverGrowWidget extends StatefulWidget {
  final Widget child;
  HoverGrowWidget({super.key, required this.child});
  @override
  _HoverGrowWidgetState createState() => _HoverGrowWidgetState();
}

class _HoverGrowWidgetState extends State<HoverGrowWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: widget.child
            .animate(target: _isHovered ? 1 : 0)
            .scaleXY(end: 1.5, duration: 200.ms, curve: Easing.legacyDecelerate)
            .moveY(end: -10, duration: 200.ms, curve: Curves.easeOut));
  }
}
