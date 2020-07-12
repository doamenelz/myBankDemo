//
//  PGtest.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-07-12.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct PGTest: View {
    @State var showSecond = false
    @State var showThird = false

    var body: some View {
        VStack(spacing: 50) {
            Text("FirstView")
            Button("to SecondView") {
                self.showSecond = true
            }
            .sheet(isPresented: $showSecond) {
                VStack(spacing: 50) {
                    Text("SecondView")
                    Button("to ThirdView") {
                        self.showThird = true
                    }
                    .sheet(isPresented: self.$showThird) {
                        VStack(spacing: 50) {
                            Text("ThirdView")
                            Button("back") {
                                self.showThird = false
                            }
                            Button("back to FirstView") {
                                DispatchQueue.main.async {
                                    self.showThird = false
                                    DispatchQueue.main.async {
                                        self.showSecond = false
                                    }
                                }
                            }
                        }
                    }
                    Button("back") {
                        self.showSecond = false
                    }
                }
            }
        }
    }
}


struct PGTest_Previews: PreviewProvider {
    static var previews: some View {
        PGTest()
    }
}
