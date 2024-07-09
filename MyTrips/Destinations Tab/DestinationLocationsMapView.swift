//
// Created for MyTrips
// by  Stewart Lynch on 2023-12-31
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI
import MapKit
import SwiftData

struct DestinationLocationsMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    var destination: Destination
    
    var body: some View {
        Map(position: $cameraPosition) {
                ForEach(destination.placemarks) { placemark in
                    Marker(coordinate: placemark.coordinate) {
                        Label(placemark.name, systemImage: "star")
                    }
                    .tint(.yellow)
                }
        }
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onAppear {
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
    }
}

#Preview {
    DestinationLocationsMapView(destination: Destination(name: "Paris"))
        .modelContainer(Destination.preview)
}
