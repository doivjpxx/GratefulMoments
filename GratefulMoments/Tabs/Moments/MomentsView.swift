//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by Phong Hy on 7/12/25.
//

import SwiftUI
import SwiftData

struct MomentsView: View {
    @Query(sort: \Moment.timestamp)
   private var moments: [Moment]
    
    @State private var showCreateMoment = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                pathItems
                    .frame(maxWidth: .infinity)
            }
            .overlay {
                if moments.isEmpty {
                    ContentUnavailableView {
                        Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
                    } description: {
                        Text("Post a note or photo to start filling this space with gratitude.")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showCreateMoment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showCreateMoment) {
                        MomentEntryView()
                    }
                }
                
            }
            .navigationTitle("Grateful Moments")
        }
        
    }
    
    private var pathItems: some View {
        ForEach(moments) { moment in
            NavigationLink {
                MomentDetailView(moment: moment)
            } label: {
                Text(moment.title)
            }
        }
    }
}

#Preview {
    MomentsView()
        .sampleDataContainer()
}

#Preview("No moments") {
    MomentsView()
        .modelContainer(for: [Moment.self])
}
