//
//  UIImage+Rect.swift
//  EditImage
//
//  Created by Mihály Papp on 02/07/2018.
//  Copyright © 2018 Mihály Papp. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension PlatformImage {
    var cgRect: CGRect {
        return CGRect(origin: .zero, size: size)
    }
}
