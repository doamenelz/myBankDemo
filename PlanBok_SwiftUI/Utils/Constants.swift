//
//  Constants.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
//let windowV = UIApplication.shared.keyWindow
//let guide = UIScreen.main.nativeBounds
//let topPadding = windowV?.safeAreaInsets.top



struct K {
    
    struct CustomUIConstraints {
        static let bottomButtonDistance = screenHeight / 2 - 120
        static let topTextContraints = -screenHeight / 4.5
        static let horizontalPadding: CGFloat = 38.0
        static let hPadding: CGFloat = 30.0
        static let menuIconFrame: CGFloat = 24.0
        static let topPadding: CGFloat = 75
    }
}




//MARK: - Firebase Constants
let USERS_REF = "users"
let NAME = "name"
let CUSTOMER_ID = "customerID"
let PHONE_NUMBER = "phoneNumber"
let BVN = "bvn"
let ADDRESS = "address"
let AVATAR = "avatar"
let PREFERRED_LANGUAGE = "preferredLanguage"
let CARDS = "cards"
let CUSTOMERS_REF = "customers"
let CUSTOMER_AVATAR = "avatar"
let CREATED_REF = "created"

let CARDS_REF = "cards"


struct Cards_Ref {
    static let cardName = "name"
    static let cardNumber = "cardNumber"
    static let expiryDate = "expiryDate"
    static let cvc = "cvc"
    static let cardProvider = "cardProvider"
    static let balance = "balance"
    
}

var CURRENT_USER_EMAIL: String = ""
var CURRENT_USER_UID: String = ""








extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<SomeView: View>(to view: SomeView, when binding: Binding<Bool>) -> some View {
        modifier(NavigateModifier(destination: view, binding: binding))
    }
}


// MARK: - NavigateModifier
fileprivate struct NavigateModifier<SomeView: View>: ViewModifier {

    // MARK: Private properties
    fileprivate let destination: SomeView
    @Binding fileprivate var binding: Bool


    // MARK: - View body
    fileprivate func body(content: Content) -> some View {
        NavigationView {
            ZStack {
                content
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                NavigationLink(destination: destination
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                               isActive: $binding) {
                    EmptyView()
                }
            }
        }
    }
}
