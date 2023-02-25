//
//  UIColor+predefined.swift
//  Filestack
//
//  Created by Mihály Papp on 10/08/2018.
//  Copyright © 2018 Filestack. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension PlatformColor {
    static var appleBlue: PlatformColor {
        return PlatformColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
    }

    static var appleTableSeparator: PlatformColor {
        return PlatformColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
    }
}
