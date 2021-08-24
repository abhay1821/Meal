import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import '../widgets/main_drawer.dart';
import './favScreen.dart';
import './categoryScreen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeals;
  TabsScreen(this.favMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  // final List<Map<String, Object>> _pages = [
  //   {
  //     'page': CategoriesScreen(),
  //     'title': 'Categories',
  //   },
  //   {
  //     //we cannot pass widget favmeals due to
  //     // build method it can be used in init state
  //     'page': FavScreen(widget.favMeals),
  //     'title': 'Your Favourites',
  //   },
  // ];
  //for the Tabs no
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        //it can be executed before build
        'page': FavScreen(widget.favMeals),
        'title': 'Your Favourites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            // ignore: deprecated_member_use
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.star,
            ),
            // ignore: deprecated_member_use
            title: Text('Favourites'),
          ),
        ],
      ),
    );
    // return DefaultTabController(
    //   length: 2,
    //   // for default tab view or fav
    //   // initialIndex: 1,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meals'),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             icon: Icon(
    //               Icons.category,
    //             ),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(
    //               Icons.category,
    //             ),
    //             text: 'Favorites',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: <Widget>[
    //         CategoriesScreen(),
    //         FavScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
