//
//  MainView.swift
//  AwardsCollectionApp
//
//  Created by Alexey Efimov on 17.06.2021.
//

import SwiftUI

struct MainView: View {
    @State private var awardIsShowing = false
    
    var body: some View {
        VStack {
            Button(action: buttonAction) {
                Text(awardIsShowing ? "Hide Award" : "Show Award")
                Spacer()
                Image(systemName: "chevron.up.square")
                    .rotationEffect(.degrees(awardIsShowing ? 0 : 180))
                    .scaleEffect(awardIsShowing ? 2 : 1)
            }
            
            Spacer()
            if awardIsShowing {
                StarMapView()
                    .frame(width: 300, height: 300)
                    .transition(.hyperspace) // Use custom hyperspace transition
            }
               
            Spacer()
        }
        .font(.headline)
        .padding()
    }
    
    private func buttonAction() {
        withAnimation {
            awardIsShowing.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension AnyTransition {
    static var hyperspace: AnyTransition {
        let insertion = AnyTransition
            .scale(scale: 2)
            .combined(with: .opacity)
        let removal = AnyTransition.identity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
