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

struct DestinationLocationsMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    var body: some View {
        Map(position: $cameraPosition) {
            Marker("Moulin Trouge", coordinate: CLLocationCoordinate2D(latitude: 48.884134, longitude: 2.332196))
        }
            .onAppear {
                // 48.856788, 2.351077
                let paris = CLLocationCoordinate2D(
                    latitude: 48.856788,
                    longitude:  2.351077)
                let parisSpan = MKCoordinateSpan(
                    latitudeDelta: 0.15,
                    longitudeDelta: 0.15)
                let parisRegion = MKCoordinateRegion(center: paris, span: parisSpan)
                cameraPosition = .region(parisRegion)
            }
    }
}

#Preview {
    DestinationLocationsMapView()
}
