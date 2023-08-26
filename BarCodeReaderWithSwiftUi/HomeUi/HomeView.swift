//
//  HomeView.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 26/08/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "barcode.viewfinder")
                .resizable().renderingMode(.template).frame(width: 60, height: 60, alignment: .center)
                .foregroundColor(.black)
            Text("BarCode Reader Demo").padding(.top, 24)
            Text("please tap bottom button for BarCode scanning").padding(.top, 8).font(.system(size: 14)).foregroundColor(Color.black)
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
