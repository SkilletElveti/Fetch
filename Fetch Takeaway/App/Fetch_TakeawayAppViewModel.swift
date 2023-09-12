//
//  Fetch_TakeawayAppViewModel.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation
import Combine

struct Fetch_TakeawayAppViewState {
    var lostInternet: Bool = false
}

class Fetch_TakeawayAppViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    @Published
    var state = Fetch_TakeawayAppViewState()
    init() {
        HttpApiService.shared.networkPublisher
            .receive(on: DispatchQueue.main).sink { [weak self] isInternetAvailable in
                guard let self else { return }
                self.state.lostInternet = isInternetAvailable
            }
            .store(in: &subscriptions)
    }
}
