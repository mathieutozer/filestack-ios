//
//  UIImage+CIImageTransformations.swift
//  Filestack
//
//  Created by Ruben Nine on 7/4/19.
//  Copyright © 2019 Filestack. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit.UIImage
#else
import Cocoa

extension NSImage {
  var ciImage: CIImage? {
//    NSImage * image    = [self currentImage];
//    NSData  * tiffData = [image TIFFRepresentation];
//    NSBitmapImageRep * bitmap;
//    bitmap = [NSBitmapImageRep imageRepWithData:tiffData];
//
//    CIImage * ciImage = [[CIImage alloc] initWithBitmapImageRep:bitmap];
    if let data = self.tiffRepresentation,
       let bitmap = NSBitmapImageRep(data: data) {
      return CIImage(bitmapImageRep: bitmap)
    }
    return nil
  }
}
#endif

extension PlatformEdgeInsets {
    func rounded() -> PlatformEdgeInsets {
        return PlatformEdgeInsets(top: top.rounded(), left: left.rounded(), bottom: bottom.rounded(), right: right.rounded())
    }
}

extension PlatformImage {
  #if os(iOS)
    /// Returns a 90 degree-rotated image with a `CIImage` as the backing image.
    ///
    /// - Parameter clockwise: If true, image is rotated clockwise, otherwise it is rotated anticlockwise.
    ///
    func rotated(clockwise: Bool) -> PlatformImage? {
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }

        let transform = ciImage.orientationTransform(for: clockwise ? .right : .left)
        let outputImage = ciImage.transformed(by: transform)

        return PlatformImage(ciImage: outputImage)
    }

    /// Returns a cropped image with a `CIImage` as the backing image.
    ///
    /// - Parameter insets: Specifies how much should be inset on each side of the rect.
    ///
    func cropped(by insets: PlatformEdgeInsets) -> PlatformImage? {
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }

        let extent = ciImage.extent
        let transform = coordinatesTransform(rect: extent)
        let rect = extent.applying(transform).inset(by: insets.rounded()).applying(transform)
        let outputImage = ciImage.cropped(to: rect)

        return UIImage(ciImage: outputImage)
    }

    /// Returns a circle-cropped image with a `CIImage` as the backing image.
    ///
    /// - Parameter center: Circle's center point.
    /// - Parameter radius: Circle's radius.
    /// - Parameter transformed: Whether to transform UIKit coordinates into Core Image coordinates. Defaults to false.
    ///
    func circled(center: CGPoint, radius: CGFloat) -> PlatformImage? {
        guard let ciImage = ciImage ?? CIImage(image: self) else { return nil }

        let extent = ciImage.extent
        let transform = coordinatesTransform(rect: extent)
        let tCenter = center.applying(transform)

        let origin = CGPoint(x: (extent.minX + (tCenter.x - radius)).rounded(),
                             y: (extent.minY + (tCenter.y - radius)).rounded())

        let rect = CGRect(origin: origin, size: CGSize(width: radius.rounded() * 2, height: radius.rounded() * 2))

        let transformedCIImage = ciImage.cropped(to: rect)

        let alpha1 = CIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let alpha0 = CIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let croppedCenter = CIVector(x: rect.midX, y: rect.midY)

        let radialGradientFilter = CIFilter(name: "CIRadialGradient", parameters: ["inputRadius0": radius,
                                                                                   "inputRadius1": radius + 1,
                                                                                   "inputColor0": alpha1,
                                                                                   "inputColor1": alpha0,
                                                                                   kCIInputCenterKey: croppedCenter])

        guard let circledImage = radialGradientFilter?.outputImage else { return nil }

        let compositingFilter = CIFilter(name: "CISourceInCompositing", parameters: [kCIInputImageKey: transformedCIImage,
                                                                                     kCIInputBackgroundImageKey: circledImage])

        guard let outputImage = compositingFilter?.outputImage else { return nil }

        return UIImage(ciImage: outputImage)
    }

    /// For `CIImage` backed `UIImage`s, this function returns an equivalent `CGImage` backed `UIImage`, whether as,
    /// for already `CGImage` backed `UIImage`s, it returns `self`.
    func cgImageBackedCopy() -> PlatformImage? {
        guard let ciImage = ciImage else { return self }
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }

        return PlatformImage(cgImage: cgImage)
    }

    /// For `CGImage` backed `UIImage`s, this function returns an equivalent `CIImage` backed `UIImage`, whether as,
    /// for already `CIImage` backed `UIImage`s, it returns `self`.
    func ciImageBackedCopy() -> PlatformImage? {
        guard ciImage == nil else { return self }
        guard let ciImage = CIImage(image: self) else { return nil }

        return PlatformImage(ciImage: ciImage)
    }
  #endif

    // MARK: - Private Functions

    private func coordinatesTransform(rect: CGRect) -> CGAffineTransform {
        return CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -rect.height)
    }
}
