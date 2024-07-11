//
//  LocationDeniedView.swift
//  MyTrips
//
//  Created by Tim Mitra on 2024-07-10.
//

import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Label("Location Services", image: "launchScreen")
        }, description: {
            Text("""
1. Tap the button below and go to "Privacy and Security".
2. Tap on "Location Services".
3. Locate the "MyTrips" app and tap on it.
4. Change the setting to "While using the App."
""")
        }, actions: {
            Button(action: {
                UIApplication.shared.open(
                    URL(string: UIApplication.openSettingsURLString)!,
                    options: [:],
                    completionHandler: nil
                )
            }) {
                Text("Open Settings")
            }
            .buttonStyle(.borderedProminent)
        })
    }
}

#Preview {
    LocationDeniedView()
}
