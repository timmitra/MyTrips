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
    @Environment(\.modelContext) private var modelContext
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var searchText = ""
    @FocusState private var searchFieldFocus: Bool
    @Query(filter: #Predicate<MTPlacemark> { $0.destination == nil}) private var searchPlacemarks: [MTPlacemark]
    private var listPlacemarks: [MTPlacemark] {
        searchPlacemarks + destination.placemarks
    }
    
    var destination: Destination
    
    var body: some View {
        @Bindable var destination = destination
        VStack {
            LabeledContent {
                TextField("Enter destination name", text: $destination.name)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.primary)
            } label: {
                Text("Name")
            }
            HStack {
                Text("Adjust the map to set the region for your destination.")
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Set Region") {
                    if let visibleRegion {
                        destination.latitude = visibleRegion.center.latitude
                        destination.longitude = visibleRegion.center.longitude
                        destination.latitudeDelta = visibleRegion.span.latitudeDelta
                        destination.longitudeDelta = visibleRegion.span.longitudeDelta

                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.horizontal)
        Map(position: $cameraPosition) {
                ForEach(listPlacemarks) { placemark in
                    if placemark.destination != nil {
                        Marker(coordinate: placemark.coordinate) {
                            Label(placemark.name, systemImage: "star")
                        }
                        .tint(.yellow)
                    } else {
                        Marker(placemark.name, coordinate: placemark.coordinate)
                    }
                }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($searchFieldFocus)
                    .overlay(alignment: .trailing) {
                        if searchFieldFocus {
                            Button {
                                searchText = ""
                                searchFieldFocus = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .offset(x: -5)
                        }
                    }
                    .onSubmit {
                        Task {
                            await MapManager.searchPlaces(
                                modelContext,
                                searchText: searchText,
                                visibleRegion: visibleRegion
                            )
                            searchText = ""
                        }
                    }
                if !searchPlacemarks.isEmpty {
                    Button {
                        MapManager.removeSearchResults(modelContext)
                    } label: {
                         Image(systemName: "mappin.slash.circle.fill")
                            .imageScale(.large)
                    }
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.red)
                    .clipShape(.circle)
                }
            }
            .padding()
        }
        .navigationTitle("Destination")
        .navigationBarTitleDisplayMode(.inline)
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .task {
            MapManager.removeSearchResults(modelContext)
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
        .onDisappear {
            MapManager.removeSearchResults(modelContext)
        }
    }
}

#Preview {
//    let container = Destination.preview
//    let fetchDescriptor = FetchDescriptor<Destination>()
//    let destination = try! container.mainContext.fetch(fetchDescriptor)[0]
    do {
        let container = try ModelContainer(for: Destination.self)
        let paris = Destination(
            name: "Paris",
            latitude: 48.856788,
            longitude: 2.351077,
            latitudeDelta: 0.15,
            longitudeDelta: 0.15
        )
        var placemarks: [MTPlacemark] = [
            MTPlacemark(
                name: "Louvre Museum",
                address: "93 Rue de Rivoli, 75001, Paris, France",
                latitude: 48.861950,
                longitude: 2.336902
            ),
            MTPlacemark(
                name: "Sacré-Coeur Basilica",
                address: "Parvis du Sacré-Cœur, 75018 Paris, France",
                latitude: 48.886634,
                longitude: 2.343048
            ),
            MTPlacemark(
                name: "Eiffel Tower",
                address: "5 Avenue Anatole France, 75007 Paris, France",
                latitude: 48.858258,
                longitude: 2.294488
            ),
            MTPlacemark(
                name: "Moulin Rouge",
                address: "82 Boulevard de Clichy, 75018 Paris, France",
                latitude: 48.884134,
                longitude: 2.332196
            ),
            MTPlacemark(
                name: "Arc de Triomphe",
                address: "Place Charles de Gaulle, 75017 Paris, France",
                latitude: 48.873776,
                longitude: 2.295043
            ),
            MTPlacemark(
                name: "Gare Du Nord",
                address: "Paris, France",
                latitude: 48.880071,
                longitude: 2.354977
            ),
            MTPlacemark(
                name: "Notre Dame Cathedral",
                address: "6 Rue du Cloître Notre-Dame, 75004 Paris, France",
                latitude: 48.852972,
                longitude: 2.350004
            ),
            MTPlacemark(
                name: "Panthéon",
                address: "Place du Panthéon, 75005 Paris, France",
                latitude: 48.845616,
                longitude: 2.345996
            )]
        paris.placemarks = placemarks
        return NavigationStack {
            DestinationLocationsMapView(destination: paris)
                .modelContainer(container)
        }
        //.modelContainer(Destination.preview)
    } catch {
        fatalError("Fatal Error: Could not create ModelContainer. Error: \(error)")
    }
}
