//
//  Fetch_TakeawayApp.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/9/23.
//

import SwiftUI
import AlertToast
@main
struct Fetch_TakeawayApp: App {
    @State var path: NavigationPath = NavigationPath()
    @StateObject
    var viewModel = Fetch_TakeawayAppViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                MealListView()
                    .navigationDestination(for: MealDetailLink.self, destination: { dataLink in
                        MealDetailView()
                            .environmentObject(dataLink.viewModel)
                    })
            }.toast(isPresenting: $viewModel.state.lostInternet, alert: {
                AlertToast(displayMode: .banner(.pop), type: .regular, title: "Error", subTitle: "Internet Lost", style: .style(subTitleFont: .system(size: 12)))
            })
            .onAppear {
                NavigationStackService.shared.addPath(path: $path)
            }.onChange(of: viewModel.state.lostInternet) { newValue in
                if newValue {
                    GeneralisedLogger.log(
                        debug: "Internet Lost",
                        filter: "Fetch_TakeawayApp"
                    )
                }
            }
        }
    }
}
