//
//  SendMoneyConfirmation.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-16.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SendMoneyConfirmation: View {
    
    @State var successfulPayment: Bool = false
    var body: some View {
        ZStack {
            BackGround(wallpaper: .none)
            //MARK: - Body Stack
            VStack {
                Spacer()
                SendMoneyContactPreview(successfulPayment: $successfulPayment)
                    .animation(.easeInOut(duration: 1))
                Spacer()
                SendMoneyBottomModal(makePayment: $successfulPayment)
                .animation(.easeInOut(duration: 1))
            }.padding(.top, K.CustomUIConstraints.topPadding)
            .edgesIgnoringSafeArea(.bottom)
            
            
            //MARK: - Nav Stack
            SecondaryNavigation(header: successfulPayment ? "Payment Completed!" : "Send Money")
            
        }
    }
}

struct SendMoneyConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SendMoneyConfirmation().previewDevice("iPhone 8")
            SendMoneyConfirmation().previewDevice("iPhone 11 Pro Max")
        }
    }
}

struct SendMoneyBottomModal: View {
    
    @Binding var makePayment: Bool
    
    var body: some View {
        
        VStack (spacing: 20) {
            
            if !makePayment {
                Button(action: {
                    
                }) {
                    PrimaryButton(label: "Confirm")
                }
                Button(action: {
                    self.makePayment.toggle()
                }) {
                    Text("Cancel").modifier(H4(color: .white))
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            if makePayment {
                VStack (spacing: 20) {
                    HStack {
                        Image("Avatar1")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .animation(.easeOut(duration: 0.3))
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("James Jack Daniels").modifier(H6(color: .white))
                            Text("Payment completed").modifier(TextFieldLbl())
                        }
                        .animation(.easeOut(duration: 0.8))
                        
                        Spacer()
                        
                        HStack (spacing: 10) {
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                IconsWrapped_Custom(icon: .arrowToBottom)
                            }
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                IconsWrapped_Custom(icon: .email)
                            }
                            
                            
                        }
                        
                        
                    }
                    HStack (spacing: 40) {
                        Button(action: {
                            
                        }) {
                            Text("Send another").modifier(H4(color: .white))
                        }
                        
                        Button(action: {
                            self.makePayment.toggle()
                            
                        }) {
                            PrimaryButton(label: "Done")
                        }

                    }
                }.animation(Animation.easeInOut(duration: 0.8))
            }
            
            
                        
            

        }
            
        .padding([.vertical,.horizontal], 30)
        .background(Color(Colors.tb4.rawValue))
            //.edgesIgnoringSafeArea(.all)
        .cornerRadius(20)
        
        
        
    }
}

struct SendMoneyContactPreview: View {
    
    @Binding var successfulPayment: Bool
    
    @State private var phase: CGFloat = 0
    
    var body: some View {
        ZStack {
            Circle()
            .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [5], dashPhase: phase)).foregroundColor(Color(Colors.darkTextField.rawValue)).opacity(0.8)
            .frame(width: 150, height: 150)
            .onAppear { self.phase -= 20 }
                .animation(Animation.linear.repeatForever(autoreverses: false))
            Circle()
                .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color(successfulPayment ? Colors.credit.rawValue : Colors.p4.rawValue), Color(Colors.tb4.rawValue)]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: successfulPayment ? 1 : 4, dash: [5], dashPhase: phase)).foregroundColor(Color(Colors.darkTextField.rawValue))
                .frame(width: 270, height: 270)
            .onAppear { self.phase -= 20 }
                .animation(Animation.linear.repeatForever(autoreverses: true).speed(0.1))
            
            Circle()
                .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [5])).foregroundColor(Color(Colors.darkTextField.rawValue)).opacity(0.8)
                .frame(width: 350, height: 350)
            
            
            VStack (spacing: 20) {
                if !successfulPayment {
                   Image("IconSmile")
                    .animation(.easeInOut(duration: 0.1))
                }
                
                VStack (spacing: 10) {
                    Text(successfulPayment ? "" : "Sending cash to").modifier(H6(color: successfulPayment ? .white : .grey))
                    .animation(.easeInOut(duration: 0.3))
                    Text("James Jack Daniels").modifier(H3(color: .white))
                    .animation(.easeInOut(duration: 0.6))
                }
                
                Image("Avatar1")
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                .cornerRadius(8)
                .animation(.easeInOut(duration: 0.8))
                
                Text("$ 300.00").modifier(H3(color: .white))
                .animation(.easeInOut(duration: 0.9))
                
                if successfulPayment {
                    Image(systemName: "checkmark.circle.fill")
                    .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(Colors.credit.rawValue))
                    .animation(.easeInOut(duration: 0.7))
                }
                
            }
        }
    }
}
