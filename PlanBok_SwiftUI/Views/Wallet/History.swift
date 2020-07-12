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
    
    var category: [String] = ["Shopping", "Food"]
    
    var customerTransactions: [CustomerTransaction] = [sampleCustomerTransaction, sampleCustomerTransaction, sampleCustomerTransaction]
    
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
                                //Graphs()
                                HistoryOverview().animation(.easeInOut(duration: 0.5))
                            }
                            else if self.displayedView == .categories {
                                StatisticsView(customerTransactions: self.customerTransactions, category: self.category)//.animation(.linear)
                            } else if self.displayedView == .graphs {
                                Graphs(categories: self.category, customerTransactions: self.customerTransactions)
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
        VStack (spacing: 30) {
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
                Text("Expenses")
                
            }
            Button(action: {
                self.switchView = .graphs
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
            .padding(.horizontal, 40)
            .padding(.vertical, 50)
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
    
    @State var catIndex: Int = 0
    
    @State var showPicker: Bool = false
    
    @State var total: Double = 0.0
    
    @State var categoryTotal: Double = 0.0
    
    let tran = Transaction.all()
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 20) {
                
                HStack {
                    Text("Expenses").modifier(H4(color: .white))
                    Spacer()
                }.animation(.linear(duration: 0.3))
                
                Button(action: {
                    self.showPicker.toggle()
                }) {
                    CategoryDropDown(isExpanded: $isExpanded, total: $total, category: $category[catIndex])
                }.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))//.animation(.easeIn(duration: 0.5))
                
                ScrollView (.vertical, showsIndicators: false) {
                    
                    ForEach(self.customerTransactions) { transaction in
                        if transaction.category == self.category[self.catIndex] {
                            TransactionCell(transaction: transaction).onAppear {
                                self.total += transaction.amount
                                
                            }
                        }
                    }
                }.animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))//.animation(.spring())// easeIn(duration: 0.2))
            }
            
            if showPicker {
                
                VStack {
                    CustomPicker(data: category, selectedIndex: $selectedCat).onAppear() {
                        //self.categoryTotal = 0.0
                    }
                    Button(action: {
                        self.showPicker.toggle()
                        self.catIndex = self.selectedCat
                        self.total = self.categoryTotal
                        
                    }) {
                        Text("DONE").modifier(H4(color: .white)).padding(.bottom)
                    }
                }
            }
            
        }
        
    }
}

struct CategoryCard: View {
    
    var icon: String
    
    @Binding var total : Double
    
    @State var categoryTotal: Double = 0.0
    
    @Binding var isSelected: Bool
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: 15) {
                HStack {
                    Image(icon).renderingMode(.original)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(icon).modifier(TextFieldLbl(color: isSelected ? Colors.white.rawValue : Colors.grey.rawValue))
                    
                }
            }
        }
            
        .padding(.vertical, 15)
        .frame(width: 150)
        .background(Color(isSelected ? Colors.tb4.rawValue : Colors.darkTextField.rawValue))
        .cornerRadius(30)
    }
    
}

enum HistorySubView {
    case categories
    case overview
    case graphs
}

struct HistoryOverview: View {
    
    let cT = [sampleCustomerTransaction, sampleCustomerTransaction, sampleCustomerTransaction, sampleCustomerTransaction]
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

struct Graphs: View {
    
    @State var selected = 0
    
    @State var total: Double = 0.0
    
    @State var selectedCat: Int = 0
    
    @State var id: Int = 0
    
    @State var isSelected: Bool = true
    
    @State var isDeselected: Bool = false
    
    @State var selectedBar: WeekD = .mn
    
    var categories : [String]
    
    var customerTransactions: [CustomerTransaction]
    
    var colors = [Color("p1"),Color("p5")]
    
    @State var customerGraphData: [GraphDays] = [graD]
    
    @State var categoryTotal: Double = 0.0
    
    @State var transactionCount: Int = 0
    
    @State var transactionCountTotal: Int = 1
    
    @State var dailyAmount: Double = 0.0
    
    @State var barFrame: CGFloat = 0.0
    
    @State var summaryDate: String = ""

    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Overview").modifier(H4(color: .white))
            
            GeometryReader { g in
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        HStack (spacing: 20) {
                            VStack (alignment: .leading, spacing: 5) {
                                Text(self.summaryDate).modifier(TextFieldLbl(color: "white"))
                                Text("\(self.transactionCount) Transactions").modifier(H6(color: .grey))
                                Text("$ \(self.dailyAmount)").modifier(H6(color: .p1))
                            }.padding(.top, 5)
                            
                            
                        }
                        Spacer()
                    }
                    
