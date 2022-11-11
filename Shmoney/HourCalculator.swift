//
//  HourCalculator.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import SwiftUI

struct HourCalculator: View {
    @State private var inHours: String = ""
    var body: some View {
        VStack(spacing: 0){
            VStack{
                Text("HOURS")
                TextField("", text: $inHours)
            }.hoursField()
            VStack{
                Text("MONEY")
                TextField("", text: $inHours)
            }.moneyField()
        }
    }
}

struct HourCalculator_Previews: PreviewProvider {
    static var previews: some View {
        HourCalculator()
    }
}
