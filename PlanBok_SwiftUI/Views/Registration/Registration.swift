//
//  Registration.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-10.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import Firebase

struct Registration: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }

    //MARK:- State Outlets
    @State var email = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var continueReg: Bool = false
    @State var invalidEmail: Bool = false
    @State var invalidPassword: Bool = false
    @State var passwordMisMatch: Bool = false
    
    //MARK: Functions
    func createUser (email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Login Successfully")
                    //self.continueReg.toggle()
                self.viewController?.present(presentationStyle: .fullScreen) {
                    RegisterBio()
                }

            }
            
        }
    }
    
    //MARK: - Body
    var body: some View {

        ZStack {
            BackGround()
            
            //MARK: Body Stack
            VStack {
                //Spacer()
                RegistrationOutlets(email: $email, password: $password, confirmPassword: $confirmPassword, invalidEmail: $invalidEmail, invalidPassword: $invalidPassword, passwordMisMatch: $passwordMisMatch)
                Spacer()
                
            }
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
            .padding(.top, K.CustomUIConstraints.topPadding)
            
            //MARK: - Continue and Field validation
            VStack (spacing: 10) {
                
                //Create User Button
                Button(action: {
                    if (self.password != "") && (self.email != "") && (self.confirmPassword == self.password) {
                        self.createUser(email: self.email, password: self.password)
                    }
                    
                }) {
                    Text("Continue").modifier(ButtonText())
                        .modifier(PrimaryBtn())
                }
                
                //To Login Outlets
                HStack {
                    Text("Already a member?")
                        .font(.custom("Rubik-Medium", size: FontHelper.textSize(textStyle: .body))).foregroundColor(Color(Colors.white.rawValue))
                    
                    Button(action: {
                        self.viewController?.present(presentationStyle: .fullScreen) {
                            LoginPage()
                        }
                        
                    }) {
                        Text("Sign in")
                            .font(.custom("Rubik-Medium", size: FontHelper.textSize(textStyle: .body))).foregroundColor(Color(Colors.p1.rawValue))
                    }
                    
                }
                .modifier(TertiaryBtn())
            }
            .offset(y: K.CustomUIConstraints.bottomButtonDistance)
        }
        .modifier(DismissingKeyboard())
        

    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Registration().previewDevice("iPhone 8")
            //Registration().previewDevice("iPhone 11")
            Registration().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct RegistrationTitle: View {
    var title: String = "Verification"
    var subtitle: String = "Please enter code that sent to your phone number in the form below. This code will expired in 01:00 minute."
    
    var body: some View {
        VStack (alignment: .leading, spacing: 25) {
            Text(title).modifier(H1(color: .white))
            Text(subtitle).modifier(H4(color: Colors.grey))
        }
        
    }
}

struct RegistrationOutlets: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var invalidEmail: Bool
    @Binding var invalidPassword: Bool
    @Binding var passwordMisMatch: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 25) {
            Text("Registration").modifier(H1(color: .white))
            
            VStack (alignment: .leading) {
                Text("Email")
                    .modifier(TextFieldLbl())
                    .multilineTextAlignment(.leading)
                
                TextField("Enter your Email", text: $email,
                          onCommit: {
                            if self.email == "" {
                                self.invalidEmail = true
                                
                            } else {
                                self.invalidEmail = false
                            }
                    })//.modifier(Keyboard())
                    .autocapitalization(.none)
                    .modifier(TxtF(invalidField: invalidEmail))
                    .keyboardType(.emailAddress)
                
            }
            
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
            
            VStack (alignment: .leading) {
                Text("Confirm password")
                    .modifier(TextFieldLbl())
                    .multilineTextAlignment(.leading)
                
                SecureField("Confirm your password", text: $confirmPassword,
                            onCommit: {
                                if self.confirmPassword == self.password {
                                    self.passwordMisMatch = false
                                } else {
                                    self.passwordMisMatch = true
                                }
                    
                    })
                    .modifier(TxtF(invalidField: passwordMisMatch))
                    
                
                if passwordMisMatch == true {
                    Text("Provide a valid password").modifier(TextFieldLbl(color: "ctError")).multilineTextAlignment(.leading).foregroundColor(.red)
                }

            }
            
        }
        
    }
}
