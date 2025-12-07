//
//  AchievementsView.swift
//  GratefulMoments
//
//  Created by Phong Hy on 7/12/25.
//

import SwiftUI
import SwiftData

struct AchievementsView: View {
    @Query(filter: #Predicate<Badge> { $0.timestamp != nil })
    private var unlockedBadges: [Badge]


    @Query(filter: #Predicate<Badge> { $0.timestamp == nil })
    private var lockedBadges: [Badge]

    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .navigationTitle("Achievements")
        }
    }
    
    func header(_ text: String) -> some View {
        Text(text)
            .font(.subheadline.bold())
            .padding()
    }
    
    private var contentStack : some View {
        VStack {
            header("Your Badges")
            ForEach(sortedUnlockedBadges) { badge in
                Text(badge.details.title)
            }
            header("Locked Badges")
            ForEach(sortedLockedBadges) { badge in
                Text(badge.details.title)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    private var sortedUnlockedBadges: [Badge] {
        unlockedBadges.sorted {
            ($0.timestamp!, $0.details.title) < ($1.timestamp!, $1.details.title)
        }
    }
    
    private var sortedLockedBadges: [Badge] {
        lockedBadges.sorted {
            $0.details.rawValue < $1.details.rawValue
        }
    }
}

#Preview {
    AchievementsView()
}
