//
//  ContentView.swift
//  petter-test
//
//  Created by Petter Kalrsson on 2024-01-24.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [String] = []
    @State private var newTask: String = ""
    @State private var inputLabel: String = "Skriv en skitkorv..."
    @State private var buttonLabel: String = "Lägg till"

    var body: some View {
        VStack {
            Image(systemName: "backward")
                .imageScale(.large)
                .foregroundStyle(.tint)

            TextField(inputLabel, text: $newTask)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                if !newTask.isEmpty {
                    tasks.append(newTask)
                    newTask = ""
                }
            }) {
                Text(buttonLabel)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Text(tasks[index])
                        Spacer()
                        Button(action: {
                            removeTask(at: index)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }

    private func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
