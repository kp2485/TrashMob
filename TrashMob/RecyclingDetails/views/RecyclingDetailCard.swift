//
//  RecyclingDetailCard.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/2/22.
//

import SwiftUI

struct RecyclingDetailCard: View {
  let title: String
  let value: String
  let color: Color

  var body: some View {
    VStack {
      Text(title)
        .font(.subheadline)
      Text(value)
        .font(.headline)
    }
    .padding(.vertical)
    .frame(width: 96)
    .background(color.opacity(0.2))
    .foregroundColor(color)
    .cornerRadius(8)
  }
}

struct RecyclingDetailCard_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      RecyclingDetailCard(
        title: "Status",
        value: "Open",
        color: .green
      )
      RecyclingDetailCard(
        title: "Type",
        value: "Curbside",
        color: .blue
      )
    }
  }
}

