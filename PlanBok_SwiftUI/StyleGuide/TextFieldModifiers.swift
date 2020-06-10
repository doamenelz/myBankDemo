//
//  TextFieldModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

enum IconsEnum: String {
    case chevronDownCircle = "chevron.down.circle.fill"
    case chevronDown = "chevron.down"
    case exclaimation = "exclamationmark.triangle.fill"
    
}

struct TextFieldModifiers: View {
    @State var text: String
    
    var body: some View {
        ZStack {
            Color("dark")
            .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20)  {
                TextFldWIcons(placeHolder: "Placeholder", textValue: text, icon: IconsEnum.chevronDownCircle.rawValue, label: "Text Field W Icons").frame(width: screenWidth - 38)
                TextFldNIcons(placeHolder: "Placeholder", textValue: text, label: "Text Field No Icons").frame(width: screenWidth - 38)
                PasswordFld(placeHolder: "Placeholder", textValue: text, label: "Password").frame(width: screenWidth - 38)
            }
            
        }
    }
}

struct TextFieldModifiers_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldModifiers(text: "Sample Text")
    }
}

struct TextFldWIcons : View {
    @State var placeHolder: String
    @State var textValue: String
    
    @State var invalidField: Bool = true
    @State var startedTyping: Bool = true
    @State var isSuccess: Bool = false
    
    
    @State var icon: String = IconsEnum.chevronDown.rawValue
    var label: String = "Label"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label).modifier(TextFieldLbl())
            
            ZStack {
                
                TextField(placeHolder, text: $textValue)
                .padding()
                    
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(startedTyping ? Color("p1") : Color("dark"), lineWidth: 1)
                )
                .background(Color("darkTextFld"))
                    .cornerRadius(8)
                
                
                Image(systemName: isSuccess ? icon : "")
                .foregroundColor(Color("ctSuccess"))
                    .padding(.leading, screenWidth - 100)
                
            }
        }
        .modifier(TFMod())
        
        
    }
}

struct TextFldNIcons : View {
    @State var placeHolder: String
    @State var textValue: String
    
    @State var invalidField: Bool = true
    @State var startedTyping: Bool = false
    
    var label: String = "Label"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label).modifier(TextFieldLbl())
            
            TextField(placeHolder, text: $textValue)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(startedTyping ? Color("p1") : Color("dark"), lineWidth: 1)
            )
            .background(Color("darkTextFld"))
            .cornerRadius(8)
        }
        .modifier(TFMod())
        
        
    }
}

struct PasswordFld : View {
    @State var placeHolder: String
    @State var textValue: String
    
    @State var invalidField: Bool = true
    @State var startedTyping: Bool = false
    
    var label: String = "Label"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label).modifier(TextFieldLbl())
            
            SecureField(placeHolder, text: $textValue)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(startedTyping ? Color("p1") : Color("dark"), lineWidth: 1)
            )
            .background(Color("darkTextFld"))
            .cornerRadius(8)
        }
        .modifier(TFMod())
        
        
    }
}
