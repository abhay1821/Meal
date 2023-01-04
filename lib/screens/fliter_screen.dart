import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = true;
  bool _lactoseFree = true;
  bool _vegan = true;
  bool _vegetarian = true;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentvalue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentvalue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        //for changing according to the filters
        actions: <Widget>[
          IconButton(
            //for reaching out the widget
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Slection',
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Only includes gluten-free meals',
                  _glutenFree,
                  (newvalue) {
                    setState(() {
                      _glutenFree = newvalue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Only includes Lactose-free meals',
                  _lactoseFree ?? true,
                  (newvalue) {
                    setState(() {
                      _lactoseFree = newvalue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only includes Vegetarian meals',
                  _vegetarian,
                  (newvalue) {
                    setState(() {
                      _vegetarian = newvalue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only includes Vegan meals',
                  _vegan,
                  (newvalue) {
                    setState(() {
                      _vegan = newvalue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
