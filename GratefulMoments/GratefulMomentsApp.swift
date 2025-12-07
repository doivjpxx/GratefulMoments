//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Phong Hy on 29/11/25.
//

import SwiftUI

@main
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
