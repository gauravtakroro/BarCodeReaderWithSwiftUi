//
//  BarCodeScanViewModel.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 25/08/23.
//

import Foundation
import AVFoundation
import VideoToolbox
import SwiftUI

protocol BarCodeScanViewModelProtocol: ObservableObject {
     
    var frame: CGImage? { get set }
    var torchOn: Bool { get set }
    var barCodeValue: String { get set }
    var showBarCodeValueBottomView: Bool { get set }
}

class BarCodeScanViewModel: BarCodeScanViewModelProtocol {
    @Published var torchOn: Bool = false
    @Published var frame: CGImage?
    @Published var barCodeValue: String = ""
    @Published var showBarCodeValueBottomView: Bool = false
    init() {
      //  setupSubscriptions()
    }
}
extension BarCodeScanViewModel {
    func updateValuesOfbarCodeValueAndShowBarCodeValueBottomView(value: String) {
        DispatchQueue.main.async { [self] in
            self.barCodeValue = value
            self.showBarCodeValueBottomView = true
            NotificationCenter.default.post(name: .showBarCodeValue, object: nil, userInfo: [NotificationData.barCodeValue: self.barCodeValue])
        }
    }
}


