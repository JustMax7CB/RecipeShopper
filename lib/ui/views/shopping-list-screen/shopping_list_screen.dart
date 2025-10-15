import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/shopping_list_viewmodel.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShoppingListViewModel>()
      ..resolveIngredientsFromRecipes();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ImageResource(ImageRes.fadedWood),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(23),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xAAF3F3F3),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 0.6),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: SvgIcon(
                      icon: LocalIcons.pencil,
                      width: 22,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ImageResource(ImageRes.notepadBg),
                  ),
                ),
                child: ListView.builder(
                  itemExtent: 60,
                  itemCount: viewModel.ingredientCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 5.0),
                      child: ListTile(
                        title: Text(
                          maxLines: 1,
                          viewModel.ingredientString(index),
                          style: recipeIngredientsTitleTextStyle,
                        ),
                        trailing: Transform(
                          transform: Matrix4.identity()
                            ..scale(1.2)
                            ..translate(0.0, -2.0),
                          alignment: Alignment.center,
                          child: Checkbox(
                            side: BorderSide(color: Colors.black, width: 1),
                            checkColor: Colors.black,
                            fillColor:
                                WidgetStatePropertyAll<Color>(Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
