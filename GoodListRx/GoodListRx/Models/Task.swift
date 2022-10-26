//
//  Task.swift
//  GoodListRx
//
//  Created by Maxim Bekmetov on 26.10.2022.
//

import Foundation

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
