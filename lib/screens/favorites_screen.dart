import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        // O conteúdo que abrimos dentro de uma 'tab', não devemos criar o scaffold, só o conteúdo mesmo.
        // Caso contrário ele criará um outro "AppBar", o que em geral fica feio.
        child: Text('You have no favorites yet - star adding same!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          // Na minha opinião seria mais fácil passar o próprio "meal" para o Meal Item, mas tudo bem.
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            affordability: favoriteMeals[index].affordability,
            imageUrl: favoriteMeals[index].imageUrl,
            complexity: favoriteMeals[index].complexity,
            duration: favoriteMeals[index].duration,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
