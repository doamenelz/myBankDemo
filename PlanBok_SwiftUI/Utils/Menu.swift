//
//  Menu.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-12.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct Menu: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let menus = MenuData.all()
    var name: String = "Camilla Lindstrom"
    var icon: String = "MenuSelected"
    var body: some View {
        ZStack {
            //BackGround()
            VStack {
                HStack (spacing: 20) {
                    Button(action: {
                        //self.viewRouter.currentPage = .wallet
                        
                    }) {
                        Avatar()
                    }
                    VStack (alignment: .leading) {
                        Text("Hello,").modifier(H6(color: .grey))
                        Text(name).modifier(H4(color: .white))
                    }
                    Spacer()
                    Button(action: {
                        //self.viewRouter.currentPage = .wallet
                        self.presentationMode.wrappedValue.dismiss()
                        
                        
                    }) {
                        Image(icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: K.CustomUIConstraints.menuIconFrame)
                            .foregroundColor(Color("p1"))
                    }
                    
                }.padding(.horizontal, 30)
                    .padding(.top)
                Spacer()
                VStack {
                    ForEach(menus) { menu in
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            MenuCell(menu: menu)
                        }
                        
                    }
                }
                Spacer()
                Image("Logo")
            }.padding([.bottom,.top], 50)
            
        }.background(BlurView(style: .dark)).edgesIgnoringSafeArea(.all)
        //.blur(radius: 1)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Menu().previewDevice("iPhone 8").environmentObject(ViewRouter())
            Menu().previewDevice("iPhone 11 Pro Max").environmentObject(ViewRouter())
        }
        
    }
}

struct MenuCell: View {
    var menu: MenuData
    var body: some View {
        Text(menu.menuLabel)
            .modifier(H4(color: .grey))
            .frame(maxWidth: .infinity)
            .padding(25)
    }
}

struct Avatar: View {
    var body: some View {
        Image("Avatar4")
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
}

struct MenuData: Identifiable {
    let id = UUID()
    let menuLabel: String
    let menuScreen: MenuScreens
    
}

extension MenuData {
    static func all() -> [MenuData] {
        return [
            MenuData(menuLabel: MenuScreens.wallet.rawValue, menuScreen: .wallet),
            MenuData(menuLabel: MenuScreens.sendMoney.rawValue, menuScreen: .sendMoney),
            MenuData(menuLabel: MenuScreens.transfers.rawValue, menuScreen: .transfers),
            MenuData(menuLabel: MenuScreens.vouchers.rawValue, menuScreen: .vouchers),
            MenuData(menuLabel: MenuScreens.contacts.rawValue, menuScreen: .contacts),
            MenuData(menuLabel: MenuScreens.settings.rawValue, menuScreen: .settings)
        ]
    }
    
}

enum MenuScreens: String {
    case wallet = "Wallet"
    case sendMoney = "Send Money"
    case transfers = "Transfers"
    case vouchers = "Vouchers"
    case contacts = "Contacts"
    case settings = "Settings"
    case menu = "Menu"
    case login = "Login"
    case signUp = "Registration"
    case startUp = "StartUpPage"
}

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}




