//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Greeson on 7/17/25.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    
    @State private var checkAmount: Double  = 0.0
    @State private var numPeople: Int = 2
    @State private var tipPercentage: Double = 0.20
    @FocusState private var amountIsFocused: Bool
    let currencyCode: String = Locale.current.currency?.identifier ?? "USD"
    let tipPercentages: [Double] = [0.10, 0.15, 0.20, 0.25]
    var totalPerPerson: Double {
        let totalBill = checkAmount + (checkAmount * tipPercentage)
        
        return totalBill / Double(numPeople)
    }
    var body: some View {
        NavigationStack {
           
            Form {
                TextField("Amount", value: $checkAmount, format: .currency(code: (Locale.current.currency?.identifier ?? "USD")))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                Picker("Num People", selection: $numPeople){
                  ForEach(2...10, id: \.self){
                      Text("\($0) People")
                        
                    }
                }.pickerStyle(.navigationLink)
              
                
                }
            .navigationTitle(Text("WeSplit"))
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
         
            }
        Section("Tip: "){
            Picker("Tip Percentage", selection: $tipPercentage){
                ForEach(tipPercentages, id: \.self){
                    Text($0, format: .percent)
                }
            }
            .pickerStyle(.segmented)
        }
        Section ("Each Pay"){
              Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
        }
    }

#Preview {
    ContentView()
}
