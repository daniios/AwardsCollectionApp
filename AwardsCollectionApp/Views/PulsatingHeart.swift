//
//  PulsaringHeart.swift
//  AwardsCollectionApp
//
//  Created by Даниил Чупин on 07.08.2023.
//

import SwiftUI

struct PulsatingHeart: View {
    @State private var pulsate = false
    
    var body: some View {
        Image(systemName: "heart.fill")
            .scaleEffect(pulsate ? 2 : 1)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)) {
                    pulsate.toggle()
                }
            }
    }
}
