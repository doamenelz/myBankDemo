//
//  SendMoneyRoot.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-07-12.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct SendMoneyRoot: View {
    
    @State var showRootView: Bool = true
    @State var showTransactionPreview: Bool = false
    @State var showConfirmationView: Bool = false
    
    //Start with
    
    
    var body: some View {
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        
    }
}

struct SendMoneyRoot_Previews: PreviewProvider {
    static var previews: some View {
        SendMoneyRoot()
    }
}
