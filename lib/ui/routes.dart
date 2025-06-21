enum Routes {
  main("/"),
  home("/home"),
  addRecipe("/addRecipe"),
  recipe("/recipe"),
  settings("/settings"),
  shoppingList("/shoppingList");

  final String path;

  const Routes(this.path);
}
