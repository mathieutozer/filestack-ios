//
//  CellDescriptibleSource.swift
//  Filestack
//
//  Created by Ruben Nine on 11/7/17.
//  Copyright © 2017 Filestack. All rights reserved.
//

#if os(iOS)

import UIKit
#endif

protocol CellDescriptibleSource {
    var iconImage: PlatformImage { get }
    var textDescription: String { get }
}

func == (lhs: CellDescriptibleSource, rhs: CellDescriptibleSource) -> Bool {
    return lhs.textDescription == rhs.textDescription
}


