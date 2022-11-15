//
//  ContentView.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/7/22.
//

import SwiftUI
import Combine

let mainStopwatch = Stopwatch(w: 20.0, tr: 0.15)

struct ContentView: View {
    var body: some View {
        stopwatchBody(sw: mainStopwatch)
    }
}

struct stopwatchBody: View {
    @ObservedObject var sw : Stopwatch
    var body: some View {
        VStack (){
            Group{
                Spacer().frame(height: 200)
                // GROSS COUNTER
                HStack(alignment: .firstTextBaseline){
                    Text(sw.formattedMoney).counterText()
                    Text("GRO").counterClassText()
                }
                // NET COUNTER
                HStack(alignment: .firstTextBaseline){
                    Text(sw.formattedPTMoney).grayCT()
                    Text("NET").grayCCT()
                }
                // ACTION BUTTONS
                HStack(spacing: 35) {
                    Button(action: {sw.leftHandler()}){ Text(sw.leftText).timerButtonText()}.timerButton()
                    Button(action: {sw.reset()}){ Text("RESET").timerButtonText()}.timerButton()
                }
            }
            // TIME AND PROPERTY INDICATOR
            HStack(alignment: .bottom){ Text(sw.formattedTime).timeTicker() }.tickerContainer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


