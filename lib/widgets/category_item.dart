import 'dart:js';

import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  void selectCategory(BuildContext ctx) {
    // Uma opção seria a de baixo, mas em aplicativos cheio de tela pode ficar extremamente confuso.
    // Navigator.of(ctx)
    //     .push(// Tem várias opções do push! Veja o que fica melhor no caso.
    //         MaterialPageRoute(builder: (context) {
    //   return CategoryMealsScreen(categoryId: id, categoryTitle: title);
    // }));
    //
    // No comando abaixo está passando um "Map" como argumento ao "route", depois no Widget Meals Screen será possível recuperá-lo.
    // Mas daria para passar também o Model como argumento, já que ele terá as informações que precisamos.
    //
    //Navigator.of(ctx).pushNamed('/category-meals', arguments: {'id': id, 'title': title});
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
        arguments: {'id': id, 'title': title});
  }

  const CategoryItem(
      {Key? key, required this.id, required this.title, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Este InkWell faz um efeito visual quando se clica. Poderia usar o Gessture Detector tb.
      onTap: () {
        selectCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(
          15), // É legal deixar o mesmo BorderRadius do BoxDecoration quando for o caso.

      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
