//
//  ForgotPwdCompleted.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct ForgotPwdCompleted: View {
    
    var status: Bool = true
    var icon: String = "checkmark.circle.fill"
    
    var title: String = "Success"
    var subtitle: String = "Please enter code that sent to your phone number in the form below. This code will expired in 01:00 minute."
    
    var body: some View {
        NavigationView {
            ZStack {
                BackGround()
                VStack (alignment: .leading){
                    Image(systemName: status ? IconsEnum.success.rawValue : IconsEnum.exclaimation.rawValue)
                        .resizable()
                        .foregroundColor(status ? Color("ctSuccess") : Color("ctError"))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    VStack (alignment: .leading, spacing: 15) {
                        Text(title).modifier(H1(color: .white))
                        Text(subtitle).modifier(H4(color: FontColors.grey))
                    }
                    
                }
                .offset(y: K.CustomUIConstraints.topTextContraints)
                .padding(.horizontal, K.CustomUIConstraints.horizontalPadding)
                
                VStack (spacing: 10) {
                    Button(action: {
                        
                    }) {
                        if status == true {
                            Text(status ? "Continue" : "Go back").modifier(ButtonText())
                            .modifier(PrimaryBtn())
                        } else {
                            Text(status ? "Continue" : "Go back").modifier(ButtonText())
                            .modifier(SecondaryBtn())
                        }
                    }
                    Color(.clear)
                    .frame(height: 64)
                    
                }
                .offset(y: K.CustomUIConstraints.bottomButtonDistance)
                
            }
        }
    }
}

struct ForgotPwdCompleted_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPwdCompleted()
    }
}

struct CompletedView: View {
    var title: String = "Verification"
    var subtitle: String = "Please enter code that sent to your phone number in the form below. This code will expired in 01:00 minute."
    
    var body: some View {
        VStack (spacing: 15) {
            Text(title).modifier(H1(color: .white))
            Text(subtitle).modifier(H4(color: FontColors.grey))
        }
            //.padding(.horizontal, 38)
        //.offset(y: -screenHeight / 4.5)
        //.offset(y: -screenHeight / 10)
    }
}
