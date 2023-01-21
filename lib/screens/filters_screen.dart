import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FilterScreen(
      {Key? key,
      required Function this.saveFilters,
      required this.currentFilters})
      : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: (value) => updateValue(value),
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters Screen"),
        actions: [
          IconButton(
              onPressed: () {
                Map<String, bool> selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline5),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildSwitchTile(
                  "Gluten-free", "Only include gluten-free meal", _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchTile("Lactose-free", "Only include lactose-free meal",
                  _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitchTile(
                  "Vegetarian", "Only include vegetarian meal", _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchTile("Vegan", "Only include vegan meal", _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              })
            ],
          ),
        )
      ]),
      drawer: MainDrawer(),
    );
  }
}
