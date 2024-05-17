//
//  SettingsView.swift
//  plink
//
//  Created by Кирилл Архипов on 12.05.2024.
//

import SwiftUI



struct SettingsView: View {
    @ObservedObject var model : ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isResetAlert = false
    
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
                }.padding()
                HStack {
                    Spacer()
                    Text("SETTINGS")
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                }.padding(.vertical, 50)
                ScrollView {
                    Toggle("VIBRATION", isOn: $model.vibrationSetting)
                        .toggleStyle(ColoredToggleStyle(label: "VIBRATION", onColor: Color.greenButton, offColor: Color.gray,thumbColorOff: Color.white, thumbColorOn: Color.purple))
                        .foregroundColor(.white)
                    
                }.padding(.horizontal, 20)
                Spacer()
                Button(action: {isResetAlert = true}, label: {
                    Text("RESET PROGRESS")
                        .modifier(redButton())
                        .padding()
                })
                .alert(isPresented: $isResetAlert, content: {
                    Alert(title: Text("Are you sure?"), message: Text("All your completed levels will be locked!"), primaryButton: .cancel(), secondaryButton: .default(Text("Reset"), action: {
                        model.resetProgress()
                        isResetAlert = false
                    }))
                })
            }
            .background(
                CustomBackground()
            )
            .onAppear() {
                if model.vibrationSetting {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        
    }
        
}

#Preview {
    //ContentView()
    SettingsView(model: ViewModel())
}
