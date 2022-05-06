//
//  RecyclingRow.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/6/22.
//

import SwiftUI

struct RecyclingLocationRow: View {
  let recyclingLocation: RecyclingLocation

  var body: some View {
    HStack {
      Image(systemName: "trash.fill")

      VStack(alignment: .leading) {
          Text(recyclingLocation.description ?? "Location Description Missing")
          .multilineTextAlignment(.center)
          .font(.title3)
      }
      .lineLimit(1)
    }
  }
}

struct RecyclingLocation_Previews: PreviewProvider {
  static var previews: some View {
    if let recyclingLocation = RecyclingLocation.mock.first {
      RecyclingLocationRow(recyclingLocation: recyclingLocation)
    }
  }
}

