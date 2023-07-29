import 'dart:ffi';

class RecipeModal{
  late String label;
  late String imageUrl;
  late String appUrl;
  late String calories;


  RecipeModal({this.label = "N/A", this.imageUrl = "N/A", this.appUrl = "N/A", this.calories = "N/A"});

  factory RecipeModal.dataFromMap(Map recipeData)
  {
    return RecipeModal(
      label: recipeData["label"],
      imageUrl: recipeData["image"],
      appUrl: recipeData["url"],



      calories: recipeData["calories"].toString(),

    );
  }


}
