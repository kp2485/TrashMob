//
//  EmptyResultsView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct EmptyResultsView: View {
  let query: String
  var body: some View {
    VStack {
      Image(systemName: "trash.slash.circle.fill")
        .resizable()
        .frame(width: 64, height: 64)
        .padding()
        .foregroundColor(.yellow)
      Text("Sorry, we couldn't find trash mobs for \"\(query)\"")
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)
    }
  }
}

struct EmptyResultsView_Previews: PreviewProvider {
  static var previews: some View {
    EmptyResultsView(query: "Linwood")
  }
}
