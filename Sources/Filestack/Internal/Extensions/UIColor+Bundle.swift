//
//  UIColor+Bundle.swift
//  Filestack
//
//  Created by Ruben Nine on 17/09/2019.
//  Copyright © 2019 Filestack. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension PlatformColor {
    static func fromFilestackBundle(_ name: String) -> PlatformColor? {
      #if os(iOS)
        return PlatformColor(named: name, in: bundle, compatibleWith: nil)
      #else
      return NSColor.red
      #endif
    }
}
