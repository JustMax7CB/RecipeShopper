import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recipeshopper/core/constants.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/units.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/text_styles.dart';

class IngredientRow extends StatefulWidget {
  IngredientRow(
    this.id, {
    super.key,
    required this.onDelete,
    String? name,
    double? amount,
    Unit? unit,
  })  : _name = TextEditingController(text: name ?? ''),
        _amount = TextEditingController(text: amount?.toString() ?? ''),
        _selectedUnit = unit ?? Unit.values.first;

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

  bool get isEmpty => _name.text.isEmpty && _amount.text.isEmpty;
}

class _IngredientRowState extends State<IngredientRow>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    widget._name.dispose();
    widget._amount.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return context.localized.emptyIngredientName;
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return context.localized.emptyIngredientAmount;
    }
    return null;
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
            flex: 5,
            child: TextFormField(
              validator: validateName,
              maxLength: Constants.ingredientNameMaxLength,
              controller: widget._name,
              decoration: InputDecoration(
                counterText: '',
                fillColor: AppColors.textFieldFillColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                hintText: context.localized.ingredient,
                hintStyle: fieldHintTextStyle,
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Flexible(
            flex: 2,
            child: TextFormField(
              validator: validateAmount,
              maxLength: 4,
              controller: widget._amount,
              decoration: InputDecoration(
                counterText: '',
                fillColor: AppColors.textFieldFillColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                hintText: context.localized.amount,
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
                color: AppColors.textFieldFillColor,
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: SizedBox(),
                style: fieldHintTextStyle.copyWith(color: Colors.black),
                padding: Localizations.localeOf(context).direction(context) ==
                        TextDirection.rtl
                    ? EdgeInsets.only(right: 5)
                    : EdgeInsets.only(left: 5),
                value: widget._selectedUnit,
                items: Unit.values
                    .map(
                      (unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(
                          unit.getLocalizedName(context),
                        ),
                      ),
                    )
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
