//
//  ContentView.swift
//  petter-test
//
//  Created by Petter Kalrsson on 2024-01-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Circle()
                .fill(.blue)
                .padding(50)
                .overlay(
                        Image(systemName: "figure.archery")
                    )

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
