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
            HStack{
                Spacer()
                Text("SETTINGS").topBarText()
                Spacer()
            }.topBar()
            VStack{
                Spacer()
                Spacer()
                VStack{
                    Text("HOURLY WAGE").settingsHeaderText()
                    HStack{
                        Spacer()
                        VStack{
                            Button(action: {msw.modifyWage(amount: -0.25)}){
                                Image(systemName: "arrowtriangle.backward.circle").font(.system(size: 25))
                            }
                            Spacer().frame(height: 10)
                            Button(action: {msw.modifyWage(amount: -1.00)}){
                                Image(systemName: "backward.circle").font(.system(size: 25))
                            }
                        }
                        Spacer()
                        let w = String(msw.formatMoneyAmount(amt: msw.hourlyWage, symbol: "$"))
                        Text(w).settingsText()
                        Spacer()
                        VStack{
                            Button(action: {msw.modifyWage(amount: 0.25)}){
                                Image(systemName: "arrowtriangle.forward.circle").font(.system(size: 25))
                            }
                            Spacer().frame(height: 10)
                            Button(action: {msw.modifyWage(amount: 1.00)}){
                                Image(systemName: "forward.circle").font(.system(size: 25))
                            }
                        }
                        Spacer()
                    }.accentColor(Color(.black))
                }
                Spacer()
                VStack{
                    Text("EFFECTIVE TAX RATE").settingsHeaderText()
                    HStack{
                        Spacer()
                        VStack{
                            Button(action: {msw.modifyTaxRate(amount: -0.0005)}){
                                Image(systemName: "arrowtriangle.backward.circle").font(.system(size: 25))
                            }
                            Spacer().frame(height: 10)
                            Button(action: {msw.modifyTaxRate(amount: -0.0025)}){
                                Image(systemName: "backward.circle").font(.system(size: 25))
                            }
                        }
                        Spacer()
                        let tr = String(msw.formatMoneyAmount(amt: (msw.effectiveTaxRate * 100), symbol: "%"))
                        Text(tr).settingsText()
                        Spacer()
                        VStack{
                            Button(action: {msw.modifyTaxRate(amount: 0.0005)}){
                                Image(systemName: "arrowtriangle.forward.circle").font(.system(size: 25))
                            }
                            Spacer().frame(height: 10)
                            Button(action: {msw.modifyTaxRate(amount: 0.0025)}){
                                Image(systemName: "forward.circle").font(.system(size: 25))
                            }
                        }
                        Spacer()
                    }.accentColor(Color(.black))
                }
                Spacer()
                Spacer()
            }
        }
        
    }
}

struct ShmoneySettings_Previews: PreviewProvider {
    static var previews: some View {
        ShmoneySettings()
    }
}
