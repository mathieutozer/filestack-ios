//
//  UIImage+Export.swift
//  Filestack
//
//  Created by Ruben Nine on 7/11/19.
//  Copyright © 2019 Filestack. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa

func jpegDataFrom(image:NSImage) -> Data? {
  let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
  let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
  let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])
  return jpegData
}

#endif

extension PlatformImage {
    func exportHEICImage(to destinationURL: URL, quality: Float) -> Bool {
        guard let imageData = heicRepresentation(quality: quality) else { return false }

        return export(data: imageData, to: destinationURL)
    }

    func exportJPGImage(to destinationURL: URL, quality: Float) -> Bool {
#if os(iOS)
        guard let imageData = jpegData(compressionQuality: CGFloat(quality)) else { return false }
      #else
      guard let imageData = jpegDataFrom(image: self) else { return false }
      #endif

        return export(data: imageData, to: destinationURL)
    }

    // MARK: - Private Functions

    private func export(data: Data, to destinationURL: URL) -> Bool {
        do {
            try data.write(to: destinationURL)
            return true
        } catch {
            return false
        }
    }
}
