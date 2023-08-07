//
//  Mod.swift
//  AwardsCollectionApp
//
//  Created by Даниил Чупин on 07.08.2023.
//

import SwiftUI

struct TwinkleAnimationModifier: AnimatableModifier {
    var animatableData: Double {
        get { twinkleValue }
        set { twinkleValue = newValue }
    }
    
    @State private var twinkleValue = Double.random(in: 0...1)
    private var twinklingColors: [Color] = [
        .white, .yellow, .blue, .green, .red, .orange, .indigo, .mint
    ]
    
    func body(content: Content) -> some View {
        content
            .colorMultiply(twinklingColors.randomElement() ?? .white)
            .opacity(twinkleValue)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5)
                    .repeatForever(autoreverses: true)) {
                    twinkleValue = Double.random(in: 0...1)
                }
            }
    }
}
