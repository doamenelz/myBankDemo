//
//  CPG.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-20.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import SwiftUI

struct TestCntact: View {
    
    @ObservedObject var store = ContactsStore()
    
    var body: some View {
//        List(store.contacts) { post in
//            Text(post.name)
//
//        }
        VStack{
            ForEach(store.contacts) { c in
                Text(c.name)
            }
        }
    }
}

struct TestCntact_Previews: PreviewProvider {
    static var previews: some View {
        TestCntact()
    }
}
