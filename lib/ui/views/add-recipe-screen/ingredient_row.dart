import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/units.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class IngredientRow extends StatefulWidget {
  IngredientRow(this.id, {super.key, required this.onDelete});

  final String id;
  final Function(String id) onDelete;

  late final TextEditingController _name;
  late final TextEditingController _amount;
  late Unit _selectedUnit;

  @override
  State<IngredientRow> createState() => _IngredientRowState();

  Ingredient get model => Ingredient(
      id: id,
      name: _name.text,
      quantity: double.parse(_amount.text),
      unit: _selectedUnit);
}

class _IngredientRowState extends State<IngredientRow>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget._name = TextEditingController();
    widget._amount = TextEditingController();
    widget._selectedUnit = Unit.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => widget.onDelete(widget.id),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
            spacing: 2,
            borderRadius: BorderRadius.circular(5),
          )
        ],
      ),
      child: Row(
        spacing: 3,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: TextFormField(
              controller: widget._name,
              decoration: InputDecoration(
                fillColor: Color(0xFFFEFEFE),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0xFFEFEFEF), width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 7),
                hintText: "Ingredient",
                hintStyle: fieldHintTextStyle,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Flexible(
            flex: 2,
            child: TextFormField(
              controller: widget._amount,
              decoration: InputDecoration(
                fillColor: Color(0xFFFEFEFE),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0xFFEFEFEF), width: 1),
                ),
                contentPadding: EdgeInsets.only(left: 7),
                hintText: "Amount",
                hintStyle: fieldHintTextStyle,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1),
                color: Color(0xFFFEFEFE),
              ),
              child: DropdownButton(
                underline: SizedBox(),
                style: fieldHintTextStyle.copyWith(color: Colors.black),
                padding: EdgeInsets.only(left: 7),
                value: widget._selectedUnit,
                items: Unit.values
                    .map((unit) =>
                        DropdownMenuItem(value: unit, child: Text(unit.name)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    widget._selectedUnit = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return "[IngredientRow] Id: ${widget.id}, Name: ${widget._name.text}, Amount: ${widget._amount.text}";
  }
}
