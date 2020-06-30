//
//  ButtonModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI



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
                
                SecondaryButton(label: "Secondary")
                
            }
        }

        
    }
}

struct ButtonModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ButtonModifiers()
    }
}

struct PrimaryButton: View {
    var label: String = "Button"
    var body: some View {
        HStack {
            Text(label)
                .modifier(H4(color: .white))
                .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color(Colors.p1.rawValue))
        .cornerRadius(8)
    }
}

struct SecondaryButton: View {
    var label: String = "Button"
    var body: some View {
        HStack {
            Text(label)
                .modifier(H4(color: .white))
                .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("p1"), lineWidth: 2)
                //.frame(height: 60)
                .frame(maxWidth: .infinity)
        )
            .background(Color.clear)
            .cornerRadius(8)
    }
}



struct PrimaryBtn: ViewModifier {

    func body(content: Content) -> some View {
        content
        .frame(height: 60)
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
                .frame(height: 60)
        )
        .frame(height: 60)
        .background(Color("dark"))
    }
    
}

struct TertiaryBtn: ViewModifier {

    func body(content: Content) -> some View {
        content
        .frame(height: 60)
            .background(Color(.clear))
    }
    
}

struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("Rubik-Regular", size: 18)).foregroundColor(Color(.white)).frame(width: screenWidth - 76)
    }

}




struct BackBtn: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: SFIcons.chevronLeft.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                .foregroundColor(.white)
            }
            
            
            
        }
    }
}

struct GoBack: View {
    var body: some View {
        Image(systemName: SFIcons.chevronLeft.rawValue)
        .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .frame(height: 24)
        .padding()
    }
}
