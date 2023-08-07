//
//  BearsView.swift
//  AwardsCollectionApp
//
//  Created by Даниил Чупин on 07.08.2023.
//

import SwiftUI

struct Star: Identifiable, Hashable {
    var id = UUID()
    var position: CGPoint
    var size: CGFloat
    var brightness: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct StarMapView: View {
    @State private var showStars = false
    @State private var showConstellations = false
    @State private var showMoon = false
    @State private var showPlanets = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                
                if showStars {
                    drawStars(size: geometry.size) // Shining stars
                }
                if showConstellations {
                    drawConstellations(size: geometry.size) // Cassiopeia constellation
                }
                if showMoon {
                    drawMoon(size: geometry.size) // Moon
                }
                if showPlanets {
                    drawPlanets(size: geometry.size) // Jupiter and Neptune
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showStars = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    showConstellations = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    showPlanets = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    showMoon = true
                }
            }
        }
    }
    
    func drawStars(size: CGSize) -> some View {
        let starCount = 200
        var stars: [Star] = []
        for _ in 0..<starCount {
            let starSize = CGFloat.random(in: 1...4) // Random star size
            let starBrightness = Double.random(in: 0.1...1.0) // Random star brightness
            let starPosition = CGPoint(x: CGFloat.random(in: 0...size.width),
                                       y: CGFloat.random(in: 0...size.height))
            let star = Star(position: starPosition,
                            size: starSize,
                            brightness: starBrightness)
            stars.append(star)
        }
        
        return ZStack {
            ForEach(stars) { star in
                Circle()
                    .fill(Color.white.opacity(star.brightness))
                    .frame(width: star.size, height: star.size)
                    .position(star.position)
                    .modifier(TwinkleAnimationModifier())
            }
        }
    }
    
    func drawConstellations(size: CGSize) -> some View {
        let cassiopeia = Path { path in
            path.move(to: CGPoint(x: size.width * 0.2, y: size.height * 0.7))
            path.addLine(to: CGPoint(x: size.width * 0.3, y: size.height * 0.9))
            path.addLine(to: CGPoint(x: size.width * 0.5, y: size.height * 0.6))
            path.addLine(to: CGPoint(x: size.width * 0.7, y: size.height * 0.9))
            path.addLine(to: CGPoint(x: size.width * 0.8, y: size.height * 0.7))
        }
            .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .foregroundColor(.white)
        
        let cassiopeiaStars: [Star] = [
            Star(position: CGPoint(x: size.width * 0.2, y: size.height * 0.7),
                 size: 6,
                 brightness: 1.0),
            Star(position: CGPoint(x: size.width * 0.3, y: size.height * 0.9),
                 size: 5,
                 brightness: 1.0),
            Star(position: CGPoint(x: size.width * 0.5, y: size.height * 0.6),
                 size: 7,
                 brightness: 1.0),
            Star(position: CGPoint(x: size.width * 0.7, y: size.height * 0.9),
                 size: 5,
                 brightness: 1.0),
            Star(position: CGPoint(x: size.width * 0.8, y: size.height * 0.7),
                 size: 6,
                 brightness: 1.0),
        ]
        
        let smileyArc1 = Path { path in
            // Draw a smaller arc above Jupiter
            let startAngle = Angle.degrees(120)
            let endAngle = Angle.degrees(240)
            path.addArc(
                center: CGPoint(x: size.width * 0.4, y: size.height * 0.45),
                radius: size.width * 0.05,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
        }
            .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .foregroundColor(.blue)
        
        let smileyArc2 = Path { path in
            // Draw a smaller arc above Neptune
            let startAngle = Angle.degrees(120)
            let endAngle = Angle.degrees(240)
            path.addArc(
                center: CGPoint(x: size.width * 0.6, y: size.height * 0.45),
                radius: size.width * 0.05,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
        }
            .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .foregroundColor(.orange)
        
        let ears = Path { path in
            // Draw ears using triangles
            let earWidth: CGFloat = size.width * 0.12
            let leftEarTop = CGPoint(x: size.width * 0.36,
                                     y: size.height * 0.32)
            let rightEarTop = CGPoint(x: size.width * 0.64,
                                      y: size.height * 0.32)
            let leftEarBottom = CGPoint(x: size.width * 0.42,
                                        y: size.height * 0.22)
            let rightEarBottom = CGPoint(x: size.width * 0.58,
                                         y: size.height * 0.22)
            path.move(to: leftEarTop)
            path.addLine(to: leftEarBottom)
            path.addLine(to: CGPoint(x: leftEarTop.x + earWidth,
                                     y: leftEarTop.y))
            path.move(to: rightEarTop)
            path.addLine(to: rightEarBottom)
            path.addLine(to: CGPoint(x: rightEarTop.x - earWidth,
                                     y: rightEarTop.y))
        }
            .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .foregroundColor(.white)
        
        let whiskers = Path { path in
            // Draw whiskers using lines
            let startY: CGFloat = size.height * 0.5
            let whiskerLength: CGFloat = size.width * 0.1
            let whiskerSpacing: CGFloat = size.width * 0.03
            
            let planet1X = size.width * 0.4
            let planet2X = size.width * 0.6
            
            for angle in [30, 0, -30] {
                // Whiskers on the right side (Jupiter)
                let startX1 = planet1X - 50
                let endX1 = startX1 - whiskerLength * cos(Angle.degrees(Double(angle)).radians)
                let endY1 = startY + whiskerLength * sin(Angle.degrees(Double(angle)).radians)
                path.move(to: CGPoint(x: startX1, y: startY))
                path.addLine(to: CGPoint(x: endX1, y: endY1))
                path.move(to: CGPoint(x: startX1 + whiskerSpacing, y: startY))
                path.addLine(to: CGPoint(x: endX1 + whiskerSpacing, y: endY1))
                
                // Whiskers on the left side (Neptune)
                let startX2 = planet2X + 50
                let endX2 = startX2 + whiskerLength * cos(Angle.degrees(Double(angle)).radians)
                let endY2 = startY + whiskerLength * sin(Angle.degrees(Double(angle)).radians)
                path.move(to: CGPoint(x: startX2, y: startY))
                path.addLine(to: CGPoint(x: endX2, y: endY2))
                path.move(to: CGPoint(x: startX2 - whiskerSpacing, y: startY))
                path.addLine(to: CGPoint(x: endX2 - whiskerSpacing, y: endY2))
            }
        }
            .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .foregroundColor(.white)
        
        return ZStack {
            cassiopeia
            smileyArc1
            smileyArc2
            ears
            whiskers
            ForEach(cassiopeiaStars) { star in
                Circle()
                    .fill(Color.white)
                    .frame(width: star.size, height: star.size)
                    .position(star.position)
            }
        }
    }
    
    func drawMoon(size: CGSize) -> some View {
        let moonSize = CGSize(width: 80, height: 80)
        let blurRadius: CGFloat = 5
        
        return ZStack {
            // Moon body with shining effect and blurred border
            Circle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [.white, .gray]),
                    center: .center,
                    startRadius: 0,
                    endRadius: moonSize.width / 2
                ))
                .frame(width: moonSize.width, height: moonSize.height)
                .position(x: size.width * 0.8, y: size.height * 0.2)
                .blur(radius: blurRadius)
            
            PulsatingHeart()
                .foregroundColor(.red)
                .frame(width: 30, height: 30)
                .position(x: size.width * 0.8, y: size.height * 0.2)
        }
    }
    
    func drawPlanets(size: CGSize) -> some View {
        let planetSize = CGSize(width: 30, height: 30)
        let glowRadius: CGFloat = 10
        
        return ZStack {
            // Jupiter
            Circle()
                .fill(Color.orange)
                .frame(width: planetSize.width, height: planetSize.height)
                .position(x: size.width * 0.4, y: size.height * 0.5)
                .shadow(color: .orange, radius: glowRadius) // Add a subtle glow effect
            
            // Neptune
            Circle()
                .fill(Color.blue)
                .frame(width: planetSize.width, height: planetSize.height)
                .position(x: size.width * 0.6, y: size.height * 0.5)
                .shadow(color: .blue, radius: glowRadius)
        }
    }
}

struct ConstellationCatView_Previews: PreviewProvider {
    static var previews: some View {
        StarMapView()
            .frame(width: 400, height: 400)
    }
}

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
