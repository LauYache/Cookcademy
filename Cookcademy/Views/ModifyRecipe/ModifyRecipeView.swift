
import SwiftUI

struct ModifyRecipeView: View {
  
  @Binding var recipe: Recipe
  
  @State private var selection = Selection.main
  @Environment(\.presentationMode) private var mode

  var body: some View {
    
    VStack{
      
      Picker("Selection recipe component", selection: $selection) {
        Text("Main info").tag(Selection.main)
        Text("Ingredients").tag(Selection.ingredients)
        Text("Direction").tag(Selection.directions)
      }.pickerStyle(SegmentedPickerStyle())
        .padding()
      switch selection {
      case .main:
        ModifyMainInformationView(mainInformation: $recipe.mainInformation)
      case .ingredients:
        ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
      case .directions:
        ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions)
      }
       
      Spacer()
      
    }
  }
  
    enum Selection {
      case main
      case ingredients
      case directions
    }
  }

     /* Button("Fill in the recipe with test data."){
        
        recipe.mainInformation = MainInformation(name: "Pizza", description: "Put 500gr of flour in a bowl", author: "Lali", category: .dinner)
        recipe.directions = [Direction(description: "test", isOptional: true)]
        recipe.ingredients = [Ingredient(name: "Flour", quantity: 500.0, unit: .g)]
      } */

struct ModifyRecipeView_Previews: PreviewProvider {
  
  @State static var recipe = Recipe()
    static var previews: some View {
      ModifyRecipeView(recipe: $recipe)
    }
}
