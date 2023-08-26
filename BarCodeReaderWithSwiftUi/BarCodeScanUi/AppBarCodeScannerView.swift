//
//  AppBarCodeScannerView.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 25/08/23.
//

import SwiftUI
import AVFoundation
import CarBode

struct CameraFrame: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height

            path.addLines( [

                CGPoint(x: 0, y: height * 0.25),
                CGPoint(x: 0, y: 0),
                CGPoint(x:width * 0.25, y:0)
            ])

            path.addLines( [

                CGPoint(x: width * 0.75, y: 0),
                CGPoint(x: width, y: 0),
                CGPoint(x:width, y:height * 0.25)
            ])

            path.addLines( [

                CGPoint(x: width, y: height * 0.75),
                CGPoint(x: width, y: height),
                CGPoint(x:width * 0.75, y: height)
            ])

            path.addLines( [

                CGPoint(x:width * 0.25, y: height),
                CGPoint(x:0, y: height),
                CGPoint(x:0, y:height * 0.75)

            ])

        }
    }
}

struct AppBarCodeScannerView: View {
    
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State var cameraPosition = AVCaptureDevice.Position.back
    
    private let frameWidth: CGFloat = UIScreen.main.bounds.width * 0.65
    private let scanBorderImageWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    private let topPaddingForScanView: CGFloat = 140
    private var borderPaddingFromTop: CGFloat {
        return topPaddingForScanView - (scanBorderImageWidth - frameWidth)/2
    }
    
    private var flashlightButtonTopSpace: CGFloat {
        return scanBorderImageWidth + borderPaddingFromTop + 20
    }

     var body: some View {

         ZStack {
             VStack {
                 CBScanner(
                    supportBarcode: .constant([.qr, .code128]),
                    torchLightIsOn: $torchIsOn,
                    cameraPosition: $cameraPosition,
                    mockBarCode: .constant(BarcodeData(value: "My Test Data", type: .qr))
                 ) {
                     print("BarCodeType = ", $0.type.rawValue, "Value =", $0.value)
                     barcodeValue = $0.value
                 }
             onDraw: {
                 print("Preview View Size = \($0.cameraPreviewView.bounds)")
                 print("Barcode Corners = \($0.corners)")
                 
                 let lineColor = UIColor.green
                 let fillColor = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.4)
                 // Draw Barcode corner
                 $0.draw(lineWidth: 1, lineColor: lineColor, fillColor: fillColor)
                 
             }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: 400, alignment: .topLeading)
                     .overlay(CameraFrame()
                        .stroke(lineWidth: 5)
                        .frame(width: 500, height: 250)
                        .foregroundColor(.blue))
             }
             .frame(width: UIScreen.main.bounds.width, alignment: .center)
             .ignoresSafeArea()
             .overlay(FlashLightScanImageView(torchOn: $torchIsOn).padding(.top, flashlightButtonTopSpace),
                      alignment: .top)
             Button(action: {
                            if cameraPosition == .back {
                                cameraPosition = .front
                            } else {
                                cameraPosition = .back
                            }
             }) {
                 HStack (alignment: .center) {
                     Image(systemName: "arrow.triangle.2.circlepath.camera.fill").foregroundColor(Color.white)
                     if cameraPosition == .back {
                         Text("Switch Camera to Front").padding(.leading, 12).foregroundColor(Color.white)
                     }
                     else {
                         Text("Switch Camera to Back").padding(.leading, 12).foregroundColor(Color.white)
                     }
                 }
             }.padding(.top, flashlightButtonTopSpace + 200)
         }
    }
}

struct AppBarCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        AppBarCodeScannerView()
    }
}


