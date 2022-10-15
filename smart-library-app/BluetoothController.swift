//
//  BluetoothController.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/14/22.
//

import Foundation
import CoreBluetooth

private struct CBUUIDs{
    
    static let kBLEService_UUID = "0000ffe0-0000-1000-8000-00805f9b34fb"
    static let kBLE_Characteristic_uuid_Tx = "0000ffe1-0000-1000-8000-00805f9b34fb"
    static let kBLE_Characteristic_uuid_Rx = "0000ffe1-0000-1000-8000-00805f9b34fb"

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)

}

class BluetoothController: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    static let shared = BluetoothController()
    
    private var centralManager: CBCentralManager!
    private var peripherals = [CBPeripheral]()
    
    private var deviceToConnectTo: UUID?
    
    private var delegates = [BluetoothControllerDelegate]()
    
    override private init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
                  case .poweredOff:
                      print("Is Powered Off.")
                  case .poweredOn:
                      print("Is Powered On.")
                  case .unsupported:
                      print("Is Unsupported.")
                  case .unauthorized:
                  print("Is Unauthorized.")
                  case .unknown:
                      print("Unknown")
                  case .resetting:
                      print("Resetting")
                  @unknown default:
                    print("Error")
                }
    }
    
    func startScanning(btDeviceUuid: UUID?) -> Void {
      // Start Scanning
        centralManager?.scanForPeripherals(withServices: [CBUUIDs.BLEService_UUID])
        self.deviceToConnectTo = btDeviceUuid
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (peripheral.identifier == self.deviceToConnectTo) {
            self.peripherals.append(peripheral)
            self.peripherals[peripherals.count - 1].delegate = self
            centralManager?.connect(self.peripherals[peripherals.count - 1], options: nil)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if self.peripherals.count >= 1 && self.peripherals[self.peripherals.count - 1].identifier == peripheral.identifier {
            self.peripherals[self.peripherals.count - 1].discoverServices([CBUUIDs.BLEService_UUID])
        } else {
            print("Something went wrong...")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if ((error) != nil) {
            print("Error discovering services: \(error!.localizedDescription)")
            return
        }
        guard let services = peripheral.services else {
            return
        }
        //We need to discover the all characteristic
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for delegate in delegates {
            delegate.bluetoothDeviceDidConnect(deviceUUID: peripheral.identifier)
        }
        
        for characteristic in characteristics {
            if characteristic.uuid.isEqual(CBUUIDs.BLE_Characteristic_uuid_Rx)  {
                peripheral.setNotifyValue(true, for: characteristic)
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        var characteristicASCIIValue = NSString()

        guard let characteristicValue = characteristic.value,
                let ASCIIstring = NSString(data: characteristicValue, encoding: String.Encoding.utf8.rawValue) else { return }
        characteristicASCIIValue = ASCIIstring
        
        for delegate in delegates {
            delegate.bluetoothDeviceDidSendData(deviceUUID: peripheral.identifier, data: characteristicASCIIValue as String)
        }
    }
    
//    func writeOutgoingValue(data: String){
//
//        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
//
//        if let peripheral = self.peripheral {
//
//          if let txCharacteristic = txCharacteristic {
//              print("sending message")
//              self.peripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
//              }
//          }
//      }
    
    func addDelegate(delegate: BluetoothControllerDelegate) -> Void {
        self.delegates.append(delegate)
    }
}


