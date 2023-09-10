//
//  Fetch_TakeawayApp.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import SwiftUI

@main
struct Fetch_TakeawayApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MealListView()
            }
        }
    }
}
