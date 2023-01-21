import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetailsScreen(
      {Key? key, required this.toggleFavorite, required this.isMealFavorite})
      : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Widget buildSectionTitle(String title, BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ));
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
          title: Text('${selectedMeal.title}',
              style: Theme.of(context).textTheme.headline6)),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            widget.isMealFavorite(mealId) ? Icons.star : Icons.star_border),
        onPressed: (() {
          setState(() {
            widget.toggleFavorite(mealId);
          });
        }),
      ),

      /*FloatingActionButton(
        // Botão deletar. Não vamos usar, serviu para demonstrar como faz...
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
      ),*/
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(ListView.builder(
              itemCount: selectedMeal.ingredients.length,
              itemBuilder: ((context, index) => Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  )),
            )),
            buildSectionTitle('Steps', context),
            buildContainer(ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(child: Text('# ${index + 1}')),
                    title: Text('${selectedMeal.steps[index]}'),
                  ),
                  Divider()
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
    );
  }
}
