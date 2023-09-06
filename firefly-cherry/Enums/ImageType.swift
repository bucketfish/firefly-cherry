//
//  ImageType.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation

// for background images
enum ImageType: String, Equatable, CaseIterable {
    case premade, web, upload
    var id: Self { self }
}
