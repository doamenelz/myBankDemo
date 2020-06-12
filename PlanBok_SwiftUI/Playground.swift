//
//  Playground.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-09.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

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
struct Navigation_CustomBackButton_Detail: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color("Theme3BackgroundColor")
            VStack(spacing: 25) {
                Image(systemName: "globe").font(.largeTitle)
                Text("NavigationView").font(.largeTitle)
                Text("Custom Back Button").foregroundColor(.gray)
                HStack {
                    Image("NavBarBackButtonHidden")
                    Image(systemName: "plus")
                    Image("NavBarItems")
                }
                Text("Hide the system back button and then use the navigation bar items modifier to add your own.")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Theme3ForegroundColor"))
                    .foregroundColor(Color("Theme3BackgroundColor"))

                Spacer()
            }
            .font(.title)
            .padding(.top, 50)
        }
        .navigationBarTitle(Text("Detail View"), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        // Hide the system back button
        .navigationBarBackButtonHidden(true)
        // Add your custom back button here
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle")
                    Text("Go Back")
                }
        })
    }
}

struct MenuView : View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var body : some View {
        VStack {
            Text("Settings")
                .foregroundColor(Color.white)
                
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.mode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                })
                .frame(maxWidth: .infinity, maxHeight : .infinity)
                .background(Color.blue)
                
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.mode.wrappedValue.dismiss()
            }
            
        }))
    }
}



//MARK: - Trying FUllVIew
struct ViewControllerHolder {
    weak var value: UIViewController?
    init(_ value: UIViewController?) {
        self.value = value
    }
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder { return ViewControllerHolder(UIApplication.shared.windows.first?.rootViewController ) }
}

extension EnvironmentValues {
    var viewController: ViewControllerHolder {
        get { return self[ViewControllerKey.self] }
        set { self[ViewControllerKey.self] = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(presentationStyle: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, animated: Bool = true, completion: @escaping () -> Void = {}, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = presentationStyle
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, ViewControllerHolder(toPresent))
        )
        if presentationStyle == .overCurrentContext {
            toPresent.view.backgroundColor = .clear
        }
        self.present(toPresent, animated: animated, completion: completion)
    }
}
