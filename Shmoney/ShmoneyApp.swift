//
//  ShmoneyApp.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import SwiftUI

@main
struct ShmoneyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem{
                        Image(systemName: "stopwatch")
                    }
                HourCalculator()
                    .tabItem{
                        Image(systemName: "repeat")
                    }
                TaxCalculator()
                    .tabItem{
                        Image(systemName: "building.columns")
                    }
            }.accentColor(Color(.black))
        }
    }
}
