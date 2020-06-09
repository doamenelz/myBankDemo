//
//  ButtonModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width

struct ButtonModifiers: View {
    var body: some View {
        
        ZStack {
            Color("dark")
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20) {
                Button(action: {
                    print("Button Pressed")
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/).modifier(ButtonText()).frame(width: screenWidth - 38)
                }.modifier(PrimaryBtn())
                
                Button(action: {
                    print("Button Pressed")
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/).modifier(ButtonText()).frame(width: screenWidth - 38)
                }.modifier(SecondaryBtn())
                
            }
        }

        
    }
}

struct ButtonModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ButtonModifiers()
    }
}

struct PrimaryBtn: ViewModifier {

    func body(content: Content) -> some View {
        content
        .frame(height: 64)
        //.frame(width: screenWidth - 38)
        .background(Color("p1"))
        .cornerRadius(8)
        
    }
    
}

struct SecondaryBtn: ViewModifier {

    func body(content: Content) -> some View {
        content
        .overlay(
            RoundedRectangle(cornerRadius: 8)
            .stroke(Color("p1"), lineWidth: 1)
                .frame(height: 64)
        )
        .frame(height: 64)
        .background(Color("dark"))
    }
    
}

struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 20)).foregroundColor(Color(.white)).frame(width: screenWidth - 38)
    }

}

struct TFMod: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 20)).foregroundColor(Color(.white)).frame(width: screenWidth - 38)
    }

}
