//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Laura Belen Yachelini on 26/07/2023.
//

import Foundation

class RecipeData: ObservableObject{
  //Observable supervisa cuando cambia la propiedad @Published
  @Published var recipes = Recipe.testRecipes
    //recipes monitorea cuando Recipe.testRecipes cambia
  var favoriteRecipes: [Recipe]{
    recipes.filter { $0.isFavorite
    }
  }
  
  private var recipesFileURL: URL {
    
    do {
      let documentsDictionary = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      return documentsDictionary.appendingPathComponent("recipeData")
    }
    catch {
      fatalError("An error occurred while getting the url: \(error)")    }
  }
  
  func saveRecipes(){
    
    do{
      
      let encondedData = try JSONEncoder().encode(recipes)
      try encondedData.write(to: recipesFileURL)
    }
    catch{
      fatalError("An error occurred while saving recipes: \(error)")    }
  }
  
  func loadRecipes(){
    
    do {
      
      guard let data = try? Data(contentsOf: recipesFileURL) else {
        return}
      do{
        let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
        recipes = savedRecipes
      }catch{
        fatalError("An error occurred while loading recipes: \(error)")
      }
    }
  }
  

  
  func recipes(for category: MainInformation.Category) -> [Recipe]{
      var filteredRecipes: [Recipe] = []
        for recipe in recipes {
            if recipe.mainInformation.category == category{
                filteredRecipes.append(recipe)
      }
    }
    return filteredRecipes
  }
    
  func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
          saveRecipes()
    }
  }
  
  //method that returns the index of a given recipe
  func index(of recipe: Recipe)-> Int?{
    for i in recipes.indices{
      if recipes[i].id == recipe.id {
        return i
      }
    }
    return nil
  }
}
