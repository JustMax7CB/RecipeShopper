import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipeshopper/core/models/recipe.dart';
import 'package:recipeshopper/extensions.dart';
import 'package:recipeshopper/ui/colors.dart';
import 'package:recipeshopper/ui/routes.dart';
import 'package:recipeshopper/ui/text_styles.dart';
import 'package:recipeshopper/ui/viewmodels/add_recipe_viewmodel.dart';
import 'package:recipeshopper/ui/widgets/image_resource.dart';
import 'package:recipeshopper/ui/widgets/svg_icon.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key, Recipe? recipe}) : _recipe = recipe;

  final Recipe? _recipe;

  @override
  Widget build(BuildContext context) {
    final AddRecipeViewModel viewModel = context.watch<AddRecipeViewModel>();

    if (_recipe != null && viewModel.updatedRecipe == null) {
      viewModel.loadRecipe(_recipe);
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ImageResource(ImageRes.fadedWood),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              _showImageSourceDialog(context, viewModel),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.blackQuarterOpacity,
                                    offset: Offset(0, 4),
                                    blurRadius: 4)
                              ],
                              color: AppColors.recipeImageBgColor,
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: Center(
                              child: viewModel.selectedImage == null
                                  ? SvgIcon(icon: LocalIcons.placeholderImage)
                                  : Image.file(
                                      viewModel.selectedImage!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
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
                        if (viewModel.selectedImage != null)
                          Positioned(
                            left: MediaQuery.sizeOf(context).width / 2.3,
                            top: 70,
                            child: IconButton(
                                onPressed: () {
                                  viewModel.selectedImage = null;
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 25,
                                  color: AppColors.appBarIconColor,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, 1),
                                        blurRadius: 8)
                                  ],
                                )),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 12),
                      child: TextFormField(
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        controller: viewModel.recipeNameController,
                        decoration: InputDecoration(
                          fillColor: AppColors.textFieldFillColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          hintText: context.localized.recipeName,
                          hintStyle: fieldHintTextStyle,
                        ),
                      ),
                    ),
                    ingredientsSection(viewModel, context),
                    instructionsSection(viewModel, context),
                    Container(
                      margin: EdgeInsets.only(top: 35, bottom: 70),
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
                              AppColors.saveGradientColor1,
                              AppColors.saveGradientColor2,
                              AppColors.saveGradientColor3
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
                        onPressed: () => saveAction(context, viewModel),
                        child: Text(
                          context.localized.save,
                          style: newRecipeSaveButtonTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Consumer<AddRecipeViewModel>(
              builder: (context, value, child) => Visibility(
                visible: value.isLoading,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ingredientsSection(AddRecipeViewModel vm, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 70),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.addRecipeSectionBgColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.addRecipeSectionBorderColor,
          ),
          top: BorderSide(
            color: AppColors.addRecipeSectionBorderColor,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            context.localized.ingredients,
            style: newRecipeSectionTitle,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                SizedBox(
                  child: Form(
                    key: vm.formKey,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: vm.ingredients.length,
                      itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: vm.ingredients[index]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      onPressed: () => vm.addIngredient(),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SvgIcon(
                                icon: LocalIcons.addRecipe,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              context.localized.addIngredient,
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

  Widget instructionsSection(AddRecipeViewModel viewModel, BuildContext ctx) {
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
            ctx.localized.instructions,
            style: newRecipeSectionTitle,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
            child: TextFormField(
              controller: viewModel.recipeInstructionsController,
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                fillColor: AppColors.textFieldFillColor,
                filled: true,
                hintText: ctx.localized.instructionHint,
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

  Future<void> _loadImage(
      ImageSource source, AddRecipeViewModel viewModel) async {
    final ImagePicker imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage == null) {
      return;
    }

    // Assign the selected image to the ViewModel

    viewModel.selectedImage = File(pickedImage.path);
  }

  void _showImageSourceDialog(
      BuildContext context, AddRecipeViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              iconColor: Colors.blue,
              title: Text(context.localized.takePhoto),
              onTap: () {
                Navigator.pop(context);
                _loadImage(ImageSource.camera, viewModel);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              iconColor: Colors.green,
              title: Text(context.localized.chooseFromLibrary),
              onTap: () {
                Navigator.pop(context);
                _loadImage(ImageSource.gallery, viewModel);
              },
            ),
          ],
        ));
      },
    );
  }

  void saveAction(BuildContext context, AddRecipeViewModel viewModel) {
    final navigator = Navigator.of(context);

    if (viewModel.isUpdate) {
      viewModel.updateRecipe().then((recipe) {
        debugPrint("======= Updated recipe: $recipe");
        if (recipe != null) {
          navigator.pushReplacementNamed(Routes.recipe.path, arguments: recipe);
        } else {
          debugPrint("==== Failed to update the recipe");
        }
      });

      return;
    }

    viewModel.createRecipe().then((_) => navigator.pop());
  }
}