                    GeometryReader { geometry in
                        HStack(spacing: 15){
                            ForEach(self.customerGraphData) { data in
                                VStack {
                                    
                                    Spacer()
                                    
                                    RoundedShape()
                                        .fill(LinearGradient(gradient: .init(colors: self.selectedBar == data.weekD ? self.colors: [Color.white.opacity(0.06)]), startPoint: .top, endPoint: .bottom))
                                        .frame(height: barHeight(value: data.transactionCount, frame: self.barFrame, graphTotal: self.transactionCountTotal))
                                    
                                    Text(data.weekD.rawValue)
                                        .modifier(H6(color: self.selectedBar == data.weekD ? .p1 : .white))
                                    
                                }.onTapGesture {
                                    withAnimation (.easeInOut) {
                                        self.selectedBar = data.weekD
                                        self.transactionCount = data.transactionCount
                                        self.summaryDate = data.weekD.rawValue
                                        self.dailyAmount = data.transactionTotal
                                    }
                                }.onAppear {
                                    self.transactionCount = data.transactionCount
                                    self.dailyAmount = data.transactionTotal
                                    self.selectedBar = data.weekD
                                    self.barFrame = geometry.size.height
                                    self.summaryDate = data.weekD.rawValue
                                    print(data.weekD)
                                }
                            }
                        }.padding(.top)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.categories, id: \.self) { i in
                                Button(action: {
                                    self.id = self.categories.firstIndex(of: i)!
                                    self.total = getTotal(customerTransactions: self.customerTransactions, category: i)
                                    self.transactionCountTotal = createCustomerGraphData(customerTransaction: self.customerTransactions, category: self.categories[self.id]).total
                                    //self.transa
                                    self.customerGraphData = createCustomerGraphData(customerTransaction: self.customerTransactions, category: self.categories[self.id]).graphData
                                }) {
                                    if i == self.categories[self.id] {
                                        CategoryCard(icon: i, total: self.$total, isSelected: self.$isSelected)
                                    } else {
                                        CategoryCard(icon: i, total: self.$total, isSelected: self.$isDeselected)
                                    }
                                    
                                }.onAppear {
                                    self.total = getTotal(customerTransactions: self.customerTransactions, category: i)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                }.onAppear {
                    self.categoryTotal = getTotal(customerTransactions: self.customerTransactions, category: self.categories[self.id])
                    
                }

                .cornerRadius(10)
            }.onAppear {
                self.customerGraphData = createCustomerGraphData(customerTransaction: self.customerTransactions, category: self.categories[self.id]).graphData
                self.transactionCountTotal = createCustomerGraphData(customerTransaction: self.customerTransactions, category: self.categories[self.id]).total
            }

        }
        
    }
}

struct GraphData {
    let id = UUID()
    let graphDays: GraphDays
}

struct GraphDays: Identifiable {
    let id = UUID()
    var transactionCount: Int
    var transactionTotal: Double
    var graphTotal: Int
    
    
    var weekD: WeekD
}

func barHeight (value: Int, frame: CGFloat, graphTotal: Int) -> CGFloat {
    
    var bar: CGFloat = 0.0
    
    if value != 0 {
        let height = CGFloat(value) / CGFloat(graphTotal)

        bar = height * frame

    } else {
        bar = 0.0
    }
    
    return bar
}

enum WeekD: String {
    case mn = "Mon"
    case t = "Tue"
    case w = "Wed"
    case th = "Thu"
    case fr = "Fri"
    case sa = "Sat"
    case su = "Sun"
}

func createCustomerGraphData (customerTransaction: [CustomerTransaction], category: String) -> (graphData: [GraphDays], total: Int) {
    
    var graphData: [GraphDays] = []
    var mon: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .mn)
    var sun: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .su)
    var tue: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .t)
    var wed: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .w)
    var th: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .th)
    var fr: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .fr)
    var sat: GraphDays = GraphDays(transactionCount: 0, transactionTotal: 0.0, graphTotal: 0, weekD: .sa)
    
    var total: Double = 0.0
    var graphTotal: Int = 0
    
    let calendar = Calendar(identifier: .gregorian)
    for transaction in customerTransaction {
        
        if transaction.category == category {
            let dateF = calendar.component(.weekday, from: transaction.firebaseDate)
            
            switch dateF {
            case 1:
                sun.transactionCount += 1
                sun.transactionTotal += transaction.amount
                graphTotal += 1
                //sun.graphTotal = total
            case 2:
                mon.transactionCount += 1
                mon.transactionTotal += transaction.amount
                total += mon.transactionTotal
                //mon.graphTotal = total
                graphTotal += 1
            case 3:
                tue.transactionCount += 1
                tue.transactionTotal += transaction.amount
                //total += tue.transactionTotal
                graphTotal += 1
                //tue.graphTotal = total
            case 4:
                wed.transactionCount += 1
                wed.transactionTotal += transaction.amount
                graphTotal += 1
                //total += wed.transactionTotal
                //wed.graphTotal = total
            case 5:
                th.transactionCount += 1
                th.transactionTotal += transaction.amount
                graphTotal += 1
                //total += th.transactionTotal
                //th.graphTotal = total
            case 6:
                fr.transactionCount += 1
                fr.transactionTotal += transaction.amount
                graphTotal += 1
                //total += fr.transactionTotal
                //fr.graphTotal = total
            case 7:
                sat.transactionCount += 1
                sat.transactionTotal += transaction.amount
                graphTotal += 1
                //total += sat.transactionTotal
                //sat.graphTotal = total
            default:
                print("today's date is sdsdsd \(transaction.firebaseDate)")
            }
        }
    }
    
    graphData = [sun, mon, tue, wed, th, fr, sat]
    return (graphData: graphData, total: graphTotal)
    
}

func getTotal (customerTransactions: [CustomerTransaction], category: String) -> Double {
    var total: Double = 0.0
    let today = Date()
    
    
    for tran in customerTransactions {
        if tran.category == category {
            if tran.firebaseDate >= Calendar.current.date(byAdding: .day, value: -7, to: today)! {
                total += tran.amount
            }
            
        }
    }
    return total
}

struct RoundedShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        
        return Path(path.cgPath)
    }
}

let graD = GraphDays(transactionCount: 2, transactionTotal: 1000, graphTotal: 1000, weekD: .mn)
let grak = GraphDays(transactionCount: 1, transactionTotal: 5000, graphTotal: 5000, weekD: .w)
   
