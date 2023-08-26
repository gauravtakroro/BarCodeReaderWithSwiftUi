//
//  BarCodeScanView.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 25/08/23.
//

import SwiftUI
import AVFoundation

struct BarCodeScanView: View {
    private let rotationChangePublisher = NotificationCenter.default
           .publisher(for: UIDevice.orientationDidChangeNotification)
    @State private var isOrientationLocked = true
    
    @StateObject var viewModel: BarCodeScanViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {

        ZStack(alignment: .top) {
            
            AppBarCodeScannerView(viewModel: viewModel)

            ZStack(alignment: .top) {
                VStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .renderingMode(.template).foregroundColor(Color.white)
                                .padding(.top, 10)
                            Spacer()
                        }
                        .padding()
                    })
                    Spacer()
                }
                Text("Scan Bar Code")
                    .foregroundColor(Color.white)
                    .font(.system(size: 24))
                    .padding(.top, 20)
                if viewModel.showBarCodeValueBottomView {
                    Spacer()
                    VStack {
                        Text("Scanned Bar Code Value").foregroundColor(Color.black).padding(.top, 12)
                        HStack {
                            Spacer()
                            if UtilMethods.verifyUrl(urlString: viewModel.barCodeValue) {
                                Button {
                                    UtilMethods.launchLinkWithSafari(urlString: viewModel.barCodeValue)
                                } label: {
                                    Text(viewModel.barCodeValue).foregroundColor(Color.blue).underline().font(.system(size: 16))
                                }
                            } else {
                                Button {
                                    UIPasteboard.general.string = viewModel.barCodeValue

                                } label: {
                                    Text(viewModel.barCodeValue).foregroundColor(Color.black).font(.system(size: 16))
                                }
                            }
                            Spacer()
                            Button {
                                viewModel.showBarCodeValueBottomView = false
                            } label: {
                                Image("x_icon").resizable().frame(width: 16, height: 16)
                            }.frame(alignment: .trailing).padding(.trailing, 24)

                        }.padding(.bottom, 12).padding(.horizontal, 12).frame(width: UIScreen.main.bounds.width)
                    }.background(Color.white).frame( maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding(.top, 30)
        }.onDisappear {
            viewModel.torchOn = false
            UtilMethods.toggleTorch(torchOn: false)
        }
        .onChange(of: viewModel.barCodeValue, perform: { _ in
            viewModel.showBarCodeValueBottomView = true
            print("Scanned barCodeValue------> \(viewModel.barCodeValue)")
        })
        .onReceive(rotationChangePublisher) { _ in
            // This is called when there is a orientation change
            // You can set back the orientation to the one you like even
            // if the user has turned around their phone to use another
            // orientation.
            if isOrientationLocked {
                changeOrientation(to: .portrait)
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func changeOrientation(to orientation: UIInterfaceOrientation) {
        // tell the app to change the orientation
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        print("Changing to", orientation.isPortrait ? "Portrait" : "Landscape")
    }
}
