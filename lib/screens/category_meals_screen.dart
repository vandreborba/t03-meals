import 'package:flutter/material.dart';

import '../models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // O abaixo poderia ser feito normalmente. Mas quando se usa "route" não é possível passar argumentos assim.
  // tem que usar o routeArgs (abaixo)
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen(
  //     {Key? key, required this.categoryId, required this.categoryTitle})
  //     : super(key: key);

// Mais fácil definir esta constante para evitar erros de digitação.;
  static const routeName = '/category-meals-screen';

  final List<Meal> avaliableMeals;

  const CategoryMealsScreen(this.avaliableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = "";
  List<Meal> diplayedMeals = [];
  bool _loadedInitData = false;

  @override
  void initState() {
    // Roda antes do widget ser criado totalmente. Não dá para usar "context" aqui
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ele executa este parte várias vezes, então o professor fez um bool, para criar a lista só uma vez.
    // Eu acho que seria mais fácil só criar uma lista com os removidos, e não adicionar quando estiver construindo os widget.
    if (_loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      diplayedMeals = widget.avaliableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }

  void _removeMeal(String mealID) {
    setState(() {
      diplayedMeals.removeWhere((element) => element.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(categoryTitle!,
                style: Theme.of(context).textTheme.headline6)),
        body: ListView.builder(
          itemBuilder: (context, index) {
            // Na minha opinião seria mais fácil passar o próprio "meal" para o Meal Item, mas tudo bem.
            return MealItem(
              id: diplayedMeals[index].id,
              title: diplayedMeals[index].title,
              affordability: diplayedMeals[index].affordability,
              imageUrl: diplayedMeals[index].imageUrl,
              complexity: diplayedMeals[index].complexity,
              duration: diplayedMeals[index].duration,
              //removeItem: _removeMeal,
            );
          },
          itemCount: diplayedMeals.length,
        ));
  }
}
