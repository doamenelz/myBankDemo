//
//  SetPassword.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

///Set Password View
struct SetPassword: View {
    var password: String = ""
    var confirmPassword: String = ""
    var body: some View {
        ZStack {
            BackGround()
            RegistrationTitle(title: "Set your password", subtitle: "")
            VStack (alignment: .leading, spacing: 40) {
                PasswordFld(placeHolder: "Enter your password", textValue: password, label: "Password")
                PasswordFld(placeHolder: "Confirm your password", textValue: confirmPassword, label: "Confirm password")
            }
            .padding(.horizontal, 38)
            VStack (spacing: 10) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Continue").modifier(ButtonText())
                        .modifier(PrimaryBtn())
                }
                Color(.clear)
                .frame(height: 64)
            }
            .offset(y: K.CustomUIConstraints.bottomButtonDistance)
        }
    }
}

struct SetPassword_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SetPassword().previewDevice("iPhone 8")
            SetPassword().previewDevice("iPhone 11 Pro Max")
            SetPassword().previewDevice("iPhone 11")
        }
    }
}
