//
//  HomeView.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 26/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var scannedBarCodeValue: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "barcode.viewfinder")
                .resizable().renderingMode(.template).frame(width: 60, height: 60, alignment: .center)
                .foregroundColor(.black)
            Text("BarCode Reader Demo").padding(.top, 24)
            Text("please tap bottom button for BarCode scanning").padding(.top, 8).font(.system(size: 14)).foregroundColor(Color.black)
            
            if scannedBarCodeValue.isEmpty {
                Text("No Bar Code is scanned yet.").font(.system(size: 20)).foregroundColor(Color.gray.opacity(0.8))
                    .padding(.top, 24)
            } else {
                VStack {
                    Text("Most Recent Scanned Bar Code Value").foregroundColor(Color.black).padding(.top, 24)
                    if UtilMethods.verifyUrl(urlString: scannedBarCodeValue) {
                        Button {
                            UtilMethods.launchLinkWithSafari(urlString: scannedBarCodeValue)
                        } label: {
                            Text(scannedBarCodeValue).foregroundColor(Color.blue).underline().multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).font(.system(size: 16))
                        }
                    } else {
                        Button {
                            UIPasteboard.general.string = scannedBarCodeValue
                            
                        } label: {
                            Text(scannedBarCodeValue).foregroundColor(Color.black).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).font(.system(size: 16))
                        }
                    }
                }.padding(.top, 36)
            }
            Spacer()
            Button {
               // tap here to scan bar code
            } label: {
                ZStack {
                    Color("BlueColor")
                    HStack (alignment: .center) {
                        Image(systemName: "barcode.viewfinder").resizable().renderingMode(.template).frame(width: 36, height: 36, alignment: .center)
                            .foregroundColor(.white)
                        Text("Tap here for Bar Code Scan").font(.system(size: 14)).foregroundColor(Color.white)
                    }
                }.cornerRadius(16).frame(height: 62)
            }.padding(.horizontal, 36).padding(.bottom, 16).frame(alignment: .bottom)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
