import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import '../widgets/main_drawer.dart';
import './favScreen.dart';
import './categoryScreen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeals;
  TabsScreen(this.favMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).canvasColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).bottomAppBarColor,
            currentIndex: _selectedPageIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                  Icons.category,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(
                  Icons.star,
                ),
                label: 'Favourites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
