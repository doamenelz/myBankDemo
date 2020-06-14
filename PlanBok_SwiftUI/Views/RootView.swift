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
                Home()
            } else if viewRouter.currentPage == .menu {
                Menu()
                    .transition(.scale)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(ViewRouter())
        
    }
}
