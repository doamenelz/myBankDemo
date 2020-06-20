//
//  TextFieldModifiers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI


struct TextFieldModifiers: View {
    @State var text: String
    
    var body: some View {
        ZStack {
            Color("dark")
            .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20)  {
                TextFldWIcons(placeHolder: "Placeholder", textValue: $text, icon: SFIcons.chevronDownCircle.rawValue, label: "Text Field W Icons").frame(width: screenWidth - 38)
                TextFldNIcons(placeHolder: "Placeholder", textValue: text, invalidField: false, label: "Text Field No Icons").frame(width: screenWidth - 38)
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
    @Binding var textValue: String
    
    @State var invalidField: Bool = true
    @State var startedTyping: Bool = false
    @State var isSuccess: Bool = false
    
    
    @State var icon: String = SFIcons.chevronDown.rawValue
    var label: String = "Label"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label).modifier(TextFieldLbl())
            
            HStack {
                
                TextField(placeHolder, text: $textValue)
                    .multilineTextAlignment(.leading)
                    .padding()
                Image(systemName: isSuccess ? icon : "")
                    .foregroundColor(Color("ctSuccess"))
                    .frame(width: 15, height: 15)
                    .padding(.horizontal, 15)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSuccess ? Color("darkTextFld") : Color("ctError"), lineWidth: 1)
            )
            .background(Color("darkTextFld"))
            .cornerRadius(8)
        }
        .modifier(TFMod())
        
        
    }
}

struct TextFldNIcons : View {
    @State var placeHolder: String
    @State var textValue: String
    
    @State var invalidField: Bool
    //@State var startedTyping: Bool = false
    
    var label: String = "Label"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label).modifier(TextFieldLbl())
            
            TextField(placeHolder, text: $textValue, onEditingChanged: { (changed) in
                if changed {
                    
                } else {
                    if self.textValue == "" {
                        self.invalidField = true
                        print("New field typing")
                        
                    } else {
                        self.invalidField = false
                        print("New field ended")
                    }
                }
                
            }, onCommit: {
                
                if self.textValue == "" {
                    self.invalidField = true
                    print("New field typing")
                    
                } else {
                    self.invalidField = false
                    print("New field ended")
                }
                
            })
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 20)
                .padding(.leading, 24)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(invalidField ? Color("ctError") : Color("darkTextFld"), lineWidth: 1)
            )
            .background(Color("darkTextFld"))
            .cornerRadius(8)
        }
        .modifier(H6(color: .white))
        
        
    }
}

struct TxtF: ViewModifier {

    var invalidField: Bool
    //var color: FontColors
    func body(content: Content) -> some View {
        content.multilineTextAlignment(.leading)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(invalidField ? Color("ctError") : Color("darkTextFld"), lineWidth: 1)
        )
        .background(Color("darkTextFld"))
        .cornerRadius(8)
        .modifier(TFMod())
    }

}

struct PasswordFld : View {
    @State var placeHolder: String
    @State var textValue: String
    
    @State var invalidField: Bool = false
    @State var startedTyping: Bool = false
    
    var label: String = "Label"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label).modifier(TextFieldLbl())
            
            SecureField(placeHolder, text: $textValue)
                .multilineTextAlignment(.leading)
            .padding(.vertical, 20)
            .padding(.leading, 24)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(invalidField ? Color("ctError") : Color("dark"), lineWidth: 1)
            )
            .background(Color("darkTextFld"))
            .cornerRadius(8)
        }
        .modifier(TFMod())
        
        
    }
}
