//
//  Styling.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import Foundation
import SwiftUI

extension Text {
    func counterText () -> some View {
        self.font(.custom(
            "Futura",
            size: 80
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
        self.background(Color(.black))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension HStack {
    func tickerContainer() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
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
