//
//  History.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-19.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct History: View {
    let transactions = Transaction.all()
    
    var body: some View {
        
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            GeometryReader { geometryReader in
                VStack (spacing: 40) {
                    HistoryHeader().padding(.horizontal, K.CustomUIConstraints.hPadding)
                    
                    HStack {
                        Text("This Month").modifier(H3(color: .white))
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            SectionBtn(iconType: .asset)
                        }
                        
                    }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                    
                    /*
                    ScrollView {
                        VStack (spacing: 20) {
                            
                            ForEach(self.transactions) { transaction in
                                TransactioCell(transaction: transaction)
                                
                            }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                            
                        }
                    }
                    */
                    

 
                    //Spacer()
                }
                Spacer()
                
                
            }.padding(.top, K.CustomUIConstraints.topPadding)
            
            SecondaryNavigation(header: "History")
            
        }
        
        
        
        
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History().previewDevice("iPhone 11 Pro Max")
    }
}

struct HistoryHeader: View {
    var body: some View {
        VStack (spacing: 10) {
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    Text("Balance").modifier(H7(color: .grey))
                    Text("$2,3433.45").modifier(H3(color: .white))
                }
                Spacer()
                Image("visa")
            }
        
            HStack {
                Text("****").modifier(H4(color: .grey))
                Text("3456").modifier(H4(color: .grey))
                Spacer()
                
            }
        
        
        }.padding(.vertical)
    }
}
