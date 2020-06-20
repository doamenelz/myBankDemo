//
//  PlayHouse.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-11.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct PlayHouse: View {
      var status: Bool = true
      var icon: String = "checkmark.circle.fill"
      var body: some View {
          NavigationView {
              ZStack {
                  BackGround()
                  VStack (){
                      Image(systemName: status ? SFIcons.success.rawValue : SFIcons.exclaimation.rawValue)
                          .resizable()
                          .foregroundColor(status ? Color("ctSuccess") : Color("ctError"))
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 60, height: 60)
                      CompletedView(title: status ? "Success" : "Failed", subtitle: "Completed successfully")
                  }
                  .padding(.horizontal, 38)
                  //.frame(width: screenWidth - 76)
                  
                  VStack (spacing: 10) {
                      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                          if status == true {
                              Text(status ? "Continue" : "Go back").modifier(ButtonText())
                              .modifier(PrimaryBtn())
                          } else {
                              Text(status ? "Continue" : "Go back").modifier(ButtonText())
                              .modifier(SecondaryBtn())
                          }
                          
                          
                              
                      }
                      
                      NavigationLink(destination: OTPVerification()) {
                          Text("Continue").modifier(ButtonText())
                              .modifier(PrimaryBtn())
                      }
                      Color(.clear)
                      .frame(height: 64)
                  }
                  .offset(y: screenHeight / 3)
                  
              }
          }
      }
}

struct PlayHouse_Previews: PreviewProvider {
    static var previews: some View {
        PlayHouse()
    }
}
