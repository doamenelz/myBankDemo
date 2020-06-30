//
//  RegistrationViewModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-20.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

class RegistrationVM: ObservableObject  {
    
    @Published var isLoggedIn: Bool = false
    //@Binding var showLogin: Bool
    
    init() {
        isLoggedIn = false
    }
    
    func loginUser (email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                //self.isLoggedIn = true
                print("I just logged in")
                
                //self.showLogin = true
                print(error?.localizedDescription ?? "")
            } else {
                print("Your logged in email is \(email), password: \(password)")
            }
        }
    }
    
    func createUser (email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Login Successfully")
                self.isLoggedIn.toggle()
            }
            
        }
    }
    
    static func generateCustomerID () -> Int {
        let number: Int = Int(arc4random_uniform(1000000))
        return number
    }
    
    
    
}
