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
        NavigationStack {
            Group {
                if !destinations.isEmpty {
                    List(destinations) { destination in
                        HStack {
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundStyle(.accent)
                            VStack(alignment: .leading) {
                                Text(destination.name)
                                Text("^[\(destination.placemarks.count) location](inflect: true)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "No Destinations",
                        systemImage: "globe.desk",
                        description: Text("You have not yet set up ant destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin.")
                    )
                }
            }
            .navigationTitle("My Destinations")
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
