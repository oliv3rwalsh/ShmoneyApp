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
    @ObservedObject var kh = KeyboardHandler(dko: "00")
    @ObservedObject var msw = mainStopwatch
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text("DOLLARS")
                Text(kh.keyedOutput).counterText()
            }
            HStack{
                Image(systemName: "arrow.down").font(.system(size: 30))
            }
            VStack{
                HStack{
                    VStack{
                        Text(ch(a: kh.keyedOutputInt, w: msw.wage, tr: msw.taxrate, h: true)).counterText()
                            .padding(0)
                        Text("HOURS")
                    }
                    VStack{
                        Text(ch(a: kh.keyedOutputInt, w: msw.wage, tr: msw.taxrate, h: false)).grayCT()
                            .padding(0)
                        Text("MINS").foregroundColor(Color(.gray))
                    }
                }
            }
            Spacer()
            Keyboard(kh: kh)
            Spacer()
        }
    }
}

struct HourCalculator_Previews: PreviewProvider {
    static var previews: some View {
        HourCalculator()
    }
}

struct Keyboard: View {
    @ObservedObject var kh : KeyboardHandler
    var body: some View{
        VStack{
            HStack{
                Button(action: {kh.keyPressed(k: 1)}){ Text("1").keyboardText() }.keyboardButton()
                Button(action: {kh.keyPressed(k: 2)}){ Text("2").keyboardText() }.keyboardButton()
                Button(action: {kh.keyPressed(k: 3)}){ Text("3").keyboardText() }.keyboardButton()
            }
            HStack{
                Button(action: {kh.keyPressed(k: 4)}){ Text("4").keyboardText() }.keyboardButton()
                Button(action: {kh.keyPressed(k: 5)}){ Text("5").keyboardText() }.keyboardButton()
                Button(action: {kh.keyPressed(k: 6)}){ Text("6").keyboardText() }.keyboardButton()
            }
            HStack{
                Button(action: {kh.keyPressed(k: 7)}){ Text("7").keyboardText() }.keyboardButton()
                Button(action: {kh.keyPressed(k: 8)}){ Text("8").keyboardText() }.keyboardButton()
                Button(action: {kh.keyPressed(k: 9)}){ Text("9").keyboardText() }.keyboardButton()
            }
            HStack{
                Button(action: {kh.clear()}){ Image(systemName: "trash").keyboardImage()}.keyboardButton().font(.system(size: 30))
                Button(action: {kh.keyPressed(k: 0)}){ Text("0").keyboardText() }.keyboardButton()
                Button(action: {kh.backspace()}){ Image(systemName: "delete.left").keyboardImage()}.keyboardButton().font(.system(size: 30))
            }
        }
    }
}

func ch(a: Int, w: Double, tr: Double, h: Bool) -> String{
    let hoursNeeded = Double(a) / (w * (1 - tr))
    let partialHours = hoursNeeded.truncatingRemainder(dividingBy: 1)
    let fullHours = hoursNeeded - partialHours
    let minutesNeeded = partialHours * 60
    if(h){
        if(String(Int(fullHours)).count < 2){
            return ("0" + String(Int(fullHours)))
        } else {
            return String(Int(fullHours))
        }
    } else {
        if(String(Int(minutesNeeded)).count < 2){
            return ("0" + String(Int(minutesNeeded)))
        } else {
            return String(Int(minutesNeeded))
        }
    }
}
