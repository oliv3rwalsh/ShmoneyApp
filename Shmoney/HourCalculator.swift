//
//  HourCalculator.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import SwiftUI

struct HourCalculator: View {
    @State private var moneyQNT: String = ""
    @State private var hourQNT: String = ""
    var body: some View {
        VStack{
            Section(header: Text("Hours").font(.headline)) {
                TextField("", text: $hourQNT).conversionField()
            }
            
            //TextField("Hours", text: $hourQNT).conversionField()
            //TextField("Money", text: $moneyQNT).conversionField()
        }
    }
}

struct HourCalculator_Previews: PreviewProvider {
    static var previews: some View {
        HourCalculator()
    }
}
