import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'Category-meals';
  final Map<String, String> parms;
  final List<Meal> availableMeals;

  const CategoryMealScreen(
      {Key key, this.parms, this.availableMeals, List<Meal> avail})
      : super(key: key);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle = 'ABay';
  String categoryId;
  List<Meal> displayedMeals;
  // var _loadedInitData = false;

  void initState() {
    categoryTitle = widget.parms['title'];
    categoryId = widget.parms['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.initState();
  }

  //
  // void didChangeDependencies() {
  //   if (!_loadedInitData) {
  //     final routeArgs =
  //         ModalRoute.of(context).settings.arguments as Map<String, String>;
  //     // ignore: unused_local_variable
  //     categoryTitle = routeArgs['title'];
  //     categoryId = routeArgs['id'];
  //     displayedMeals = DUMMY_MEALS.where((meal) {
  //       return meal.categories.contains(categoryId);
  //     }).toList();
  //     print('Abhay');
  //     _loadedInitData = true;
  //   }
  //   super.didChangeDependencies();
  // }

  // ignore: unused_element
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    //using routes with arguments
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryTitle = routeArgs['title'];
    // final categoryId = routeArgs['id'];
    // final categoryMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
