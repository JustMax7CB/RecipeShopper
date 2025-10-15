import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:recipeshopper/core/constants.dart';
import 'package:recipeshopper/core/models/ingredient.dart';
import 'package:recipeshopper/core/models/units.dart';
import 'package:recipeshopper/core/utils/new_recipe_validators.dart';
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
  })  : nameController = TextEditingController(text: name ?? ''),
        amountController = TextEditingController(text: amount?.toString() ?? ''),
        selectedUnit = unit ?? Unit.values.first;

  final String id;
  final Function(String id) onDelete;

  late final TextEditingController nameController;
  late final TextEditingController amountController;
  late Unit selectedUnit;

  @override
  State<IngredientRow> createState() => _IngredientRowState();

  Ingredient get model => Ingredient(
      id: id,
      name: nameController.text,
      quantity: double.parse(amountController.text),
      unit: selectedUnit);

  bool get isEmpty => nameController.text.isEmpty && amountController.text.isEmpty;
}

class _IngredientRowState extends State<IngredientRow>
    with SingleTickerProviderStateMixin {
  @override

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
              validator: (val) => NewRecipeValidators.ingredientNameValidator(val, context),
              maxLength: Constants.ingredientNameMaxLength,
              controller: widget.nameController,
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
              validator: (val) => NewRecipeValidators.ingredientAmountValidator(val, context),
              maxLength: 4,
              controller: widget.amountController,
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
                value: widget.selectedUnit,
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
                    widget.selectedUnit = value!;
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
    return "[IngredientRow] Id: ${widget.id}, Name: ${widget.nameController.text}, Amount: ${widget.amountController.text}";
  }
}
