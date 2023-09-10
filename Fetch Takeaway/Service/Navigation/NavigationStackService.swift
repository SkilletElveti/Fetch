//
//  NavigationStackService.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/10/23.
//

import Foundation
import SwiftUI

class NavigationStackService {
    static let shared = NavigationStackService()
    @Binding var path: NavigationPath
    init(
    ) {
        _path = Binding.constant(NavigationPath())
    }
    public func addPath(path: Binding<NavigationPath>) {
        _path = path
    }
    public func navigation(
        push viewModel: any Hashable
    ) {
        self.path.append(viewModel)
    }
    
    public func navigationPop() {
        if !(path.isEmpty) {
            self.path.removeLast()
        }
    }
}
