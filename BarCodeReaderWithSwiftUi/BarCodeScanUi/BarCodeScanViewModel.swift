//
//  BarCodeScanViewModel.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 25/08/23.
//

import Foundation
import AVFoundation
import VideoToolbox

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
}


