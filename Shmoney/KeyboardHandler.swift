//
//  KeyboardHandler.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/15/22.
//

import Foundation

public class KeyboardHandler: ObservableObject {
    @Published var keyedOutput: String
    @Published var keyedOutputInt: Int
    init(dko: String){
        self.keyedOutput = dko
        self.keyedOutputInt = Int(dko) ?? 0
    }
    func keyPressed(k: Int){
        if(self.keyedOutput.count < 4){
            self.keyedOutputInt = self.keyedOutputInt * 10
            self.keyedOutputInt = self.keyedOutputInt + k
            self.keyedOutput = String(self.keyedOutputInt)
            self.formatKeyedOutput()
        }
    }
    func backspace(){
        if(self.keyedOutputInt != 0){
            self.keyedOutputInt = self.keyedOutputInt - (self.keyedOutputInt % 10)
            self.keyedOutputInt = self.keyedOutputInt / 10
        }
        self.keyedOutput = String(self.keyedOutputInt)
        self.formatKeyedOutput()
    }
    func clear(){
        self.keyedOutputInt = 0
        self.keyedOutput = String(self.keyedOutputInt)
        self.formatKeyedOutput()
    }
    func formatKeyedOutput(){
        if(self.keyedOutput.count < 2){
            self.keyedOutput = String(repeating: "0", count: (2 - keyedOutput.count)) + self.keyedOutput
        }
    }
}
