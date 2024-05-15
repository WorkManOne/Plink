//
//  LaunchView.swift
//  plink
//
//  Created by Кирилл Архипов on 14.05.2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var angle = 0.0
    var body: some View {
        VStack {
            ZStack {
                Image("ball")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.7)
                    .offset(x: 0, y: -102)
                Image("title")
                    .resizable()
                    .scaledToFit()
            }//баг с отображением на ipad
            .padding(.top, 60)
            ZStack {
                Image("block")
            }
            
            .scaleEffect(0.9)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 30).strokeBorder(.white, lineWidth: 6))
            
            Circle()
                //.size(width: 200, height: 200)
                .stroke(lineWidth: 25)
                .foregroundColor(.white)
                .clipShape(Rectangle().offset(x:-100, y: 200))
                .rotationEffect(.degrees(angle), anchor: .center)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        angle = 360
                    }
                }
                .scaleEffect(0.2)
        }
        .background(
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: -350,y: 0)
        )
    }
}

#Preview {
    LaunchView()
}
