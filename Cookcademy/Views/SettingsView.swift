//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Laura Belen Yachelini on 11/08/2023.
//

import SwiftUI

struct SettingsView: View {
  
  @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
  @AppStorage("listBackGroundColor") private var listBackgroundColor = AppColor.background
  @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
  
    var body: some View {
      NavigationView{
        Form{
          ColorPicker("List Background", selection: $listBackgroundColor)
            .padding()
            .listRowBackground(listBackgroundColor)
          ColorPicker("Text Color", selection: $listTextColor)
          Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
            .padding()
            .listRowBackground(listBackgroundColor)
        }
        foregroundColor(listTextColor)
          .navigationTitle("Settings")
      }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
