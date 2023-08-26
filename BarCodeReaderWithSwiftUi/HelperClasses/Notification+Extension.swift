//
//  Notification+Extension.swift
//  BarCodeReaderWithSwiftUi
//
//  Created by Gaurav Tak on 26/08/23.
//

import Foundation

enum NotificationData: String {
    case barCodeValue
}

extension Notification.Name {
    static let showBarCodeValue = Notification.Name("showBarCodeValue")
}
