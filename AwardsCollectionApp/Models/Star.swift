//
//  Star.swift
//  AwardsCollectionApp
//
//  Created by Даниил Чупин on 07.08.2023.
//

import Foundation

struct Star: Identifiable, Hashable {
    var id = UUID()
    var position: CGPoint
    var size: CGFloat
    var brightness: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
