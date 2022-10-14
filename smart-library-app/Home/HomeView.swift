//
//  HomeView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/5/22.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    @State var navigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NowReading(rootNavigationPath: navigationPath)
                Spacer()
                
                Button {
                    BluetoothHelper.shared.startScanning(btDeviceUuid: UUID(uuidString: "8A31C81E-FBA7-DB87-45BE-D53ADA6CCFC7"))
                } label: {
                    Text("Emma")
                }
                .buttonStyle(SecondaryButtonStyle())
                
                Button {
                    BluetoothHelper.shared.startScanning(btDeviceUuid: UUID(uuidString: "0B0CF953-75E3-62B9-7267-D4138276C946"))
                } label: {
                    Text("Riley")
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding(16)
            .navigationTitle("Home")
            .navigationDestination(for: String.self, destination: { string in  Text(string)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
