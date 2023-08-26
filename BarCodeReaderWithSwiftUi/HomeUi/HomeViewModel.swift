//
//  HomeViewModel.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 26/08/23.
//

import AVFoundation

protocol HomeViewModelProtocol: ObservableObject {
    func startScanBarCode()
    var showBarCodeScanView: Bool { get set }
    var showCameraPermissionError: Bool { get set }
    var scannedBarCodeValue: String { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    
    @Published var showBarCodeScanView = false
    @Published var showCameraPermissionError = false
    @Published var scannedBarCodeValue: String = ""
    
    func startScanBarCode() {
        print("startScanBarCode checkCameraPermissionAndLaunchBarCode")
        checkCameraPermissionAndLaunchBarCode()
        // startScanBarCode
    }

    func checkCameraPermissionAndLaunchBarCode() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            // already authorized
            print("checkCameraPermissionAndLaunchBarCode already authorized")
            DispatchQueue.main.async {
                self.showBarCodeScanView = true
            }
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    // access allowed
                    print("checkCameraPermissionAndLaunchBarCode access allowed")
                    DispatchQueue.main.async {
                        self.showBarCodeScanView = true
                    }
                } else {
                    // access denied
                    print("checkCameraPermissionAndLaunchBarCode access denied")
                    DispatchQueue.main.async {
                        self.showCameraPermissionError = true
                    }
                }
            })
        }
    }
}
