//
//  DatePickerView.swift
//  TrashMob
//
//  Created by Kyle Peterson on 6/13/22.
//

import SwiftUI

struct DatePickerView: View {
    
    @EnvironmentObject var vm: TrashMobViewModel
    
    var body: some View {
//        DatePicker("Please choose a day and time that works for you", selection: <#T##Binding<Date>#>, in: <#T##PartialRangeFrom<Date>#>, displayedComponents: <#T##DatePicker<Text>.Components#>)
        Text("Choose a Date:")
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
