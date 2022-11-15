//
//  ShmoneySettings.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/14/22.
//

import SwiftUI

struct ShmoneySettings: View {
    @ObservedObject var msw = mainStopwatch
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            VStack{
                Text("HOURLY WAGE ($)").headerText()
                HStack{
                    Spacer()
                    Button(action: {msw.decWage(step: 0.25)}){
                        Image(systemName: "minus.square")
                    }
                    Spacer()
                    let w = String(msw.formattedWage)
                    Text(w).counterText()
                    Spacer()
                    Button(action: {msw.incWage(step: 0.25)}){
                        Image(systemName: "plus.square")
                    }
                    Spacer()
                }.accentColor(Color(.black))
            }
            Spacer()
            VStack{
                Text("EFFECTIVE TAX RATE (%)").headerText()
                HStack{
                    Spacer()
                    Button(action: {msw.decTR(step: 0.0005)}){
                        Image(systemName: "minus.square")
                    }
                    Spacer()
                    let tr = String(msw.formattedTaxRate)
                    Text(tr).counterText()
                    Spacer()
                    Button(action: {msw.incTR(step: 0.0005)}){
                        Image(systemName: "plus.square")
                    }
                    Spacer()
                }.accentColor(Color(.black))
            }
            Spacer()
            Spacer()
        }
    }
}

struct ShmoneySettings_Previews: PreviewProvider {
    static var previews: some View {
        ShmoneySettings()
    }
}
