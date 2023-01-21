import 'package:flutter/material.dart';

import './dummy_data.dart';

import './screens/filters_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail.dart';
import './screens/tabs_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // O professor usou este mapa para salvar as configurações enntre tela.
  // Mas tem método próprio para isto: "SharedPreferences", que fica salvo.
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        // ...
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          errorColor: Colors.red,
        ).copyWith(
          secondary: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
                // título.
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.white),
            headline5: TextStyle(
                // título.
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      //home: CategoriesScreen(), // Marca a primeira Screen do aplicativo.
      //Por padrão o que tiver o nome: "/" no routes, será a primeira tela a ser aberta.
      //initialRoute: '/', // Não precisa setar! Mas pode mudar.
      routes: {
        // Este "/" no início é apenas uma conveção, que vem da web: www.site.com/categories.
        // Não irá passar o argumento aqui! (provavelmente)
        '/': (context) => TabsScreen(favoriteMeals: _favoriteMeals),
        // '/category-meals': (context) => CategoryMealsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
            _availableMeals), // Uma forma alternativa, para evitar typos.
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(
            toggleFavorite: _toggleFavorite, isMealFavorite: _isMealFavorite),
        FilterScreen.routName: (context) =>
            FilterScreen(saveFilters: _setFilters, currentFilters: _filters)
      },
      onGenerateRoute: ((settings) {
        //Chamará se a rota chamada não estiver registrada no "routes", muitas vezes não precisa desta função.
        // pode ser usado quando se cria nome de rotas de forma dinâmica
        print(settings.arguments);
        print(settings.name);
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      }),
      onUnknownRoute: (settings) {
        // Executa quando não consegue achar uma rota de forma alguma.

        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
