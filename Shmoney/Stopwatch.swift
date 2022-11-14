//
//  Stopwatch.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import Foundation

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
    
    init(w: Double, tr: Double){
        self.wage = w
        self.taxrate = tr
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
        self.formattedTime = hours + ":" + minutes + ":" + seconds + " @ $" +
        String(round(self.wage * 100)/100) + "0/HOUR (" + String(Double(round(self.taxrate * 1000) / 10)) + "% ETR)"
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
    func incWage(){
        self.wage = Double(round((self.wage + 0.25) * 100) / 100)
        self.reset()
    }
    func decWage(){
        self.wage = Double(round((self.wage - 0.25) * 100) / 100)
        self.reset()
    }
    func incTR(){
        self.taxrate = Double(round((self.taxrate + 0.001) * 1000) / 1000)
        self.reset()
    }
    func decTR(){
        self.taxrate = Double(round((self.taxrate - 0.001) * 1000) / 1000)
        self.reset()
    }
}
