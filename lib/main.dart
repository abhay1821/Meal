import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/theme.dart';
import 'utils/dummy_data.dart';
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
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];
  void _setFilters(Map<String, bool> filterData) {
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
    return _favMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: AppTheme.appTheme,

      routes: {
        '/': (ctx) => TabsScreen(_favMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFav, _isMealFav),
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
