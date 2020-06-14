//
//  ViewRouter.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-13.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class ViewRouter: ObservableObject {

    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: MenuScreens = .wallet {
        didSet {
            withAnimation() {
              objectWillChange.send(self)
            }
            
        }
    }
    

}
