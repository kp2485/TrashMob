//
//  TrashMobTypeSuggestionView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct TrashMobTypeSuggestionView: View {
  let suggestion: TrashMobSearchType

  private var gradientColors: [Color] {
    [Color.clear, Color.black]
  }

  @ViewBuilder private var gradientOverlay: some View {
    LinearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .opacity(0.3)
  }

  var body: some View {
    suggestion.suggestionImage
      .resizable()
      .aspectRatio(1, contentMode: .fill)
      .frame(height: 96)
      .overlay(gradientOverlay)
      .overlay(alignment: .bottomLeading) {
        Text(LocalizedStringKey(suggestion.rawValue.capitalized))
          .padding(12)
          .foregroundColor(.white)
          .font(.headline)
      }
      .cornerRadius(16)
  }
}

struct TrashMobTypeSuggestionView_Previews: PreviewProvider {
  static var previews: some View {
    TrashMobTypeSuggestionView(suggestion: TrashMobSearchType.park)
      .previewLayout(.sizeThatFits)
    TrashMobTypeSuggestionView(suggestion: TrashMobSearchType.park)
      .previewLayout(.sizeThatFits)
      .environment(\.locale, .init(identifier: "es"))
      .previewDisplayName("Spanish Locale")
  }
}
