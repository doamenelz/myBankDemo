//
//  LoginModel.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-27.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class LoginM: ObservableObject {
    
        
    @Published var loginResponse: Bool?
    
    //@Binding var isSuccessful: Bool
    
     func createUser (email: String, password: String)  {
        //var isSuccessful: Bool = false
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.loginResponse = false
                //return loginResponse
                
            } else {
                print("Login Successfully")
                self.loginResponse = true
                //self.continueReg.toggle()
            }
          
        }
        //return loginResponse!
        
        
    }
}


