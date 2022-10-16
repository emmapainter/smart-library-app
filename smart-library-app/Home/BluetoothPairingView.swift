//
//  BluetoothPairingView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/14/22.
//

import SwiftUI
import CodeScanner

struct BluetoothPairingView: View, BluetoothControllerDelegate {
    @State var btId: String
    @State var bookmarkConnected = false
    @State var bookmarkUUID: UUID?
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Connected to bookmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text(bookmarkConnected.description)
            }
            .padding(.top, 36.0)
        }
        .onAppear {
            BluetoothController.shared.addDelegate(delegate: self)
            BluetoothController.shared.startScanning(btDeviceUuid: UUID(uuidString: btId))
        }
    }
    
    func bluetoothDeviceDidConnect(deviceUUID: UUID) {
        print("connected to \(deviceUUID)")
        bookmarkUUID = deviceUUID
        bookmarkConnected = true
    }
}
