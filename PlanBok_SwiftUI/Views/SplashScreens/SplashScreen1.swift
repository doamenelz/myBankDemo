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
    
    @State var currentPage: Int = 2
    
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

struct SP1: View {

    var icon: String = "IconSmile"
    var title: String = "Send money quickly to friends"
    var subtitle: String = "PlanBok provides a quick way to send funds to friends"

    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Image(icon)
              //  .animation(Animation.easeOut(duration: 0.6).delay(0.1))
                //.animation(.spring(response: 10.0, dampingFraction: 20.0))
            Text(title).modifier(H1(color: .white)).lineLimit(4)
            //.animation(Animation.easeOut(duration: 0.6).delay(0.3))
            //.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            Text(subtitle).modifier(H3(color: .grey)).lineLimit(4)
        }

    }
}


