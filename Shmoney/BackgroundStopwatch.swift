//
//  BackgroundStopwatch.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/17/22.
//

import Foundation

public class BackgroundStopwatch: ObservableObject {
    var hourlyWage: Double
    var effectiveTaxRate: Double
    var running = false
    
    var timeStartedHour = 0
    var timeStartedMinute = 0
    var timeStartedSecond = 0
    var timeStartedNanosecond = 0
    
    var hoursElapsed = 0.0
    var hoursElapsedBeforePause = 0.0
    
    var timer = Timer()
    
    @Published var grossMoneyAmount = "$00.00"
    @Published var netMoneyAmount = "$00.00"
    
    @Published var bottomBarText = "TEST"
    
    @Published var leftButtonText = "START"
    
    init(w: Double, etr: Double){
        self.hourlyWage = w
        self.effectiveTaxRate = etr
        updateBottomBar()
        run()
    }
    
    func updateTimeStarted(){
        let date = Date()
        let calendar = Calendar.current
        self.timeStartedHour = calendar.component(.hour, from: date)
        self.timeStartedMinute = calendar.component(.minute, from: date)
        self.timeStartedSecond = calendar.component(.second, from: date)
        self.timeStartedNanosecond = calendar.component(.nanosecond, from: date)
    }
    
    func updateHoursElapsed(){
        let date = Date()
        let calendar = Calendar.current
        var changeInHours = Double(calendar.component(.hour, from: date) - timeStartedHour)
        changeInHours += Double(calendar.component(.minute, from: date) - timeStartedMinute) / 60.0
        changeInHours += Double(calendar.component(.second, from: date) - timeStartedSecond) / 3600.0
        changeInHours += Double(calendar.component(.nanosecond, from: date) - timeStartedNanosecond) / 3600000000000.0
        self.hoursElapsed = changeInHours + hoursElapsedBeforePause
    }
    
    func run(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in self.ticked()}
    }
    
    func ticked(){
        if(running){
            updateHoursElapsed()
            updateMoneyAmount()
            updateBottomBar()
        }
    }
    
    func updateMoneyAmount(){
        self.grossMoneyAmount = formatMoneyAmount(amt: (self.hourlyWage * self.hoursElapsed), symbol: "$")
        self.netMoneyAmount = formatMoneyAmount(amt: (self.hourlyWage * self.hoursElapsed * (1 - self.effectiveTaxRate)), symbol: "$")
    }
    
    func formatMoneyAmount(amt: Double, symbol: String) -> String{
        let truncatedAmount = Double(round(amt * 100)) / 100.0
        let stringTA = String(truncatedAmount)
        let parts = stringTA.components(separatedBy: ".")
        var dollars = parts[0]
        if(dollars.count < 2){
            dollars = "0" + dollars
        }
        var cents = parts[1]
        if(cents.count < 2){
            cents = cents + "0"
        }
        if(symbol != "%"){
            return symbol + dollars + "." + cents
        }
        return dollars + "." + cents + symbol
    }
    
    func start(){
        self.running = true
        self.leftButtonText = "PAUSE"
        updateTimeStarted()
    }
    
    func pause(){
        self.running = false
        self.leftButtonText = "RESUME"
        hoursElapsedBeforePause = hoursElapsed
    }
    
    func reset(){
        self.running = false
        self.leftButtonText = "START"
        hoursElapsedBeforePause = 0
        hoursElapsed = 0
        updateMoneyAmount()
    }
    
    func leftButtonHandler(){
        if(running){
            self.pause()
        } else {
            self.start()
        }
    }
    
    func updateBottomBar(){
        let h = Int(hoursElapsed - hoursElapsed.truncatingRemainder(dividingBy: 1))
        let m = Int((hoursElapsed * 60) - (hoursElapsed * 60).truncatingRemainder(dividingBy: 1))
        let s = Int((hoursElapsed * 3600) - (hoursElapsed * 3600).truncatingRemainder(dividingBy: 1))
        var fh = String(h)
        var fm = String(m)
        var fs = String(s)
        if(fh.count < 2){
            fh = "0" + fh
        }
        if(fm.count < 2){
            fm = "0" + fm
        }
        if(fs.count < 2){
            fs = "0" + fs
        }
        self.bottomBarText = fh + ":" + fm + ":" + fs + " @ " + formatMoneyAmount(amt: hourlyWage, symbol: "$") + "/HOUR (" + formatMoneyAmount(amt: (effectiveTaxRate * 100), symbol: "%") + " ETR)"
    }
    
    func modifyWage(amount: Double){
        self.hourlyWage = self.hourlyWage + amount
        self.reset()
        self.updateBottomBar()
    }
    
    func modifyTaxRate(amount: Double){
        self.effectiveTaxRate = self.effectiveTaxRate + amount
        self.reset()
        self.updateBottomBar()
    }
}
