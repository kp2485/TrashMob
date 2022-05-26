//
//  TrashMobAnnotationView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/26/22.
//

import SwiftUI

struct TrashMobAnnotationView: View {
  @State private var showTime = true
    @State var trashMobState: String
    
  let time: String
  
  var body: some View {
    
      
      VStack(spacing: 0) {
      Text(time)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTime ? 0 : 1)
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
    .onTapGesture {
      withAnimation(.easeInOut) {
        showTime.toggle()
      }
    }
  }
}

struct TrashMobAnnotationView_Previews: PreviewProvider {

    
    static var previews: some View {
        TrashMobAnnotationView(trashMobState: "scheduling", time: "time until next event")
    }
}
