enum Routes {
  home("/home"),
  addRecipe("/addRecipe"),
  recipe("/recipe"),
  settings("/settings");

  final String path;

  const Routes(this.path);
}
