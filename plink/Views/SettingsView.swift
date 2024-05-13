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
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text(Image(systemName: "arrow.left"))
                .font(.title)
                .foregroundColor(.white)
                .shadow(radius: 0, y: 2)
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(Color("greenButton"))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(Color("borderButton"), lineWidth: 4))
        }
    }
    
    var body: some View {
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
        }
        .navigationBarHidden(true)
        .background(
            ScrollView {
                VStack {
                    Circle()
                        .foregroundColor(.blue)
                        .blur(radius: 130)
                        .offset(x:-150)
                    Circle()
                        .foregroundColor(.purple)
                        .blur(radius: 130)
                        .offset(x:150)
                }
            }.background(
                Color("bgColor")
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(.all)
            )
        )
    }
        
}

#Preview {
    SettingsView(model: ViewModel())
}
