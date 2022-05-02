//
//  SuggestionsGrid.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct SuggestionsGrid: View {
  @Environment(\.isSearching) var isSearching: Bool

  let suggestions: [TrashMobSearchType]
  var action: (TrashMobSearchType) -> Void

  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  var body: some View {
    VStack(alignment: .leading) {
      Text("Browse by Type")
        .font(.title2.bold())
      LazyVGrid(columns: columns) {
        ForEach(TrashMobSearchType.suggestions, id: \.self) { suggestion in
          Button {
            action(suggestion)
          } label: {
            TrashMobTypeSuggestionView(suggestion: suggestion)
          }
          .buttonStyle(.plain)
        }
      }
    }
    .padding(.horizontal)
    .opacity(isSearching ? 0 : 1)
  }
}

struct SuggestionsGrid_Previews: PreviewProvider {
  static var previews: some View {
    SuggestionsGrid(suggestions: TrashMobSearchType.suggestions) { _ in }
  }
}

