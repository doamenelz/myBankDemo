//
//  ConfirmationView.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-28.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct ConfirmationView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var status: Bool = true
    var screenToGoTo: MenuScreens = .login
    var body: some View {
        ZStack {
            BackGround()
            VStack (spacing: 30){
                Image(systemName: status ? SFIcons.success.rawValue : SFIcons.exclaimation.rawValue)
                    .resizable()
                    .foregroundColor(status ? Color("ctSuccess") : Color("ctError"))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                CompletedView(title: status ? "Success" : "Failed", subtitle: "Completed successfully")
                //Spacer()
                Button(action: {
                    self.viewRouter.currentPage = self.screenToGoTo
                }) {
                    if status == true {
                        Text("Continue").modifier(ButtonText())
                        .modifier(PrimaryBtn())
                    } else {
                        Text("Go back").modifier(ButtonText())
                        .modifier(SecondaryBtn())
                    }
                }

            }
        }
        
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
