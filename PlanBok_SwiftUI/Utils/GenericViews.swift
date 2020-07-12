//
//  GenericViews.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-14.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI

struct GenericViews: View {
    
    @State var isOn: Bool = false
    var body: some View {
        ZStack {
            BackGround()
            VStack {
                VStack {
                    Button(action: {
                        self.isOn.toggle()
                    }) {
                        ButtonCell(isOn: $isOn, controlType: .none, label: "Trigger Toggle")
                    }
                    ButtonCell(isOn: $isOn, controlType: .switches, label: "Test")
                    RadioCell(isSelected: $isOn, label: "Radio Cell")
                    //Spacer()
                    RadioCell(isSelected: $isOn, label: "Radio Cell")
                    RadioCell(isSelected: $isOn, label: "Radio Cell")
                    Button(action: {
                        self.isOn.toggle()
                    }) {
                        ButtonCell(isOn: $isOn, controlType: .none, label: "Trigger Toggle")
                    }
                    CheckBox()
                }
                Spacer()
            }.padding(.top, K.CustomUIConstraints.topPadding)
            .padding(.horizontal, K.CustomUIConstraints.hPadding)
            
            
            Nav()
        }
    }
}

struct GenericViews_Previews: PreviewProvider {
    static var previews: some View {
        GenericViews()
    }
}

struct Nav: View {
    var header: String = "Generic Header"
    var rightIcon: String = "Menu"
    var leftIcon: String = "chevron.left"
    var body: some View {
        
        VStack {
            HStack {
             Image(systemName: leftIcon)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: 20, height: 20)
                 .foregroundColor(.white)
             Spacer()
             Text(header).modifier(H4(color: .white))
             Spacer()
             Button(action: {
                 
                
                }) {
                 Image(rightIcon)
                     .resizable()
                     //.renderingMode(editEnabled ? .original : .none)
                     .aspectRatio(contentMode: .fit)
                    .frame(width: K.CustomUIConstraints.menuIconFrame)
                     .foregroundColor(.white)
                }
            }.padding(.horizontal, 30)
                .padding(.vertical)
            
            Spacer()
        }
        
    }
}

struct ButtonCell: View {
    
    @Binding var isOn: Bool
    var controlType: ControlType
    var label: String
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 20) {
                
                if controlType == .switches {
                    Toggle(isOn: $isOn) {
                       Text(label).modifier(H6(color: .white))
                    }//.modifier(H6(color: .tb4))
                    .accentColor(/*@START_MENU_TOKEN@*/Color("p1")/*@END_MENU_TOKEN@*/)
                } else if controlType == .none {
                    Text(label).modifier(H6(color: .white))
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)
                }
                
                
            }//.padding(.bottom, 5)
            CellDivider()
        }.frame(height: 65)
    }
}

struct ButtonCell_Generic: View {
    
    var label: String
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 20) {

                    Text(label).modifier(H6(color: .white))
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(Colors.grey.rawValue)).opacity(0.5)

            }//.padding(.bottom, 5)
            CellDivider()
                //.frame(height: 10)
        }.frame(height: 65)
    }
}

struct BackGround: View {
    var wallpaper: Wallpapers = .Floater2
    var body: some View {
        ZStack {
            Color("dark")
                .edgesIgnoringSafeArea(.all)
            Image(wallpaper.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenWidth)
            .offset(y: -screenHeight / 3 )
        }
        
    }
}

struct RadioCell : View {
    
    @Binding var isSelected: Bool
    
    var label: String
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 20) {
                RadioIcon(isSelected: $isSelected)
                Text(label).modifier(H6(color: .white))
            }.padding(.vertical, 5)
            CellDivider()
            }//.frame(height: 65)
    
        
    }
}

struct RadioIcon: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        
        ZStack {
            if isSelected {
                Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(Colors.p3.rawValue))
                Circle()
                .stroke(lineWidth: 7.5)
                .frame(width: 20, height: 20)
                .foregroundColor(Color(Colors.p1.rawValue))
            } else {
             Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(Colors.white.rawValue)).opacity(0.1)
            }
            
            
        }
        
    }
}

struct CellDivider: View {
    var body: some View{
        GeometryReader { geometry in
            Path{ path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: screenWidth, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .cornerRadius(10)
            .foregroundColor(Color("tb6"))
            .frame(height: 10)
        }//.frame(height: 20)
    }
}

struct CheckBox: View {
    
    var shapeStyle: CheckBoxType = .square
    
    var body: some View {
        VStack {
            if shapeStyle == .rounded {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color(Colors.p1.rawValue))
                    //.accentColor(.white)
                    .background(Color(.white))
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
            } else if shapeStyle == .square {
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color(Colors.p1.rawValue))
                    //.accentColor(.white)
                    .background(Color(.white))
                    .frame(width: 24, height: 24)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            }
        }
        
        
    }
}


struct CheckBoxSelector: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(Color( isSelected ? Colors.p1.rawValue : Colors.grey.rawValue))
                //.accentColor(.white)
                .background(Color(isSelected ? .white : .clear))
                .frame(width: 24, height: 24)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        }
        
        
    }
}


enum CheckBoxType {
    case rounded
    case square
}

struct TextDropdown: View {
    
    @Binding var fieldValue: String
    
    var label: String = "Label"
    
    let icon: SFIcons = .chevronDown
    var body: some View {
        VStack (spacing: 30) {
            VStack (alignment: .leading, spacing: 5) {
                Text(label).modifier(TextFieldLbl()).multilineTextAlignment(.leading)
                HStack {
                    Text(fieldValue)
                        .modifier(H4(color: .white))
                        .padding(.vertical, 20)
                        .padding(.leading, 24)
                    Spacer()
                    Image(systemName: icon.rawValue)
                        .resizable()
                        .foregroundColor(Color(Colors.white.rawValue))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.horizontal, 24)
                }
                .background(Color(Colors.darkTextField.rawValue))
                .cornerRadius(8)
                
            }
        }
        
    }
}

struct Blurview : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Blurview>) -> UIVisualEffectView {
        
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Blurview>) {
        
        
    }
}

struct BottomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addArc(center: CGPoint(x: rect.width / 2, y: 0), radius: 42, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
            
        }
    }
}
