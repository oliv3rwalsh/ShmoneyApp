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
                Text("HOURLY WAGE").headerText()
                HStack{
                    Spacer()
                    Button(action: {msw.modifyWage(amount: -0.25)}){
                        Image(systemName: "minus.square").font(.system(size: 35))
                    }
                    Spacer()
                    let w = String(msw.formatMoneyAmount(amt: msw.hourlyWage, symbol: "$"))
                    Text(w).counterText()
                    Spacer()
                    Button(action: {msw.modifyWage(amount: 0.25)}){
                        Image(systemName: "plus.square").font(.system(size: 35))
                    }
                    Spacer()
                }.accentColor(Color(.black))
            }
            Spacer()
            VStack{
                Text("EFFECTIVE TAX RATE").headerText()
                HStack{
                    Spacer()
                    Button(action: {msw.modifyTaxRate(amount: -0.0005)}){
                        Image(systemName: "minus.square").font(.system(size: 35))
                    }
                    Spacer()
                    let tr = String(msw.formatMoneyAmount(amt: (msw.effectiveTaxRate * 100), symbol: "%"))
                    Text(tr).counterText()
                    Spacer()
                    Button(action: {msw.modifyTaxRate(amount: 0.0005)}){
                        Image(systemName: "plus.square").font(.system(size: 35))
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
