//
//  ContentView.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            Task {
                do {
                    try await HttpApiService.shared.perform(get: .meals("Dessert"))
                } catch {
                    GeneralisedLogger.log(error: "Error: \(error)")
                }
                
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
