//
//  BluetoothControllerDelegate.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/15/22.
//

import Foundation

protocol BluetoothControllerDelegate {
    func bluetoothDeviceDidConnect(deviceUUID: UUID) -> Void
    func bluetoothDeviceDidSendData(deviceUUID: UUID, data: String) -> Void
}

// Default implementations to make methods optional
extension BluetoothControllerDelegate {
    func bluetoothDeviceDidConnect(deviceUUID: UUID) -> Void {
        return
    }
    
    func bluetoothDeviceDidSendData(deviceUUID: UUID, data: String) -> Void {
        return
    }
}

