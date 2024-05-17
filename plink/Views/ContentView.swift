//
//  ContentView.swift
//  plink
//
//  Created by Кирилл Архипов on 10.05.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
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
                        //.resizable()
                        //.aspectRatio(contentMode: .fit)
                        Text("\(model.currLevel)")
                            .foregroundColor(.white)
                            .font(.custom("Rounded Mplus 1c", size: 24))
                            .shadow(radius: 0, x: 0, y: 2)
                            .shadow(radius: 8, x: 0, y: 2)
                    }
                    
                    .scaleEffect(0.9)
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 30).strokeBorder(.white, lineWidth: 6))
                    //.offset(y:-60)
                    Spacer()
                    VStack (spacing: 26) {
                        NavigationLink {
                            LevelsView(model: model)
                        } label: {
                            Text("START")
                                .modifier(redButton())
                        }
                        NavigationLink {
                            HighScoreView(model: model)
                        } label: {
                            Text("HIGH SCORE")
                                .modifier(greenButton())
                        }
                    }
                    Spacer()
                    
                }
                .onAppear() {
                    if model.vibrationSetting {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                }
                .background(
                    //                Image("bg")
                    //                    .resizable()
                    //                    .scaledToFill()
                    //                    .ignoresSafeArea()
                    //                    .offset(x: -350,y: 0)
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: -geometry.size.width * 0.9, y: 0)
                )
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
}

#Preview {
    ContentView()
}
