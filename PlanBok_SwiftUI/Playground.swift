//
//  Playground.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Playground: View {
    
    @State var currentPage = 0
    var body: some View {
        pageCntrol(current: currentPage)
    }
}

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}

struct pageCntrol: UIViewRepresentable {
    
    var current = 0
    
    func makeUIView(context: UIViewRepresentableContext<pageCntrol>) -> UIPageControl {
     
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .black
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .gray
        
        return page
        
    }
    
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<pageCntrol>) {
        uiView.currentPage = current
        
    }
    
}
