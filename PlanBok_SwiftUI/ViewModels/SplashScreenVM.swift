//
//  SplashScreenVM.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SplashScreen1: View {
    
    var pageModel = Pages.all()
    
    @State var currentPage: Int = 0
    
    @State var width1: CGFloat = 35
    @State var width2: CGFloat = 10
    @State var width3: CGFloat = 10
    @State var page1Selected: String = FontColors.purple.rawValue
    @State var page2Selected: String = FontColors.tb4.rawValue
    @State var page3Selected: String = FontColors.tb4.rawValue
    
    func changePageControl () {
        
        let pageControlModel = PageControl(width1: 35, width2: 10, width3: 10).changePageControl(currentPage: currentPage)
        
        width1 = pageControlModel.width1
        width2 = pageControlModel.width2
        width3 = pageControlModel.width3
        page1Selected = pageControlModel.page1Selected
        page2Selected = pageControlModel.page2Selected
        page3Selected = pageControlModel.page3Selected
 
    }
    
    var body: some View {
        ZStack {
            Color("dark")
                .edgesIgnoringSafeArea(.all)
            Image("Floater")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screenWidth)
                .opacity(0.3)
                .offset(x: screenWidth / 2, y: -screenHeight / 3 )
            
            SP1(icon: pageModel[currentPage].icon, title: pageModel[currentPage].title, subtitle: pageModel[currentPage].subtitle)
                .frame(width: screenWidth - 38)
                .animation(Animation.easeOut(duration: 0.2))
                .minimumScaleFactor(0.5)

            HStack {
                Button(action: {
                    
                    if self.currentPage <= 1  {
                        self.currentPage += 1
                        self.changePageControl()
                        //self.pageControlModel.changePageControl(currentPage: self.currentPage)
                    } else {
                        self.currentPage = 0
                        //self.pageControlModel.changePageControl(currentPage: self.currentPage)
                        self.changePageControl()
                    }
                    
                }) {
                    Text("Next").modifier(H4(color: .white))
                }
                
                Spacer()
                
                HStack {
                    Color(page1Selected)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .frame(width: width1, height: 10)
                   Color(page2Selected)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .frame(width: width2, height: 10)
                    Color(page3Selected)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .frame(width: width3, height: 10)
                }
                
                Spacer()
                
                Button(action: {
                   //Go to Login Screen
                    self.currentPage += 1
                }) {
                    Text("Skip").modifier(H4(color: .grey))
                }
            }
            .padding(.horizontal, 38)
            .offset(y: screenHeight / 3)
            
        }
     }
}

struct SplashScreen1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        //SplashScreen1().previewDevice("iPhone 11 Pro Max")
        SplashScreen1().previewDevice("iPhone 11 Pro")
            SplashScreen1().previewDevice("iPhone 8")
        }
        
    }
}



