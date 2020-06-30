//
//  ForgotPassword.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct ForgotPassword: View {
    var email: String = ""
    var body: some View {
        ZStack {
            BackGround()
            VStack {
                RegistrationTitle(title: "Forgot password", subtitle: "Please enter your email address set during registration")
            }
//            TextFldNIcons(placeHolder: "Enter your email", textValue: email, invalidField: true, label: "Email")
//            .offset(y: -screenHeight / 20)
            //.offset(y: -20)
                
            
            
            VStack (spacing: 10) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Continue").modifier(ButtonText())
                        .modifier(PrimaryBtn())
                }
                Color(.clear)
                    .frame(height: 64)

            }
            //.frame(height: 138)
            .offset(y: K.CustomUIConstraints.bottomButtonDistance)
            
            
        }
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForgotPassword().previewDevice("iPhone 8")
            ForgotPassword().previewDevice("iPhone 11")
            ForgotPassword().previewDevice("iPhone 11 Pro Max")
        }
    }
}
