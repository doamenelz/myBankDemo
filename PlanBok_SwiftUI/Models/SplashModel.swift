//
//  SplashModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SplashModel: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SplashModel_Previews: PreviewProvider {
    static var previews: some View {
        SplashModel()
    }
}

struct Pages {
    let icon: String
    let title: String
    let subtitle: String
}

extension Pages {
    static func all() -> [Pages] {
      
        return [
            Pages(icon: "IconSmile", title: "Send Money Quickly to friends", subtitle: "PlanBok provides a quick way to send funds to friends"),
            Pages(icon: "IconDivide", title: "Real time money transfers", subtitle: "E-Banking Transfers made easy"),
            Pages(icon: "IconStopWatch", title: "Get Special discounts to your favorite stores", subtitle: "From all retail stores, making shopping easy")
        
        ]
    }
    
        
    
}

class PageControl {
    
    var width1: CGFloat = 30
    var width2: CGFloat = 10
    var width3: CGFloat = 10
    var page1Selected: String = FontColors.purple.rawValue
    var page2Selected: String = FontColors.tb4.rawValue
    var page3Selected: String = FontColors.tb4.rawValue
    
    init(width1: CGFloat, width2: CGFloat, width3: CGFloat) {
        self.width1 = width1
        self.width2 = width2
        self.width3 = width3
    }
    
    func changePageControl (currentPage: Int) -> (width1: CGFloat, width2: CGFloat, width3: CGFloat, page1Selected: String, page2Selected: String, page3Selected: String) {
        
        switch currentPage {
        case 0:
            width1 = 30
            width2 = 10
            width3 = 10
            page1Selected = FontColors.purple.rawValue
            page2Selected = FontColors.tb4.rawValue
            page3Selected = FontColors.tb4.rawValue
        case 1:
            width1 = 10
            width2 = 30
            width3 = 10
            page1Selected = FontColors.tb4.rawValue
            page2Selected = FontColors.purple.rawValue
            page3Selected = FontColors.tb4.rawValue
            
        case 2:
            width1 = 10
            width2 = 10
            width3 = 30
            page1Selected = FontColors.tb4.rawValue
            page2Selected = FontColors.tb4.rawValue
            page3Selected = FontColors.purple.rawValue
            
        default:
            width1 = 30
            width2 = 10
            width3 = 10
            page1Selected = FontColors.purple.rawValue
            page2Selected = FontColors.tb4.rawValue
            page3Selected = FontColors.tb4.rawValue
        }
     return (width1, width2, width3, page1Selected, page2Selected, page3Selected)
    }
    
    
    
}


