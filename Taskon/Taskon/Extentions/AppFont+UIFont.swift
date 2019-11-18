//
//  AppFont+UIFont.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 18/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum FontTypes {
    case light
    case blackCond
    case boldCondlt
    case lightlt
    case semiboldlt
    case semibold
    case regular
    case lt
    case bold
    case condlt
    case black
    case boldlt
    case boldCond
    case cond

    func getFontName() -> String {
        switch self {
        case .light: return "MyriadPro-Light.otf"
        case .blackCond: return "MyriadPro-BlackCond.otf"
        case .boldCondlt: return "MyriadPro-BoldCondlt.otf"
        case .lightlt: return "MyriadPro-Lightlt.otf"
        case .semiboldlt: return "MyriadPro-Semiboldlt.otf"
        case .semibold: return "MyriadPro-Semibold.otf"
        case .regular: return "MyriadPro-Regular.otf"
        case .lt: return "MyriadPro-lt.otf"
        case .bold: return "MyriadPro-Bold.otf"
        case .condlt: return "MyriadPro-Condlt.otf"
        case .black: return "MyriadPro-Black.otf"
        case .boldlt: return "MyriadPro-Boldlt.otf"
        case .boldCond: return "MyriadPro-BoldCond.otf"
        case .cond: return "MyriadPro-Cond.otf"
        }
    }
}

extension UIFont {
    
    class func toFront(ofSize size: CGFloat, type: FontTypes = .regular) -> UIFont {
        if let font = UIFont(name: type.getFontName(), size: size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
