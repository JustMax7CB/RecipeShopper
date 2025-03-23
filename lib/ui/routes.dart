enum Routes {
  home("/home"),
  addRecipe("/addRecipe"),
  recipe("/recipe");

  final String path;

  const Routes(this.path);
}
