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

struct TripMapView: View {
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Query private var listPlacemarks: [MTPlacemark]
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(listPlacemarks) { placemark in
                Marker(coordinate: placemark.coordinate) {
                    Label(placemark.name, systemImage: "star")
                }
                .tint(.yellow)
            }
        }
        .mapControls{
            MapUserLocationButton()
        }
        .onAppear {
            manager.requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    TripMapView()
}
