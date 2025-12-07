//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by Phong Hy on 7/12/25.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    let badgeManager: BadgeManager

    var context: ModelContext {
        modelContainer.mainContext
    }


    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
           Moment.self,
           Badge.self
       ])


        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)


       do {
           modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
           badgeManager = BadgeManager(modelContainer: modelContainer)
           
           try badgeManager.loadBadgesIfNeeded()

           if includeSampleMoments {
               try loadSampleMoments()
           }
           try context.save()
       } catch {
           fatalError("Could not create ModelContainer: \(error)")
       }
    }
    
    private func loadSampleMoments() throws {
        for moment in Moment.sampleData {
            context.insert(moment)
            try badgeManager.unlockBadges(newMoment: moment)
        }
    }
    
    static let sampleContainer: DataContainer = {
        DataContainer(includeSampleMoments: true)
    }()
}

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(DataContainer.sampleContainer)
            .modelContainer(DataContainer.sampleContainer.modelContainer)
    }
}
