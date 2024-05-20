//
//  GameView.swift
//  plink
//
//  Created by Кирилл Архипов on 10.05.2024.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var currLevel : Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var model : ViewModel
    @ObservedObject private var game = GameModel()
    
    @State private var elapsedTime : TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "00:00"
    @State private var isSwiped = false
    @State private var isNewRecord = false
    @State private var isGameCompleted = false
    @State private var stepsLeft = 20
    @State private var isFirstMove = false
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text(Image(systemName: "arrow.left"))
                .modifier(greenButton())
        }
    }
    
    var backButtonDone : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("CONTINUE \(Image(systemName: "arrow.right"))")
                .modifier(redButton())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if (isGameCompleted) {
                    Spacer()
                    HStack { Spacer() }
                    VStack {
                        Text("GREAT!")
                            .font(.largeTitle)
                            .padding()
                        if isNewRecord {
                            Text("NEW RECORD!")
                                .foregroundColor(Color("greenButton"))
                                .font(.largeTitle)
                                .padding()
                        }
                        VStack (spacing: 80) {
                            HStack {
                                Image("Alarm")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text(timerString)
                            }
                            .scaleEffect(2.5)
                            
                            HStack {
                                Image("Refresh")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("\(stepsLeft)")
                            }
                            .scaleEffect(2.5)
                            
                        }
                        .padding(40)
                        
                        .frame(width: 300)
                        .padding()
                        
                    }
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical, 40)
                    Spacer()
                    backButtonDone
                        .padding()
                    NavigationLink {
                        ContentView(model: model)
                    } label: {
                        Text("MAIN MENU")
                            .modifier(greenButton())
                    }
                    
                }
                else {
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
                    HStack {
                        HStack {
                            Image("Alarm")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text(self.timerString)
                                .onReceive(timer) { _ in
                                    if self.isTimerRunning {
                                        elapsedTime = Date().timeIntervalSince(self.startTime)
                                        let minutes = Int(elapsedTime) / 60
                                        let seconds = Int(elapsedTime) % 60
                                        timerString = String(format: "%02d:%02d", minutes, seconds)
                                    }
                                }
                            
                        }.scaleEffect(1.5)
                        Spacer()
                        Button(action: {
                            if stepsLeft > 0 {
                                //print("stepBack")
                                if game.stepBack() {
                                    stepsLeft -= 1
                                }
                                
                            }
                        }, label: {
                            HStack {
                                Image("Refresh")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("\(stepsLeft)")
                            }.scaleEffect(1.5)
                        })
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 50)
                    VStack {
                        ForEach(0..<game.size, id: \.self) { i in //TODO: небезопасно?
                            HStack {
                                ForEach(0..<game.size, id: \.self) { j in //TODO: небезопасно?
                                    ZStack {
                                        Image("block")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        Text(game.field[i][j].name)
                                            .foregroundColor(.white)
                                            .font(.custom("Rounded Mplus 1c", size: 24))
                                            .shadow(radius: 0, x: 0, y: 2)
                                            .shadow(radius: 8, x: 0, y: 2)
                                    }.opacity(game.field[i][j].name == "0" ? 0.0 : 1.0)
                                        .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .global)
                                            .onEnded({ value in
                                                var isMoved = false
                                                let maxShift = max(abs(value.translation.width), abs(value.translation.height))
                                                if value.translation.width < 0 && maxShift == abs(value.translation.width) {
                                                    //print(game.field[i][j].name, " left")
                                                    isMoved = game.moveTo(direction: .left, position: (i,j))
                                                    
                                                }
                                                if value.translation.width > 0 && maxShift == abs(value.translation.width) {
                                                    //print(game.field[i][j].name, " right")
                                                    isMoved = game.moveTo(direction: .right, position: (i,j))
                                                    
                                                }
                                                if value.translation.height < 0 && maxShift == abs(value.translation.height) {
                                                    //print(game.field[i][j].name, " up")
                                                    isMoved = game.moveTo(direction: .up, position: (i,j))
                                                    
                                                }
                                                if value.translation.height > 0 && maxShift == abs(value.translation.height) {
                                                    //print(game.field[i][j].name, " down")
                                                    isMoved = game.moveTo(direction: .down, position: (i,j))
                                                    
                                                }
                                                //print(isMoved)
                                                if isMoved {
                                                    if !isFirstMove {
                                                        isFirstMove = true
                                                    }
                                                    if model.vibrationSetting {
                                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                                    }
                                                    if !isTimerRunning {
                                                        startTime = Date()
                                                        isTimerRunning = true
                                                    }
                                                }
                                                
                                                if (game.isDone) {
                                                    if (elapsedTime < model.levels[currLevel].timeRecord) {
                                                        model.levels[currLevel].timeRecord = elapsedTime
                                                        model.levels[currLevel].steps = stepsLeft
                                                        isNewRecord = true
                                                    }
                                                    model.unlockNext(prev: currLevel)
                                                    model.addNewRec(rec: Record(steps: stepsLeft, time: elapsedTime))
                                                    isTimerRunning = false
                                                    isGameCompleted = true
                                                }
                                                
                                            }))
                                }
                            }
                        }
                    }.padding()
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        game.shuffle()
                        
                    } label: {
                        Text("Random")
                            .modifier(redButton())
                    }
                    
                    Spacer()
                }
            }
            .background(CustomBackground())
            .onDisappear {
                //print("dissaperad")
                isTimerRunning = false
            }
            .onAppear {
                if model.vibrationSetting {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                if !isTimerRunning && isFirstMove {
                        startTime = Date() - elapsedTime
                        isTimerRunning = true
                }
                else {
                    game.shuffle()
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}

#Preview {
    //ContentView()
    GameView(model: ViewModel())
}
