//
//  ColorUtils.swift
//  CCA
//
//  Created by William Kleinschmidt on 9/29/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {

     class func color(data: Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}

class ColorUtils {
    
    static private let defSwiftUIColor = Color(.white)
    static private let defUIColor = UIColor(defSwiftUIColor)
    
    static func ColorToData(swiftuiColor: Color) -> Data? {
        let uiColor = UIColor(swiftuiColor)
        return uiColor.encode()
    }
    
    static func ColorFromData(data: Data) -> Color? {
        let uiColor = UIColor.color(data: data)
        return Color(uiColor ?? defUIColor)
    }
}

