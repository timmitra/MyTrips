//
//  DestinationsListView.swift
//  MyTrips
//
//  Created by Tim Mitra on 2024-07-08.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Query(sort: \Destination.name) private var destinations: [Destination]
    
    var body: some View {
        if !destinations.isEmpty {
            Text("Hello, World!")
        } else {
            ContentUnavailableView(
            "No Destinations",
            systemImage: "globe.desk",
            description: Text("You have not yet set up ant destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin.")
            )
        }
    }
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
