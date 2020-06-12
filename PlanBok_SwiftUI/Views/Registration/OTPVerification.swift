//
//  OTPVerification.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct OTPVerification: View {
    
    @ObservedObject var verificationCode = TextBindingManager(limit: 4)
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //@GestureState private var dragOffset = CGSize.zero
    
    @State var toSetPassword: Bool = false
    
    var body: some View {
        
        ZStack {
            BackGround()
            RegistrationTitle(title: "Verification", subtitle: "Please enter code that sent to your phone number in the form below. This code will expired in 01:00 minute.")
            TextFldNIcons(placeHolder: "Enter your verification code", textValue: verificationCode.text, invalidField: true, label: "")
                .keyboardType(.numberPad)
                .offset(y: -screenHeight / 15)
            VStack (spacing: 10) {
                Button(action: {
                    self.toSetPassword.toggle()
                }) {
                    Text("Continue").modifier(ButtonText())
                        .modifier(PrimaryBtn())
                }.sheet(isPresented: $toSetPassword) {
                    SetPassword()
                }
                Button(action: {
                    //Enter retry method
                }) {
                    Text("Resend").modifier(ButtonText()).modifier(TertiaryBtn())
                }
            }
            .offset(y: K.CustomUIConstraints.bottomButtonDistance)
        }
            
//        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
//
//            if(value.startLocation.x < 20 && value.translation.width > screenWidth / 2) {
//                self.presentationMode.wrappedValue.dismiss()
//            }
//
//        }))

    }
    
}

struct OTPVerification_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OTPVerification().previewDevice("iPhone 8")
            OTPVerification().previewDevice("iPhone 11 Pro Max")
            OTPVerification().previewDevice("iPhone 11 Pro")
        }
    }
}

struct OTPField: View {
    @State var placeHolder: String
    @State var textValue: String
    
    @State var invalidField: Bool = true
    @State var startedTyping: Bool = false
    
    var label: String = "Label"
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $textValue)
                .padding(.horizontal)
            
            .frame(width: 64, height: 64)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(startedTyping ? Color("p1") : Color("dark"), lineWidth: 1)
            )
            .background(Color("darkTextFld"))
            .cornerRadius(8)
            .modifier(ButtonText())
        }
        .keyboardType(.numberPad)
        .frame(width: 64, height: 64)
        
    }

    
}

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 1){
        characterLimit = limit
    }
}


