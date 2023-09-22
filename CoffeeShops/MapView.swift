//
//  MapView.swift
//  CoffeeShops
//
//  Created by Luke Rohrer on 9/21/23.
//

import SwiftUI
import MapKit

// TODO: use Markers as coffee shop locations
// - can add name, systemImage, coordinate
// - will be balloon shape

// TODO: add a .onChange(of: <function>) {position = .automatic} once a search function has been added

// NOTE: Annotation is more customizable

extension CLLocationCoordinate2D {
    static let fish_house = CLLocationCoordinate2D(latitude: 32.81762, longitude: -117.16071)
}

struct MapView: View {
    
    @State private var position: MapCameraPosition = .automatic
        //.userLocation(fallback:.automatic)
    
    @State private var searchText = ""
    
    @Namespace var mapScope
    
    var body: some View {
        Map(position: $position, scope: mapScope) {
            Annotation(
                "Fish House",
                coordinate:.fish_house,
                anchor:.bottom) {
                    Image(systemName: "house.fill")
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(Color.indigo)
                        .cornerRadius(4)
                }
                .annotationTitles(.hidden)
            
            UserAnnotation()
        }
        .mapStyle(.standard(elevation: .realistic))  // 3d map
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
}

#Preview {
    MapView()
}
