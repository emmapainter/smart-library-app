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
            
            Button(action: {
                BluetoothController.shared.writeOutgoingValue(data: "hello", btDeviceUuid: UUID(uuidString: "8A31C81E-FBA7-DB87-45BE-D53ADA6CCFC7")!)
            }, label: {
                Text("Send a message")
            })
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
