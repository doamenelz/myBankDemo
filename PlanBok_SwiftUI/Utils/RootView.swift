//
//  RootView.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-13.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    
//    var base: MenuScreens = .menu
//
//    func switchMenu () {
//        switch viewRouter.currentPage {
//        case .wallet:
//            Home()
//        default:
//            Menu()
//        }
//
//    }
    
    var body: some View {
        VStack {
            
            
            if viewRouter.currentPage == .wallet {
                WalletHome()
            } else if viewRouter.currentPage == .menu {
                Menu()
                    .transition(.scale)
            } else if viewRouter.currentPage == .contacts {
                Contacts(selectedContact: sampleContact)
            } else if viewRouter.currentPage == .startUp {
                StartUpPage()
            } else if viewRouter.currentPage == .login {
                LoginPage()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(ViewRouter())
        
    }
}
