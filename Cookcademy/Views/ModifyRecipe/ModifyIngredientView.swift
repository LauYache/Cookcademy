//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Laura Belen Yachelini on 04/08/2023.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
  
  @Binding var ingredient: Ingredient
  @Environment(\.presentationMode) private var mode
  let createAction: ((Ingredient) -> Void)
  
  init(component: Binding<Ingredient>, createAction: @escaping(Ingredient) -> Void){
    
    self._ingredient = component
    self.createAction = createAction
  }
  
  
  @State static var emptyIngredient = Ingredient()
  
    var body: some View {
        Form{
          TextField("Ingredient", text: $ingredient.name)
          Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5){
            HStack{
              Text("Quantity:")
              TextField("Quantity",
                        value: $ingredient.quantity,
                        formatter: NumberFormatter.decimal)
              .keyboardType(.numbersAndPunctuation)
            }
          }
          
          Picker(selection: $ingredient.unit, label:
                  HStack{
            
            Text("Unit")
            Spacer()
            Text(ingredient.unit.rawValue)
          }){
            ForEach(Ingredient.Unit.allCases, id:\.self) { unit in
              
              Text(unit.rawValue)
            }
          }
          .pickerStyle(MenuPickerStyle())
          
          HStack{
            
            Spacer()
            Button("Save") {
              createAction(ingredient)
              mode.wrappedValue.dismiss()
            }
            Spacer()
          }
        }
      
      
      }
    
}

extension NumberFormatter {
  
  static var decimal: NumberFormatter {
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }
}

struct ModifyIngredientView_Previews: PreviewProvider {
  @State static var emptyIngredient = Recipe.testRecipes[0].ingredients[0]
  static var previews: some View {
    NavigationView {
      ModifyIngredientView(component: $emptyIngredient) { ingredient in
        print(ingredient)
      }
    }.navigationTitle("Add Ingredient")
  }
}
 
