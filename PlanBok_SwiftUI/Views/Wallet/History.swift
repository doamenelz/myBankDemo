//
//  History.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-19.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct History: View {
    
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }

    @State var showSubmenu: Bool = false
    @State var showPicker: Bool = false
    
    var customerCard: CustomerCard
    
    @State var displayedView: HistorySubView = .overview
    
    var category: [String] = []
    
    var customerTransactions: [CustomerTransaction] = []
    
    @State var selectedCat = 0
    
    var body: some View {
        
        ZStack {
            BackGround(wallpaper: .Floater2)
            
            GeometryReader { geometryReader in
                ZStack {
                    if self.showSubmenu {
                        ElipsisOption(switchView: self.$displayedView, hideMenu: self.$showSubmenu).zIndex(1)
                            .offset(x: geometryReader.size.width / 4, y: -geometryReader.size.height / 5)
                            .animation(.linear)
                    }
                    
                    VStack (spacing: 20) {
                        
                        //MARK: - Header
                        Button(action: {
                            self.showSubmenu.toggle()
                        }) {
                            HistoryHeader(showSubmenu: self.$showSubmenu, card: self.customerCard).padding(.horizontal, K.CustomUIConstraints.hPadding)
                        }
                        
                        //MARK: - Body
                        VStack {
                            if self.displayedView == .overview {
                                HistoryOverview().animation(.easeInOut(duration: 0.5))
                            }
                            else if self.displayedView == .categories {
                                StatisticsView(customerTransactions: self.customerTransactions, category: self.category)
                            }
                        }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                        
                    }
                }
                Spacer()
                
            }.padding(.top, K.CustomUIConstraints.topPadding)

            SecondaryNavigation(header: "History")
            
        }
        
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            History(customerCard: sampleCard).previewDevice("iPhone 11 Pro Max")
            History(customerCard: sampleCard).previewDevice("iPhone 8")
            //History(customerCard: sampleCard).previewDevice("iPhone 11")
            History(customerCard: sampleCard).previewDevice("iPhone 11 Pro")
            History(customerCard: sampleCard).previewDevice("iPhone 8 Plus")
        }
    }
}

struct HistoryHeader: View {
    
    @Binding var showSubmenu: Bool
    
    var card: CustomerCard
    
    var body: some View {
        ZStack {
            VStack (spacing: 10) {
                HStack {
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Balance").modifier(H7(color: .grey))
                        Text("\(self.card.balance)").modifier(H3(color: .white))
                    }
                    Spacer()
                    Image("\(self.card.cardProvider)").renderingMode(.original)
                    Image(systemName: "ellipsis").foregroundColor(showSubmenu ? Color(Colors.p1.rawValue) : .white).rotationEffect(Angle(degrees: 90))
                }
            
                HStack {
                    Text("****").modifier(H4(color: .grey))
                    Text("\(self.card.cardNumber)").modifier(H4(color: .grey))
                    Spacer()
                }
                        
            
            }.padding(.vertical)
        }
    }
}

struct ElipsisOption: View {
    
    @Binding var switchView : HistorySubView
    @Binding var hideMenu: Bool
    
    var body: some View {
        VStack (spacing: 20) {
            Button(action: {
                self.switchView = .overview
                self.hideMenu.toggle()
            }) {
                Text("Overview")
                
            }
            Button(action: {
                self.switchView = .categories
                self.hideMenu.toggle()
            }) {
                Text("Categories")
                
            }
            Button(action: {
                self.hideMenu.toggle()
            }) {
                Text("History")
                
            }
            Button(action: {
                self.hideMenu.toggle()
            }) {
                Text("Settings")
                
            }
        }.modifier(H6(color: .grey))
            .padding(.horizontal, 30)
            .padding(.vertical, 35)
            .background(BlurView(style: .dark))
            .shadow(radius: 10)
        .cornerRadius(8)
        .animation(.spring())
        //.modifier(BlurView(style: .systemChromeMaterialLight))
    }
}

struct StatisticsView: View {
    
    //@ObservedObject var customerTransactions = TransactionModel()
    
