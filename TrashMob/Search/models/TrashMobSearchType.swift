//
//  TrashMobSearchType.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

enum TrashMobSearchType: String, CaseIterable {
  case none
  case park
  case sidewalk
  case privateProperty = "private property"
  case waterfront
}

// Return appropriate category images
extension TrashMobSearchType {
  var suggestionImage: Image {
    switch self {
    case .privateProperty:
      return Image("privateProperty")
    default:
      return Image(rawValue)
    }
  }
}

// Return suggestions
extension TrashMobSearchType {
  static var suggestions: [TrashMobSearchType] {
    var suggestions = TrashMobSearchType.allCases
    // Removing 'none' from suggestions
    suggestions.removeFirst()
    return suggestions
  }
}

