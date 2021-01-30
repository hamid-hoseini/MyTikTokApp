//
//  extension.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/23/21.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }    
}

extension DateFormatter {
    static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
       return formatter
    }()
}

extension String {
    static func date(with date: Date) -> String {
        return DateFormatter.defaultDateFormatter.string(from: date)
    }
}
