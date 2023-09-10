//
//  Fetch_TakeawayApp.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import SwiftUI

@main
struct Fetch_TakeawayApp: App {
    @State var path: NavigationPath = NavigationPath()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                MealListView()
                    .navigationDestination(for: MealDetailLink.self, destination: { dataLink in
                        MealDetailView()
                            .environmentObject(dataLink.viewModel)
                    })
            }
            .onAppear {
                NavigationStackService.shared.addPath(path: $path)
            }
        }
    }
}
