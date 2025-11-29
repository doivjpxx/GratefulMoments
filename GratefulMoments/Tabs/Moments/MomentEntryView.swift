//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by Phong Hy on 29/11/25.
//

import SwiftUI

struct MomentEntryView: View {
    @State private var title = "";
    @State private var note = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
        }
    }
    
    var contentStack : some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (required)")
            }
            .font(.title.bold())
            .padding(.top, 48)
            Divider()
            TextField("Log your small wins", text: $note, axis: .vertical)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5...Int.max)
        }
        .padding()
    }
}

#Preview {
    MomentEntryView()
}
