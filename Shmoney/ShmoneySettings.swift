//
//  ShmoneySettings.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/14/22.
//

import SwiftUI

struct ShmoneySettings: View {
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            VStack{
                Text("HOURLY WAGE ($)").headerText()
                HStack{
                    Spacer()
                    Button(action: {mainStopwatch.decWage()}){
                        Image(systemName: "minus.square")
                    }
                    Spacer()
                    let w = String(mainStopwatch.wage)
                    Text(w).counterText()
                    Spacer()
                    Button(action: {mainStopwatch.incWage()}){
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
                    Button(action: {mainStopwatch.decTR()}){
                        Image(systemName: "minus.square")
                    }
                    Spacer()
                    let tr = String(mainStopwatch.taxrate * 100)
                    Text(tr).counterText()
                    Spacer()
                    Button(action: {mainStopwatch.incTR()}){
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
