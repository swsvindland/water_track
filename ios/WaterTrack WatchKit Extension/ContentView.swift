//
//  ContentView.swift
//  WaterTrack WatchKit Extension
//
//  Created by Sam Svindland on 7/31/22.
//

import SwiftUI

func queryFirebase() {
    
}

struct ContentView: View {
    @State var water = 0.0;
    @State var total = 0.0;
    
    func increment() {
        water += 1 / 10;
        total += 1 / 20;
    }
    
    func decrement() {
        water -= 1 / 10;
        total -= 1 / 20;
    }
    
    var body: some View {
        VStack {
            ProgressView(value: water) {
                Text("Water")
            }
            ProgressView(value: total) {
                Text("Total")
            }
            Button("Add Water", action: increment)
            Button("Remove Water", action: decrement)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
