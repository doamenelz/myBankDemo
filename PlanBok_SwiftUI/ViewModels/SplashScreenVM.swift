//
//  SplashScreenVM.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SplashScreen1: View {
    
    init() {
        UINavigationBar.appearance().isUserInteractionEnabled = false
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = .blue
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .clear
    }
    
    var pageModel = Pages.all()
    
    @State var goToStartup: Bool = false
    @State var splashCompleted: Bool = false
    
    @State var currentPage: Int = 0
    @State var width1: CGFloat = 35
    @State var width2: CGFloat = 10
    @State var width3: CGFloat = 10
    @State var page1Selected: String = FontColors.purple.rawValue
    @State var page2Selected: String = FontColors.tb4.rawValue
    @State var page3Selected: String = FontColors.tb4.rawValue
    
    private func changePageControl () {
        
        let pageControlModel = PageControl(width1: 35, width2: 10, width3: 10).changePageControl(currentPage: currentPage)
        
        width1 = pageControlModel.width1
        width2 = pageControlModel.width2
        width3 = pageControlModel.width3
        page1Selected = pageControlModel.page1Selected
        page2Selected = pageControlModel.page2Selected
        page3Selected = pageControlModel.page3Selected
 
    }
    
    private func showNextSlide () {
        if self.currentPage <= 1  {
            self.currentPage += 1
            self.changePageControl()
        } else {
            self.splashCompleted.toggle()
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                BackGround(image: "FloaterA")
                
                SP1(icon: pageModel[currentPage].icon, title: pageModel[currentPage].title, subtitle: pageModel[currentPage].subtitle).offset(y: -50)
                    .gesture(
                           DragGesture(minimumDistance: 50)
                               .onEnded { _ in
                                if self.currentPage <= 1  {
                                    self.currentPage += 1
                                    self.changePageControl()
                                } else {
                                    self.currentPage = 0
                                    self.changePageControl()
                                }
                               }
                       )
                        
                HStack {
                    HStack {
                        Color(page1Selected)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .frame(width: width1, height: 5)
                        Color(page2Selected)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .frame(width: width2, height: 5)
                        Color(page3Selected)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .frame(width: width3, height: 5)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.showNextSlide()
                    }) {
                        if currentPage == 2 {
                            NavigationLink(destination: StartUpPage()) {
                                Text("Lets get started").modifier(H4(color: .white))
                            }
                            
                        } else {
                            Text("Next").modifier(H4(color: .white))
                        }
                    }
                    
                }
                .padding(.horizontal, 38)
                .offset(y: screenHeight / 3)
                
            }
        }
        
     }
}

struct SplashScreen1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashScreen1().previewDevice("iPhone 11 Pro Max")
            SplashScreen1().previewDevice("iPhone 11 Pro")
            SplashScreen1().previewDevice("iPhone 8")
        }
        
    }
}


//MARK: - Subviews
struct SP1: View {

    var icon: String = "IconSmile"
    var title: String = "Send money quickly to friends"
    var subtitle: String = "PlanBok provides a quick way to send funds to friends"

    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Image(icon)
                .animation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0))
            Text(title).modifier(H1(color: .white))
            Text(subtitle).modifier(H3(color: .grey))
        }
        .frame(width: screenWidth - 76)
    

    }
}

struct BackGround: View {
    
    var image: String = "Floater2"
    var body: some View {
        ZStack {
            Color("dark")
                .edgesIgnoringSafeArea(.all)
            Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenWidth)
            .offset(y: -screenHeight / 3 )
        }
        
    }
}




