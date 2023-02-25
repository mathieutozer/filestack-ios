//
//  ImageEditorCommand.swift
//  Filestack
//
//  Created by Ruben Nine on 7/4/19.
//  Copyright © 2019 Filestack. All rights reserved.
//

#if os(iOS)
import UIKit

enum ImageEditorCommand {
    case rotate(clockwise: Bool)
    case crop(insets: UIEdgeInsets)
    case circled(center: CGPoint, radius: CGFloat)
    case undo
    case redo
    case reset
}

#endif
