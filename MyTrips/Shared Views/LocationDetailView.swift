//
//  LocationDetailView.swift
//  MyTrips
//
//  Created by Tim Mitra on 2024-07-09.
//

import SwiftUI
import MapKit
import SwiftData

struct LocationDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var destination: Destination?
    var selectedPlacemark: MTPlacemark?
    @State private var name = ""
    @State private var address = ""
    
    var isChanged: Bool {
        guard let selectedPlacemark else { return false }
        return (name != selectedPlacemark.name || address != selectedPlacemark.address)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    TextField("Name", text: $name)
                        .font(.title)
                    TextField("address", text: $address, axis: .vertical)
                    if isChanged {
                        Button("Update") {
                            selectedPlacemark?.name = name
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                            selectedPlacemark?.address = address
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .buttonStyle(.borderedProminent)
                    }
                }
                .textFieldStyle(.roundedBorder)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.gray)
                }
            }
            HStack {
                Spacer()
                if let destination {
                    let inList = (selectedPlacemark != nil && selectedPlacemark?.destination != nil)
                    Button {
                        if let selectedPlacemark {
                            if selectedPlacemark.destination == nil {
                                destination.placemarks.append(selectedPlacemark)
                            } else {
                                selectedPlacemark.destination = nil
                            }
                            dismiss() 
                        }
                    } label: {
                        Label(inList ? "Remove" : "Add", systemImage: inList ? "minus.circle" : "plus.circle")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(inList ? .red : .green)
                    .disabled(name.isEmpty || isChanged)
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
                if let selectedPlacemark, destination != nil {
                    name = selectedPlacemark.name
                    address = selectedPlacemark.address
                }
            }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for:Destination.self)
        let paris = Destination(
            name: "Paris",
            latitude: 48.856788,
            longitude: 2.351077,
            latitudeDelta: 0.15,
            longitudeDelta: 0.15
        )
        let placemark: MTPlacemark =
            MTPlacemark(
                name: "Louvre Museum",
                address: "93 Rue de Rivoli, 75001, Paris, France",
                latitude: 48.861950,
                longitude: 2.336902
            )
        return LocationDetailView(destination: paris, selectedPlacemark: placemark)
    } catch {
        fatalError("Fatal Error: Could not create ModelContainer. Error: \(error)")
    }
}
