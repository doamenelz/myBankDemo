//
//  StartUpView.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct StartUpPage: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
       private var viewController: UIViewController? {
        self.viewControllerHolder.value
       }
    
    
    //@State var showLogin: Bool = true
    
    var body: some View {
        ZStack {
            BackGround(image: "Floater2")
            VStack (spacing: 40) {
                Logo()
                VStack (spacing: 25) {
                    Button(action: {
                        self.viewController?.present(presentationStyle: .fullScreen) {
                            LoginPage()
                        }
                    }) {
                        Text("Sign in").modifier(ButtonText())
                            .modifier(PrimaryBtn())
                    }
                    
                    Button(action: {
                        self.viewController?.present(presentationStyle: .fullScreen) {
                            Registration()
                        }
                        
                    }) {
                        Text("Sign up").modifier(ButtonText())
                            .modifier(SecondaryBtn())
                    }//.sheet(isPresented: $showLogin) {
                       // PlayHouse()
                    //}
                }
            }
        }
        
        
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpPage()
    }
}

struct Logo: View {
    var body: some View {
        Image("Logo")
    }
}

