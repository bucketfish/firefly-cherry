//
//  ColorScheme.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation


enum ColorScheme: String, Equatable, CaseIterable {
    case light, dark, system
    var id: Self { self }
}
