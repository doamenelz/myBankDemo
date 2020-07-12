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
    
    var body: some View {
        ZStack {
            BackGround()
            VStack (spacing: 40) {
                Logo()
                VStack (spacing: 25) {
                    Button(action: {
                        self.viewController?.present(presentationStyle: .fullScreen) {
                            LoginPage()
                        }
                    }) {
                        PrimaryButton(label: "Sign in")
                    }
                    
                    Button(action: {
                        self.viewController?.present(presentationStyle: .fullScreen) {
                            Registration()
                        }
                        
                    }) {
                        SecondaryButton(label: "Sign Up")
                    }
                }
            }
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
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

