import 'package:flutter/material.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/views/add-recipe-screen/ingredient_row.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class AddRecipeScreen extends StatefulWidget {
  AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _recipeName = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  List<IngredientRow> ingredients = [];

  int ingredientId = 1;

  void removeIngredient(int id) {
    setState(() {
      print("Removing ingredient row with id: $id");
      ingredients.removeWhere((ingredient) => ingredient.id == id);
    });
  }

  @override
  void initState() {
    super.initState();
    ingredients.add(IngredientRow(ingredientId, onDelete: removeIngredient));
    ingredientId++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: LoadImage,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                                blurRadius: 4)
                          ],
                          color: Color(0xFFF4F4F4),
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 1))),
                      child: Center(
                        child: SvgIcon(icon: LocalIcons.placeholderImage),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 25,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0, 1),
                              blurRadius: 8)
                        ],
                      )),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
                child: TextFormField(
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  controller: _recipeName,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFFEFEFE),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    hintText: "Recipe Name",
                    hintStyle: fieldHintTextStyle,
                  ),
                ),
              ),
              IngredientsSection(),
              InstructionSection(),
              Container(
                margin: EdgeInsets.only(top: 35, bottom: 30),
                width: 150,
                height: 45,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(1, 2),
                        blurRadius: 2),
                  ],
                  border: Border.all(color: Colors.black, width: 0.4),
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFFD6C4BD),
                        Color(0xFFEFEFEF),
                        Color(0xFF8D7E7E)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      transform: GradientRotation(-0.5)),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: newRecipeSaveButtonTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget IngredientsSection() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 70),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 244, 244, 0.75),
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(23, 23, 23, 0.75),
          ),
          top: BorderSide(
            color: Color.fromRGBO(23, 23, 23, 0.75),
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Ingredients",
            style: newRecipeSectionTitle,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ingredients[index]),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      onPressed: () {
                        setState(() {
                          ingredients.add(IngredientRow(ingredientId,
                              onDelete: removeIngredient));
                          ingredientId++;
                        });
                      },
                      child: FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgIcon(
                                icon: LocalIcons.addRecipe,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              "Add Ingredient",
                              style: newRecipeAddIngredientTextStyle,
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget InstructionSection() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 244, 244, 0.75),
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(23, 23, 23, 0.75),
          ),
          top: BorderSide(
            color: Color.fromRGBO(23, 23, 23, 0.75),
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Instructions",
            style: newRecipeSectionTitle,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
            child: TextFormField(
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                fillColor: Color(0xFFFEFEFE),
                filled: true,
                hintText: "Write instructions for the recipe...",
                hintStyle: fieldHintTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black)),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }

  void LoadImage() {
    print("Pressed on LoadImage");
  }
}
