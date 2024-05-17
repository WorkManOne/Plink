//
//  Customs.swift
//  plink
//
//  Created by Кирилл Архипов on 12.05.2024.
//

import SwiftUI

struct CustomBackground: View {
    var body : some View {
        //ScrollView (showsIndicators: false){
            VStack {
                HStack {Spacer()}
                Circle()
                    .foregroundColor(.blue)
                    .blur(radius: 130)
                    .offset(x:-150)
                Circle()
                    .foregroundColor(.purple)
                    .blur(radius: 130)
                    .offset(x:150)
            }
        //}
        .background(
            Color("bgColor")
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(.all)
        )
    }
}

struct greenButton : ViewModifier {
    func body(content: Content) -> some View {
        content
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

struct redButton : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
            .shadow(radius: 0, y: 2)
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            .background(Color("redButton"))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(Color("borderButton"), lineWidth: 4))
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColorOff = Color.white
    var thumbColorOn = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(configuration.isOn ? thumbColorOn : thumbColorOff)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

#Preview {
    CustomBackground()
}
