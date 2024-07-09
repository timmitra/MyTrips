//
//  DestinationsListView.swift
//  MyTrips
//
//  Created by Tim Mitra on 2024-07-08.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Destination.name) private var destinations: [Destination]
    @State private var newDestination = false
    @State private var destinationName = ""
    
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
                    newDestination.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                    .alert("Enter Destination Name", isPresented: $newDestination) {
                        TextField("Enter destination name", text: $destinationName)
                        Button("Ok") {
                            if !destinationName.isEmpty {
                                let destination = Destination(name: destinationName)
                                modelContext.insert(destination)
                                destinationName = ""
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("Create a new destination.")
                    }
            }
        }
    }
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
