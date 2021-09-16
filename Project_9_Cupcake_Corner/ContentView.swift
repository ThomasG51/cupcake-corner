//
//  ContentView.swift
//  Project_9_Cupcake_Corner
//
//  Created by Thomas George on 16/09/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order: Order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle("Special Request", isOn: $order.isSpecialRequest.animation())
                    
                    if order.isSpecialRequest {
                        Toggle("Extra Frosting", isOn: $order.isExtraFrosting)
                        Toggle("Add Sprinkles", isOn: $order.isAddSprinkles)
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                            Text("Delivery details")
                        }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
