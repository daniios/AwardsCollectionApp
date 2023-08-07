//
//  Animations.swift
//  AwardsCollectionApp
//
//  Created by Даниил Чупин on 07.08.2023.
//

import SwiftUI

struct Animations {
    static func animateStars(_ binding: Binding<Bool>) {
        withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
            binding.wrappedValue = true
        }
    }
    
    static func animateConstellations(_ binding: Binding<Bool>) {
        withAnimation(.easeIn(duration: 1.0).delay(1.5)) {
            binding.wrappedValue = true
        }
    }
    
    static func animatePlanets(_ binding: Binding<Bool>) {
        withAnimation(.linear(duration: 1.0).delay(3.0)) {
            binding.wrappedValue = true
        }
    }
    
    static func animateMoon(_ binding: Binding<Bool>) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1.0).delay(4.5)) {
            binding.wrappedValue = true
        }
    }
}
