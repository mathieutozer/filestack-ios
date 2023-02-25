//
//  UIImage+Resized.swift
//  Filestack
//
//  Created by Ruben Nine on 7/11/19.
//  Copyright © 2019 Filestack. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

#if os(iOS)
extension PlatformImage {
    func resized(for size: CGSize) -> PlatformImage? {
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

#endif
