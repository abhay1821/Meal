import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/fliter_screen.dart';
import './screens/tab_Screen.dart';
import './screens/categoryScreen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_mealScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  //avaialable meals after filter
  List<Meal> _availableMeals = DUMMY_MEALS;
  //empty list for fav meals
  List<Meal> _favMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    print('running');
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFav(String mealId) {
    //for checking whether it is part of
    final existingINdex = _favMeals.indexWhere((meal) => meal.id == mealId);
    if (existingINdex >= 0) {
      setState(() {
        _favMeals.removeAt(existingINdex);
      });
    } else {
      setState(() {
        _favMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFav(String id) {
    //returns true if any item is found
    return _favMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            // ignore: deprecated_member_use
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            // ignore: deprecated_member_use
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            // ignore: deprecated_member_use
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favMeals),
        // CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFav, _isMealFav),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      //if the route is not mentioned above so by default it will use it
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CategoryMealScreen.routeName:
            final argument = settings.arguments;
            return MaterialPageRoute(
              builder: (ctx) => CategoryMealScreen(
                parms: argument,
                availableMeals: _availableMeals,
              ),
            );
        }
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
