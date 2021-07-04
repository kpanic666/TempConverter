//
//  ContentView.swift
//  TempConverter
//
//  Created by Andrei Korikov on 11.03.2021.
//

import SwiftUI

enum TempScales: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var inValue = "0"
    @State private var outScale = 1
    @State private var inScale = 0
    
    var scales: [String] {
        var tempScale = [String]()
        
        for scale in TempScales.allCases {
            tempScale.append(scale.rawValue)
        }
        
        return tempScale
    }
    
    var outValue: Double {
        var midValueInCelsius = 0.0
        let inValueNum = Double(inValue) ?? 0.0
        let kelvinMagicNum = 273.15
        let fahrenheitMagicNum: Double = 32
        
        switch scales[inScale] {
        case TempScales.fahrenheit.rawValue:
            midValueInCelsius = (inValueNum - fahrenheitMagicNum) * 5 / 9
        case TempScales.kelvin.rawValue:
            midValueInCelsius = inValueNum - kelvinMagicNum
        default:
            midValueInCelsius = inValueNum
        }
        
        switch scales[outScale] {
        case TempScales.fahrenheit.rawValue:
            return (midValueInCelsius * 9 / 5) + fahrenheitMagicNum
        case TempScales.kelvin.rawValue:
            return midValueInCelsius + kelvinMagicNum
        default:
            return midValueInCelsius
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input temperature", text: $inValue)
                        .keyboardType(.decimalPad)
                    
                    Picker("Choose input scale", selection: $inScale, content: {
                        ForEach(0 ..< scales.count) {
                            Text(scales[$0])
                        }
                    })
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Choose output scale:")) {
                    Picker("Choose output scale", selection: $outScale, content: {
                        ForEach(0 ..< scales.count) {
                            Text(scales[$0])
                        }
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Result: \(outValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Temp Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
