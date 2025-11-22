//
//  Uploadable/Users/tozer/code/Trippy/Trips.xcodeproj.swift
//  Filestack
//
//  Created by Mihály Papp on 30/07/2018.
//  Copyright © 2018 Filestack. All rights reserved.
//


import AVFoundation
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

protocol Uploadable: AnyObject {
    var isEditable: Bool { get }
    var associatedImage: PlatformImage { get }
    var typeIcon: PlatformImage { get }
    var additionalInfo: String? { get }
}

extension PlatformImage: Uploadable {
    var isEditable: Bool { true }
    var associatedImage: PlatformImage { self }
    var typeIcon: PlatformImage {
      #if os(iOS)
      PlatformImage.fromFilestackBundle("icon-image").withRenderingMode(.alwaysTemplate)
      #else
      PlatformImage.fromFilestackBundle("icon-image")
      #endif

    }
    var additionalInfo: String? { nil }
}

extension AVAsset: Uploadable {
    var isEditable: Bool { false }

    var associatedImage: PlatformImage {
        let beginning = CMTime(seconds: 0, preferredTimescale: 1)
        do {
            let cgImage = try AVAssetImageGenerator(asset: self).copyCGImage(at: beginning, actualTime: nil)
          #if os(macOS)
          return PlatformImage(cgImage: cgImage, size: .zero)
          #else
          return PlatformImage(cgImage: cgImage)
          #endif
        } catch _ {
            return PlatformImage() // TODO: return placeholder
        }
    }

    var typeIcon: PlatformImage {
      #if os(iOS)
      PlatformImage.fromFilestackBundle("icon-file-video").withRenderingMode(.alwaysTemplate)
      #else
      PlatformImage.fromFilestackBundle("icon-file-video")
      #endif

    }

    var additionalInfo: String? { DurationFormatter().string(from: duration.seconds) }
}

