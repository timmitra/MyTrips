//
//  MapStyleConfig.swift
//  MyTrips
//
//  Created by Tim Mitra on 2024-07-19.
//

import SwiftUI
import MapKit

struct MapStyleConfig {
    enum BaseMapStyle: CaseIterable {
        case standard, hybrid, imagery
        var label: String {
            switch self {
            case .standard:
                "Standard"
            case .hybrid:
                "Satellite with Roads"
            case .imagery:
                "Satellite only"
            }
        }
    }
    
    enum MapElevation {
        case flat, realistic
        var selection: MapStyle.Elevation {
            switch self {
            case .flat:
                    .flat
            case .realistic:
                    .realistic
            }
        }
    }
    
    enum MapPOI {
        case all, excludingAll
        var selection: PointOfInterestCategories {
            switch self {
            case .all:
                    .all
            case .excludingAll:
                    .excludingAll
            }
        }
    }
    
    // MARK: default values
    var baseStyle = BaseMapStyle.standard
    var elevation = MapElevation.flat
    var pointOfInterest = MapPOI.excludingAll
    
    var showTraffic = false
    
    var mapStyle: MapStyle {
        switch baseStyle {
        case .standard:
            MapStyle.standard(elevation: elevation.selection,
                              pointsOfInterest: pointOfInterest.selection,
                              showsTraffic: showTraffic)
        case .hybrid:
            MapStyle.hybrid(elevation: elevation.selection,
                              pointsOfInterest: pointOfInterest.selection,
                              showsTraffic: showTraffic)
        case .imagery:
            MapStyle.imagery(elevation: elevation.selection)
        }
    }
}
