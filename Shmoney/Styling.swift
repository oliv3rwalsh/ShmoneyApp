//
//  Styling.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import Foundation
import SwiftUI

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let shmoneyGreen = Color("ShmoneyGreen")
}

extension Text {
    func settingsText() -> some View {
        self.font(.custom(
            "Futura",
            size: 70
        ))
    }
    func topBarText() -> some View {
        self.font(.custom(
            "Futura",
            size: 20
        ))
        .foregroundColor(Color.white)
        .padding(20)
    }
    func settingsHeaderText() -> some View {
        self.font(.custom(
            "Futura",
            size: 15
        ))
    }
    func keyboardText() -> some View {
        self.font(.custom(
            "Futura",
            size: 45
        ))
    }
    func counterText () -> some View {
        self.font(.custom(
            "Futura",
            size: 80
        ))
    }
    func headerText () -> some View {
        self.font(.custom(
            "Futura",
            size: 20
        ))
    }
    func counterClassText () -> some View {
        self.font(.custom(
            "Futura",
            size: 10
        ))
    }
    func grayCT() -> some View {
        self.foregroundColor(.gray)
            .counterText()
    }
    func grayCCT() -> some View {
        self.foregroundColor(.gray)
            .counterClassText()
    }
    func timerButtonText() -> some View {
        self.font(.custom(
            "Futura",
            size: 14
        ))
        .foregroundColor(.white)
        .padding()
        .frame(width: 100, height: 45)
    }
    func timeTicker() -> some View {
        self.font(.custom("Futura", size: 14))
        .foregroundColor(.gray)
        .onTapGesture {
            print("Tapped")
        }
    }
}

extension Button {
    func timerButton() -> some View {
        self.background(Color("ShmoneyGreen"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    func keyboardButton() -> some View {
        self.frame(width: 50, height: 50)
            .foregroundColor(Color(.black))
    }
}

extension HStack {
    func tickerContainer() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 50)
    }
    func topBar() -> some View {
        self.background(Color("ShmoneyGreen"))
            .foregroundColor(Color(.white))
            .frame(height: 30)
    }
}

extension VStack{
    func hoursField() -> some View {
        self.background(Color(.gray))
            .frame(maxWidth: 300)
            .padding(.bottom, 20)
            .cornerRadius(20)
            .padding(.bottom, -20)
            .shadow(color: .gray, radius: 15, x: 0, y: 0)
    }
    func moneyField() -> some View{
        self.background(Color(.white))
            .frame(maxWidth: 300)
            .padding(.top, 20)
            .cornerRadius(20)
            .padding(.top, -20)
            .shadow(color: .gray, radius: 15, x: 0, y: 0)
    }
}

extension TextField{
    func conversionField() -> some View {
        self.background(Color(.black))
            .font(.custom("Futura", size: 28))
            .foregroundColor(Color(.white))
            .frame(width: 200)
    }
}

extension Image{
    func keyboardImage() -> some View {
        self.frame(width: 35, height: 35)
    }
}
