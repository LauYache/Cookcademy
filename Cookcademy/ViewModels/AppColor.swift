//
//  AppColor.swift
//  Cookcademy
//
//  Created by Laura Belen Yachelini on 27/07/2023.
//

import Foundation
import SwiftUI

struct AppColor {
  static let background: Color = Color(.sRGB,
                                       red: 228/255,
                                       green: 235/255,
                                       blue: 250/255,
                                       opacity: 1)
  static let foreground: Color = Color(.sRGB,
                                       red: 118/255,
                                       green: 119/255,
                                       blue: 231/255,
                                       opacity: 1)
}

extension Color: RawRepresentable {
  //The first step is to get the red, green, blue, and alpha components from a Color
  public init?(rawValue: String) {
    do {
      let encodedData = rawValue.data(using: .utf8)!
      let components = try JSONDecoder().decode([Double].self, from: encodedData)
      self = Color(red: components[0],
                   green: components[1],
                   blue: components[2],
                   opacity: components[3])
    }
    catch {
      return nil
    }
  }
  //rawValue codifica el color en una cadena y el inicializador convierte la cadena nuevamente en un objeto de color.
  public var rawValue: String {
    guard let cgFloatComponents = UIColor(self).cgColor.components else { return "" }
    let doubleComponents = cgFloatComponents.map { Double($0) }
    do {
      let encodedComponents = try JSONEncoder().encode(doubleComponents)
      return String(data: encodedComponents, encoding: .utf8) ?? ""
    }
    catch {
      return ""
    }
  }
}
 
