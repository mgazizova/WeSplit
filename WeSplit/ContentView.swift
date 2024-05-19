//
//  ContentView.swift
//  WeSplit
//
//  Created by Мария Газизова on 19.05.2024.
//

import SwiftUI

struct ContentView: View {
    let students = ["Hermione", "Ron", "Harry", "Sedric"] // not a @State because it is a constant
    @State private var selectedStudent = ""
    @State private var tapCount = 0
    @State private var name = ""
    
    var body: some View {
        Form {
            Button("Tap count: \(tapCount)") {
                tapCount += 1 // doesn't need a $ because it is changed manualy
            }
            TextField("Enter your name", text: $name) // need a $ because it is changed by user, so there sould be an ability to write the updates into @State -- Two-ways binding
            Text("Your name is \(name)") // One-way binding -- only read the value
            
            Picker("Select your student", selection: $selectedStudent) { // Two-ways binding selectedStudent -- can be changed
                ForEach(students, id: \.self) { // id: \.self - to identify views uniquely, strings in students should be unique otherwise there is problems with defining exact element and picking it
                    Text($0)
                }
            }
            
            ForEach(0..<10) { number in
                Text("Row \(number)")
            }
        }
    }
}

struct SafeAreaCheck: View {
    var body: some View {
        NavigationStack { // adds a title + navigation + content inside safe area
            Form {
                Text("Hello world!")
            }
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
    //    SafeAreaCheck()
}
