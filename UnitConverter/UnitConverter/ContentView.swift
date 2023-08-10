//
//  ContentView.swift
//  UnitConverter
//
//  Created by Enrico Postolov on 10/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit: String = "m"
    @State private var outputUnit: String = "m"
    @State private var inputValue: Double = 0.0
    var units: [String] = ["m", "km", "yd", "ft", "mi"]
    

    var outputValue: Double {
        var currentValue: Double = getInputInMeters(inputUnit: inputUnit, inputValue: inputValue)
        
        var result = convertValue(outputUnit: outputUnit, inputValue: currentValue)
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Input unit section
                Section {
                    Picker("Input unit",
                           selection: $inputUnit) {
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select an input unit")
                }
                
                // Output unit section
                Section {
                    Picker("Output unit",
                           selection: $outputUnit) {
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select an output unit")
                }
                
                // Input value
                Section {
                    TextField("Input value",
                              value: $inputValue,
                              format: .number
                    )
                    .keyboardType(.decimalPad)
                } header: {
                    Text("Value to convert")
                }
                
                // Converted value
                Section {
                    Text(outputValue.formatted())
                    
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("My Unit Converter")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getInputInMeters(inputUnit: String, inputValue: Double) -> Double {
    var currentValue: Double = inputValue
    
    switch inputUnit {
    case "km":
        currentValue = currentValue * 1000
    case "yd":
        currentValue = currentValue / 1.09361
    case "ft":
        currentValue = currentValue / 3.28084
    case "mi":
        currentValue = currentValue / 0.000621371
    default:
        break
    }
    
    return currentValue
}

func convertValue(outputUnit: String, inputValue: Double) -> Double {
    var currentResult: Double = inputValue
    
    switch outputUnit {
    case "km":
        currentResult = inputValue / 1000
    case "yd":
        currentResult = inputValue * 1.09361
    case "ft":
        currentResult = inputValue * 3.28084
    case "mi":
        currentResult = inputValue * 0.000621371
    default:
        break
    }
    
    return currentResult
}
