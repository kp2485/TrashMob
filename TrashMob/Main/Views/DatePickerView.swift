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
        Text("""
Choose a date and time between
\(vm.selectedTrashMob!.endSchedulingDate!.addingTimeInterval(864000 / 2).formatted(.dateTime.month().day())) and \(vm.selectedTrashMob!.endSchedulingWindow!.formatted(.dateTime.month().day()))
""")
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
