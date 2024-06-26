//
//  HighScoreView.swift
//  plink
//
//  Created by Кирилл Архипов on 12.05.2024.
//

import SwiftUI



struct HighScoreView: View {
    @ObservedObject var model : ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text(Image(systemName: "arrow.left"))
                .modifier(greenButton())
        }
    }
    
    var body: some View {
        NavigationView {
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
                HStack {
                    Spacer()
                    Text("HIGH SCORE")
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                }.padding(.vertical, 50)
                ScrollView (showsIndicators: false) {
                    ForEach(Array(model.topRecords.enumerated()), id: \.offset) { offset, item in
                        HStack {
                            Text("\(offset+1)")
                                .foregroundColor(.white)
                            Spacer()
                            Image("Alarm")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 20)
                                .foregroundColor(.white)
                            Text(item.steps != Int.max ? String(format: "%02d:%02d", Int(item.time/60), Int(item.time) % 60) : "-:-")
                                .foregroundColor(.white)
                            Spacer()
                            Image("Refresh")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 20)
                                .foregroundColor(.white)
                            
                            Text(item.steps != Int.max ? "\(item.steps)" : "-")
                                .foregroundColor(.white)
                        }.padding(.vertical, 10)
                    }
                }.padding(.horizontal, 20)
            }
            .background(CustomBackground())
            .onAppear() {
                if model.vibrationSetting {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
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
    HighScoreView(model: ViewModel())
}
