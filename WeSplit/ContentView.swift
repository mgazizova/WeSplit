//
//  ContentView.swift
//  WeSplit
//
//  Created by Мария Газизова on 19.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * tipSelection / 100
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return total / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount, // Two-ways binding
                        format: .currency(code: Locale.current.currency?.identifier ?? "EUR") // Locale tracks your location
                    )
                    .keyboardType(.decimalPad) // number + decimal point
                    .focused($amountIsFocused)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Tips in another screen", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people") // default value is 4 people because numberOfPeople value is an index of forEach range
                        }
                    }
                    .pickerStyle(.menu) // for .navigationLink style should be included to the NavigationStack
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                
                Section("Total") {
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .green) // conditional modifier
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {  // helps to specify toolbar items
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
