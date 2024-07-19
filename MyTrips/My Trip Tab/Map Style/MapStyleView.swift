//
//  MapStyleView.swift
//  MyTrips
//
//  Created by Tim Mitra on 2024-07-19.
//

import SwiftUI

struct MapStyleView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var mapStyleConfig: MapStyleConfig
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                LabeledContent("Base Style") {
                    Picker("Base Style", selection: $mapStyleConfig.baseStyle) {
                        ForEach(MapStyleConfig.BaseMapStyle.allCases, id: \.self) { type in
                            Text(type.label)
                        }
                    }
                }
                LabeledContent("Elevation") {
                    Picker("Elevation", selection: $mapStyleConfig.elevation) {
                        Text("Flat").tag(MapStyleConfig.MapElevation.flat)
                        Text("Realistic").tag(MapStyleConfig.MapElevation.realistic)
                    }
                }
                if mapStyleConfig.baseStyle != .imagery {
                    LabeledContent("Point of Interest") {
                        Picker("Point of Interest", selection: $mapStyleConfig.pointOfInterest) {
                            Text("None").tag(MapStyleConfig.MapPOI.excludingAll)
                            Text("All").tag(MapStyleConfig.MapPOI.all)
                        }
                    }
                    Toggle("Show Traffic", isOn: $mapStyleConfig.showTraffic)
                }
                Button("Ok") {
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Map Style")
            .navigationBarTitleDisplayMode(.inline)
            Spacer()
        }
    }
}

#Preview {
    MapStyleView(mapStyleConfig: .constant(MapStyleConfig.init()))
}
