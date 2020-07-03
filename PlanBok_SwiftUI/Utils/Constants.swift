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
let TRANSACTIONS_REF = "transactions"


struct Cards_Ref {
    static let cardName = "name"
    static let cardNumber = "cardNumber"
    static let expiryDate = "expiryDate"
    static let cvc = "cvc"
    static let cardProvider = "cardProvider"
    static let balance = "balance"
    
}

struct Transaction_Ref {
    static let amount = "amount"
    static let type = "type"
    static let date = "date"
    static let from = "from"
    static let recipient = "recipient"
    static let image = "image"
    static let narration = "narration"
    static let sender = "sender"
    static let category = "category"
}

var CURRENT_USER_EMAIL: String = ""
var CURRENT_USER_UID: String = ""

let IMAGE_PATH = "gs://mybank-b47ca.appspot.com/avatars/gs:/mybank-b47ca.appspot.com/"
let DEFAULT_IMAGE = "https://nationalpostcom.files.wordpress.com/2019/09/portraitofaladyonfire_02.jpg?quality=80&strip=all&w=780"

let SAMPLE_IMAGE_URL = URL(string: DEFAULT_IMAGE)








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
