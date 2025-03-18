import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class IngredientRow extends StatefulWidget {
  IngredientRow(this.id, {Key? key, required this.onDelete}) : super(key: key);

  final int id;
  final Function(int id) onDelete;

  @override
  State<IngredientRow> createState() => _IngredientRowState();
}

class _IngredientRowState extends State<IngredientRow> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _unit = TextEditingController(text: "Liters");

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: IconButton(
              onPressed: () => widget.onDelete(widget.id),
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              )),
        ),
        Flexible(
          flex: 5,
          child: TextFormField(
            controller: _name,
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
            controller: _amount,
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
          flex: 2,
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
              value: _unit.text,
              items: [
                DropdownMenuItem(
                  value: "Liters",
                  child: Text("Liters"),
                ),
                DropdownMenuItem(
                  value: "Kg",
                  child: Text("Kg"),
                ),
                DropdownMenuItem(
                  value: "Grams",
                  child: Text("Grams"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _unit.text = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
