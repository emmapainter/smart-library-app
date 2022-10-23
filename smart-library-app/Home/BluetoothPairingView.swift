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
    @State var bookIsbn: String
    @State var bookmarkConnected = false
    @State var bookmarkUUID: UUID?
    @EnvironmentObject private var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
            if bookmarkConnected {
                Button(
                    "Bookmark connected! Tap to go back.",
                    action: { self.presentationMode.wrappedValue.dismiss() }
                )
            }
            
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
        user.addBookmark(bluetoothIdentifier: btId, bookISBN13: bookIsbn, currentPageNumber: 0)
    }
}


struct BluetoothPairingView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothPairingView(btId: "123456", bookIsbn: "9781529029581")
    }
}
