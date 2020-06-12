//
//  SplashScreen1.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View {
    
    var pageModel = Pages.all()
    
    @State var currentPage: Int = 1
    
    var body: some View {
        ZStack {
            Color("dark")
                .edgesIgnoringSafeArea(.all)
             SP1(icon: pageModel[currentPage].icon, title: pageModel[currentPage].title, subtitle: pageModel[currentPage].subtitle)
            
            
        }
     }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        SplashScreenView().previewDevice("iPhone 11 Pro Max")
        SplashScreenView().previewDevice("iPhone 11 Pro")
            SplashScreenView().previewDevice("iPhone 8")
        }
        
    }
}