    var customerTransactions: [CustomerTransaction]
    
    @State var isExpanded: Bool = false
    
    @State var category: [String]
    
    @State var selectedCat: Int = 0
    
    @State var showPicker: Bool = false
    
    @State var total: Double = 0.0
    
    let tran = Transaction.all()
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 20) {
                
                HStack {
                    Text("Expenses").modifier(H4(color: .white))
                    Spacer()
                }
                
                Button(action: {
                    self.showPicker.toggle()
                    //uyself.total = self.customerTransactions.getTotal(transactions: self.customerTransactions.customerTransactions)
                    
                }) {
                    CategoryDropDown(isExpanded: $isExpanded, total: $total, category: $category[selectedCat])
                }
                
                ScrollView (.vertical, showsIndicators: false) {
                    
                    ForEach(self.customerTransactions) { transaction in
                        if transaction.category == self.category[self.selectedCat] {
                          TransactionCell(transaction: transaction)
                        }

                    }
                    
                }
                
            }
            
            if showPicker {
                
                VStack {
                    CustomPicker(data: category, selectedIndex: $selectedCat)
                    Button(action: {
                        self.showPicker.toggle()
                    }) {
                        Text("DONE").modifier(H4(color: .white)).padding(.bottom)
                    }
                }
            }
            
        }
    }
}

struct CategoryCard: View {
    
    var icon: TransactionCategory
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: 15) {
                HStack {
                    Image(icon.rawValue).renderingMode(.original)
                    .resizable()
                    .frame(width: 20, height: 20)
                    
                    Text(icon.rawValue).modifier(TextFieldLbl())
                }
                Text("-$ 513,0").modifier(H4(color: .white))
            }
        }
        
        .padding(.vertical, 10)
        //.padding(.leading)
        .frame(width: 150)
        .background(Color(Colors.darkTextField.rawValue))
    .cornerRadius(8)
    }
    
}

struct CategoriesSection: View {
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    CategoryCard(icon: .bills)
                }
                
                CategoryCard(icon: .shopping)
                CategoryCard(icon: .food)
                CategoryCard(icon: .transport)
            }
        }
    }
}

enum HistorySubView {
    case categories
    case overview
}

struct HistoryOverview: View {
    
    let cT = [sampleCustomerTransaction]
    var body: some View {
        VStack {
            HStack {
                Text("This Month").modifier(H4(color: .white))
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    SectionBtn(iconType: .asset)
                }
                
            }//.padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            ScrollView {
                VStack (spacing: 20) {
                    //Text("ll")
                    //                                ForEach(self.customerTransactions.customerTransactions) { transaction in
                    //                                    TransactionCell(transaction: transaction)
                    //
                    //                                }.padding(.horizontal, K.CustomUIConstraints.hPadding)
                    
                    ForEach(self.cT) { transaction in
                        TransactionCell(transaction: transaction)
                        
                    }//.padding(.horizontal, K.CustomUIConstraints.hPadding)
                    
                }
            }
            
        }
    }
}

struct CustomPicker : View {
    
    var data: [String] = []
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack(spacing: 1) {
            Spacer()
            
            Picker("Select a category",selection: $selectedIndex) {
            
                
                ForEach(0..<self.data.count) {
                    Text(self.data[$0])
                }
            }.foregroundColor(.white)
            .labelsHidden()
        }
        
    }
}

struct CategoryDropDown: View {
    @Binding var isExpanded: Bool
    @Binding var total: Double
    
    @Binding var category: String
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: 15) {
                HStack {
                    Image(category).renderingMode(.original)
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text(category).modifier(TextFieldLbl())
                }
                Text("$ \(total)").modifier(H4(color: .white))
            }
            
            Spacer()
            Image(systemName: isExpanded ? SFIcons.chevronUp.rawValue : SFIcons.chevronDown.rawValue)
                .frame(width: 20, height: 20)
                .foregroundColor(Color(Colors.p1.rawValue))
        }
            
        .padding()
        .background(Color(Colors.darkTextField.rawValue))
        .cornerRadius(8)
    }

}
