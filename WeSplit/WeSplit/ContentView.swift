//
//  ContentView.swift
//  WeSplit
//
//  Created by Dokka Syam Prasad on 23/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberofpeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    var total: Double {
        let tipSelection: Double = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let total = (checkAmount + tipValue)
        return total
    }
    var totalPerPerson: Double {
        return total / Double(numberofpeople + 2)
    }
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberofpeople){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                Section("Tip Percentage"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<102){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("After Tip"){
                    Text( total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
                Section("Amount per Person"){
                    Text( totalPerPerson , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }.navigationTitle("WeSplit")
                .toolbar{
                    if amountIsFocused{
                        Button("Done"){
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
