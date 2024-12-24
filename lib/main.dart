import 'package:flutter/material.dart';
import 'package:news_api/pages/business_page.dart';
import 'package:news_api/pages/entertainment_page.dart';
import 'package:news_api/pages/health_page.dart';
import 'package:news_api/pages/everything_page.dart';
import 'package:news_api/pages/tech_page.dart';
import 'package:news_api/providers/category_provider.dart';
import 'package:news_api/providers/everything_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => EverythingProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TabViewPage(),
    );
  }
}

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   var currentIndex = 0;

//   var bodies = const [
//     CategoryPage(),
//     Scaffold(),
//     EverythingPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: bodies[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.post_add), label: "Category"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Empty"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.comment), label: "Everything"),
//         ],
//       ),
//     );
//   }
// }

class TabViewPage extends StatefulWidget {
  const TabViewPage({super.key});

  @override
  State<TabViewPage> createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage> with SingleTickerProviderStateMixin {
  // TabController tabController;

  // @override
  // void initState() {
  //   tabController = TabController(length: 4, vsync: this);
  //   tabController.addListener(() {
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.green,
          title: const Text("News Api"),
          bottom: const TabBar(
            // isScrollable: true,

            // controller: tabController,
            tabs: [
              Tab(
                text: "Business",
                icon: Icon(Icons.business),
              ),
              Tab(
                text: "Health",
                icon: Icon(Icons.health_and_safety),
              ),
              Tab(
                text: "Entertainment",
                icon: Icon(Icons.video_chat),
              ),
              Tab(
                text: "Technology",
                icon: Icon(Icons.military_tech_outlined),
              ),
            ],
          ),
        ),
        body:  const TabBarView(
            children: [
              BusinessPage(),
              HealthPage(),
              EntertainmentPage(),
              TechPage(),
            ],
          ),
      ),
    );
  }
}
