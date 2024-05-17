//
//  LevelsView.swift
//  plink
//
//  Created by Кирилл Архипов on 12.05.2024.
//

import SwiftUI

struct LockedLevelView: View {
    var body: some View {
        Text("Пройдите предыдущие уровни")
    }
}

struct LevelsView: View {
    @ObservedObject var model : ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showWarningLocked = false
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text(Image(systemName: "arrow.left"))
                .modifier(greenButton())
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                backButton
                Spacer()
                NavigationLink {
                    SettingsView(model: model)
                } label: {
                    Text(Image(systemName: "gearshape.fill"))
                        .modifier(greenButton())
                }
            }.padding()

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
                ForEach (model.levels, id: \.number) { level in
                    if (level.isOpened) {
                        NavigationLink {
                            GameView(currLevel: level.number, model: model)
                        } label: {
                            ZStack {
                                Image("block")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Image("ball")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 80)
                            }
                        }
                    }
                    else {
                        Button(action: {showWarningLocked.toggle()}, label: {
                            ZStack {
                                Image("block")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Image("lock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 70)
                            }
                        })
                    }
                    
                    
                }
            }).padding(20)
            Spacer()
            NavigationLink {
                HighScoreView(model: model)
            } label: {
                Text("HIGH SCORE")
                    .modifier(greenButton())
            }
            .padding()
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showWarningLocked, content: {
            Alert(title: Text("Заблокировано"), message: Text("Пройдите предыдущие уровни"), dismissButton: .default(Text("ОК")))
        })
        .background(
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: -742,y: 0)
        )
        .onAppear() {
            if model.vibrationSetting {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
    }
}

#Preview {
    LevelsView(model: ViewModel())
}
