//
//  UIImage+Bundle.swift
//  Filestack
//
//  Created by Mihály Papp on 30/07/2018.
//  Copyright © 2018 Filestack. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension PlatformImage {
  static func fromFilestackBundle(_ name: String) -> PlatformImage {
#if os(iOS)
    return PlatformImage(named: name, in: bundle, compatibleWith: nil) ?? PlatformImage()
#else
    return NSImage(named: name)!
#endif
  }

  static func templatedFilestackImage(_ name: String) -> PlatformImage {
#if os(iOS)
    return fromFilestackBundle(name).withRenderingMode(.alwaysTemplate)
#else
    return NSImage(named: name)!
#endif
  }
}
