//
//  ProgressBarType.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 7/9/23.
//

import Foundation

enum ProgressBarType: String, Equatable, CaseIterable {
    case circular, top, middle, bottom, none
    var id: Self {self}
}
