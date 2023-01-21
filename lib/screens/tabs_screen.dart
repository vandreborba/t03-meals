import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({Key? key, required this.favoriteMeals}) : super(key: key);
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];

  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Não precisava ser aqui, poderia ser logo abaixo da classe. Mas temos que acessar o "widget.favoriteMeals"

    //final List<Widget> _pages = [CategoriesScreen(), FavoriteScreen()];
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoriteScreen(favoriteMeals: widget.favoriteMeals),
        'title': 'Favorites'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType
              .fixed, // shifting é um tipo de animação ... Tem que colocar estilo nos ícones, quando setado assim.
          currentIndex:
              _selectPageIndex, // o Widget utiliza isto para setar corretamente a aparência dos ícones.
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.primary,
                icon: Icon(Icons.category),
                label: 'Categories'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).colorScheme.primary,
                icon: Icon(Icons.stars),
                label: 'Favorities')
          ]),
    );
  }

  /*return DefaultTabController(
      //Defalult Tab cria aba na parte de cima do app. O que é muito mais simples de fazer.
      
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Meals'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.category),
                  text: 'Categories',
                ),
                Tab(
                  icon: Icon(Icons.star_border),
                  text: 'Favorite',
                )
              ],
                        
            )),
        body: TabBarView(children: <Widget>[
          CategoriesScreen(),
          FavoriteScreen()
        ]), // Aqui vão as páginas que serão chamadas em cada tab.
      ),
    );
  }
  */
}
