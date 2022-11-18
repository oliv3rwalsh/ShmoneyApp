//
//  ContentView.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/7/22.
//

import SwiftUI
import Combine

let mainStopwatch = BackgroundStopwatch(w: 20.0, etr: 0.15)

struct ContentView: View {
    var body: some View {
        // stopwatchBody(sw: mainStopwatch)
        backgroundStopwatchBody(sw: mainStopwatch)
    }
}

struct backgroundStopwatchBody: View {
    @ObservedObject var sw : BackgroundStopwatch
    var body: some View {
        VStack{
            Spacer().frame(height: 200)
            VStack{
                // Gross Counter
                HStack(alignment: .firstTextBaseline){
                    Text(sw.grossMoneyAmount).counterText()
                    Text("GRO").counterClassText()
                }
                // Net Counter
                HStack(alignment: .firstTextBaseline){
                    Text(sw.netMoneyAmount).grayCT()
                    Text("NET").grayCCT()
                }
                // Action Buttons
                HStack(spacing: 35){
                    Button(action: {sw.leftButtonHandler()}){ Text(sw.leftButtonText).timerButtonText()}.timerButton()
                    Button(action: {sw.reset()}){ Text("RESET").timerButtonText()}.timerButton()
                }
            }
            // TIME AND PROPERTY INDICATOR
            HStack{ Text(sw.bottomBarText).timeTicker() }.tickerContainer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


