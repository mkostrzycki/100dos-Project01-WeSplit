//
//  ContentView.swift
//  WeSplit
//
//  Created by MaćKo on 25/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0 // first option of range 2..<100
    @State private var tipPercentage = 20

    @FocusState private var amountIsFocused: Bool

    var totalAmount: Double {
        let tipPercentageSelection = Double(tipPercentage) / 100
        let tipValue = tipPercentageSelection * checkAmount

        return checkAmount + tipValue
    }

    var totalPerPerson: Double {
        let peopleCountOptionShift = 2 // option index is shifted by 2 from option value
        let peopleCount = Double(numberOfPeople + peopleCountOptionShift)

        return totalAmount / peopleCount
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(1...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Total amount including \(tipPercentage)% tip") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section("Amount per person including \(tipPercentage)% tip") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
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
