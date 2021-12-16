//
//  RecreationARApp.swift
//  RecreationAR
//
//  Created by Vincenzo Sorrentino on 14/12/21.
//

import SwiftUI

@main
struct RecreationARApp: App {
    
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
