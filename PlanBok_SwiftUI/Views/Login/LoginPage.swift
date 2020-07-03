//
//  LoginPage.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginPage: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }

    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = "e.e@live.com"
    @State var password = "123456"
    @State var invalidEmail: Bool = false
    @State var invalidPassword: Bool = false
    
    //@State var password: String = ""
    
    func loginUser () {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                debugPrint(error?.localizedDescription ?? "")
            } else {
                guard let email = Auth.auth().currentUser?.email else {return}
                CURRENT_USER_EMAIL = email
                self.viewController?.present(presentationStyle: .fullScreen) {
                    WalletHome()
                }
                
            }
            
        }
        
    }
    
    
    var body: some View {
        ZStack {
            BackGround()
            VStack (alignment: .leading, spacing: 24) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 24)
                Text("Welcome back!").modifier(H2(color: .white))
                LoginOutlets(email: $email, password: $password, invalidEmail: $invalidEmail, invalidPassword: $invalidPassword)

                VStack (spacing: 30) {
                    Button(action: {
                        self.loginUser()
                        
                    }) {
                        Text("Sign in").modifier(ButtonText())
                            .modifier(PrimaryBtn())
                    }
                    HStack {
                        Text("Not yet a member?")
                        .font(.custom("Rubik-Medium", size: FontHelper.textSize(textStyle: .body))).foregroundColor(Color(Colors.white.rawValue))
                        
                        Button(action: {
                            
                        }) {
                            Text("Sign up")
                                .font(.custom("Rubik-Medium", size: FontHelper.textSize(textStyle: .body))).foregroundColor(Color(Colors.p1.rawValue))
                        }
                    }
                }
                .offset(y: 60)

            }.padding(.horizontal, 38)
            
            
        }
        .modifier(AdaptsToKeyboard())
        .modifier(DismissingKeyboard())
    

    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginPage().previewDevice("iPhone 8")
            LoginPage().previewDevice("iPhone 11")
            LoginPage().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct EmailTxtFld: View {
    var body: some View {
        Text("")
    }
}

struct LoginOutlets: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var invalidEmail: Bool
    @Binding var invalidPassword: Bool
    
    
    var body: some View {
        VStack (spacing: 30) {
            VStack (alignment: .leading) {
                Text("Email").modifier(TextFieldLbl()).multilineTextAlignment(.leading)
                TextField("Enter your Email", text: $email, onEditingChanged: { (changed) in
                    if changed {
                        
                    } else {
                        if self.email == "" {
                            self.invalidEmail = true
                            print("New field typing")
                            
                        } else {
                            self.invalidEmail = false
                            print("New field ended")
                        }
                    }
                    
                }, onCommit: {
                    if self.email == "" {
                        self.invalidEmail = true
                        print("New field typing")
                        
                    } else {
                        self.invalidEmail = false
                        print("New field ended")
                    }
                    
                    
                }).modifier(TxtF(invalidField: invalidEmail)).keyboardType(.emailAddress)
                
            }
            ZStack (alignment: .top) {
                Button(action: {
                    
                }) {
                    Text("Forgot Password?")
                        .font(.custom("Rubik-Medium", size: 12)).foregroundColor(Color(Colors.p1.rawValue))
                }
                .offset(x: screenWidth / 4)
                VStack (alignment: .leading) {
                    Text("Password").modifier(TextFieldLbl()).multilineTextAlignment(.leading)
                    SecureField("Enter your password", text: $password, onCommit: {
                            if self.password == "" {
                                self.invalidPassword = true
                                print("New field typing")
                                
                            } else {
                                self.invalidPassword = false
                                print("New field ended")
                            }
                        
                        
                    }).modifier(TxtF(invalidField: invalidPassword))
                    if self.invalidPassword == true {
                        Text("Provide a valid password").modifier(TextFieldLbl(color: "ctError")).multilineTextAlignment(.leading).foregroundColor(.red)
                    }

                    
                }
            }
        }
        
        
    }
}
