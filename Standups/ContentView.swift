//
//  ContentView.swift
//  Standups
//
//  Created by Paloma St.Clair on 10/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("hey girl 👱🏾‍♀️")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

