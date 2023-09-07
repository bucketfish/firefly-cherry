//
//  TimerSounds.swift
//  firefly-cherry
//
//  Created by Tongyu Jiang on 6/9/23.
//

import Foundation

enum TimerSounds: String, Equatable, CaseIterable {
    case harp = "harp"
    case marimba = "marimba"
    var id: Self {self}
}
