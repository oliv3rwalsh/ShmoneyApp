//
//  Stopwatch.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import Foundation


// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// REGULAR STOPWATCH IS NO LONGER USED
// USE BACKGROUND STOPWATCH INSTEAD TO SUPPORT APP CLOSURE
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



public class Stopwatch: ObservableObject {
    var secondsElapsed = 0.0
    var running = false
    var wage: Double
    var timer = Timer()
    var taxrate: Double
    @Published var formattedTime = "00:00:00:00 @ $00.00/HOUR (0.00% ETR)"
    @Published var formattedMoney = "$00.00"
    @Published var leftText = "START"
    @Published var formattedPTMoney = "$00.00"
    
    @Published var formattedWage = "00.00"
    @Published var formattedTaxRate = "00.00"
    
    init(w: Double, tr: Double){
        self.wage = w
        self.taxrate = tr
        self.formatWage()
        self.formatTaxRate()
        self.updateFormattedTime()
    }
    
    func leftHandler(){
        if(self.running){
            self.pause()
            self.running = false
        } else {
            self.start()
            self.running = true
        }
    }
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.secondsElapsed += 0.1
            self.updateFormattedTime()
            self.updateFormattedMoney(taxed: true)
            self.updateFormattedMoney(taxed: false)
            self.leftText = "PAUSE"
        }
    }
    func updateFormattedTime(){
        var hours = String(Int(self.secondsElapsed) / 3600)
        var minutes = String((Int(self.secondsElapsed) / 60) % 60)
        var seconds = String(Int(self.secondsElapsed) % 60)
        if(hours.count < 2){
            hours = "0" + hours
        }
        if(minutes.count < 2){
            minutes = "0" + minutes
        }
        if(seconds.count < 2){
            seconds = "0" + seconds
        }
        self.formattedTime = hours + ":" + minutes + ":" + seconds + " @ $" + formattedWage + "/HOUR (" + formattedTaxRate + "% ETR)"
    }
    func updateFormattedMoney(taxed: Bool){
        // figure out current money
        var moneyMade: String
        if(taxed){
            let wageActual = self.wage * (1-self.taxrate)
            let wagePS = wageActual / 3600
            let moneySF = wagePS * self.secondsElapsed
            let roundedMoneySF = round(moneySF * 100) / 100
            // moneyMade = String( round(((self.wage * (1-self.taxrate)) / 3600.0) * self.secondsElapsed * 100) / 100 )
            moneyMade = String(roundedMoneySF)
        } else {
            let wagePS = self.wage / 3600
            let moneySF = wagePS * self.secondsElapsed
            let roundedMoneySF = round(moneySF * 100) / 100
            // moneyMade = String(round((self.wage / 3600.0) * self.secondsElapsed * 100) / 100)
            moneyMade = String(roundedMoneySF)
        }
        // formatting
        let parts = moneyMade.components(separatedBy: ".")
        var dollars = parts[0]
        var cents = parts[1]
        if(dollars.count < 2){ dollars = "0" + dollars }
        if(cents.count < 2){ cents = cents + "0"}
        // set to instance variables
        if(taxed){
            self.formattedPTMoney = "$" + dollars + "." + cents
        } else {
            self.formattedMoney = "$" + dollars + "." + cents
        }
    }
    func pause(){
        timer.invalidate()
        running = false
        self.leftText = "RESUME"
    }
    func reset(){
        timer.invalidate()
        running = false
        secondsElapsed = 0.0
        updateFormattedTime()
        updateFormattedMoney(taxed: true)
        updateFormattedMoney(taxed: false)
        self.leftText = "START"
    }
    func incWage(step: Double){
        self.wage = Double(round((self.wage + step) * 100) / 100)
        self.reset()
        self.formatWage()
        self.updateFormattedTime()
    }
    func decWage(step: Double){
        if(self.wage > 0.25){
            self.wage = Double(round((self.wage - step) * 100) / 100)
            self.reset()
            self.formatWage()
            self.updateFormattedTime()
        }
    }
    func incTR(step: Double){
        self.taxrate = Double(round((self.taxrate + step) * 10000) / 10000)
        self.reset()
        self.formatTaxRate()
        self.updateFormattedTime()
    }
    func decTR(step: Double){
        if(self.taxrate > 0.0 && self.taxrate < 1.0){
            self.taxrate = Double(round((self.taxrate - step) * 10000) / 10000)
            self.reset()
            self.formatTaxRate()
            self.updateFormattedTime()
        }
    }
    func formatWage(){
        let w = String(self.wage)
        let wageParts = w.description.components(separatedBy: ".")
        var dollars = wageParts[0]
        var cents = wageParts[1]
        if(dollars.count < 2){
            dollars = "0" + dollars
        }
        if(cents.count < 2){
            cents = cents + "0"
        }
        self.formattedWage = dollars + "." + cents
    }
    func formatTaxRate(){
        let tr = String(self.taxrate * 100)
        let taxParts = tr.components(separatedBy: ".")
        var per = taxParts[0]
        var dec = taxParts[1]
        if(per.count < 2){
            per = "0" + per
        }
        if(dec.count < 2){
            dec = dec + "0"
        } else if(dec.count > 2){
            dec = String(dec.prefix(2)) // fix rounding issue
            let dd = Double(dec) ?? 0
            dec = String(round(dd / 5.0) * 5) // round to nearest five (fix rounding issue)
            dec = dec.components(separatedBy: ".")[0]
            if(dec.count < 2){
                dec = "0" + dec
            }
        }
        
        self.formattedTaxRate = per + "." + dec
    }
}

//struct stopwatchBody: View {
//    @ObservedObject var sw : Stopwatch
//    var body: some View {
//        VStack (){
//            Group{
//                Spacer().frame(height: 200)
//                // GROSS COUNTER
//                HStack(alignment: .firstTextBaseline){
//                    Text(sw.formattedMoney).counterText()
//                    Text("GRO").counterClassText()
//                }
//                // NET COUNTER
//                HStack(alignment: .firstTextBaseline){
//                    Text(sw.formattedPTMoney).grayCT()
//                    Text("NET").grayCCT()
//                }
//                // ACTION BUTTONS
//                HStack(spacing: 35) {
//                    Button(action: {sw.leftHandler()}){ Text(sw.leftText).timerButtonText()}.timerButton()
//                    Button(action: {sw.reset()}){ Text("RESET").timerButtonText()}.timerButton()
//                }
//            }
//            // TIME AND PROPERTY INDICATOR
//            HStack(alignment: .bottom){ Text(sw.formattedTime).timeTicker() }.tickerContainer()
//        }
//    }
//}
