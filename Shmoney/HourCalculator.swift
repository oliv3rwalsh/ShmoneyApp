//
//  HourCalculator.swift
//  Shmoney
//
//  Created by Oliver Walsh on 11/8/22.
//

import SwiftUI

struct HourCalculator: View {
    @State private var inHours: String = ""
    var body: some View {
        Text("Hour Calculator")
    }
}

struct HourCalculator_Previews: PreviewProvider {
    static var previews: some View {
        HourCalculator()
    }
}
