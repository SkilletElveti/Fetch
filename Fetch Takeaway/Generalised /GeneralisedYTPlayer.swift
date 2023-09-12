//
//  GeneralisedYTPlayer.swift
//  Fetch Takeaway
//
//  Created by Shubham Kamdi on 9/11/23.
//

import SwiftUI

import YouTubePlayerKit

struct GeneralisedYTPlayer: View {

    let youTubePlayer: YouTubePlayer

    var body: some View {
        YouTubePlayerView(self.youTubePlayer) { state in
            // Overlay ViewBuilder closure to place an overlay View
            // for the current `YouTubePlayer.State`
            switch state {
            case .idle:
                ProgressView()
            case .ready:
                EmptyView()
            case .error(let error):
                Text(verbatim: "YouTube player couldn't be loaded")
            }
        }
    }

}
