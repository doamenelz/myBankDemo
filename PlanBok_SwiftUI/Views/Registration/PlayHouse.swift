//
//  PlayHouse.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-11.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import SwiftUI
import FirebaseStorage

struct PlayHouse: View {
      var status: Bool = true
    
    @State var shown: Bool = false
    
      var icon: String = "checkmark.circle.fill"
      var body: some View {
          NavigationView {
              ZStack {
                  BackGround()
                  VStack (){
                      Image(systemName: status ? SFIcons.success.rawValue : SFIcons.exclaimation.rawValue)
                          .resizable()
                          .foregroundColor(status ? Color("ctSuccess") : Color("ctError"))
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 60, height: 60)
                      CompletedView(title: status ? "Success" : "Failed", subtitle: "Completed successfully")
                  }
                  .padding(.horizontal, 38)
                  //.frame(width: screenWidth - 76)
                  
                  VStack (spacing: 10) {
                      Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                          if status == true {
                              Text(status ? "Continue" : "Go back").modifier(ButtonText())
                              .modifier(PrimaryBtn())
                          } else {
                              Text(status ? "Continue" : "Go back").modifier(ButtonText())
                              .modifier(SecondaryBtn())
                          }
                          
                          
                              
                      }
                      
                      NavigationLink(destination: OTPVerification()) {
                          Text("Continue").modifier(ButtonText())
                              .modifier(PrimaryBtn())
                      }
                      Color(.clear)
                      .frame(height: 64)
                  }
                  .offset(y: screenHeight / 3)
                  
                Button(action: {
                    self.shown.toggle()
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                }.sheet(isPresented: $shown) {
                    ImagePcker(shown: self.$shown)
                }
                
              }
          }
      }
}

struct PlayHouse_Previews: PreviewProvider {
    static var previews: some View {
        PlayHouse()
    }
}

struct ImagePcker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePcker.Coordinator(parent1: self)
    }
    
    @Binding var shown : Bool
    //@Binding var data : Data
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imgPic = UIImagePickerController()
        imgPic.sourceType = .photoLibrary
        imgPic.delegate = context.coordinator
        return imgPic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePcker!
        init(parent1: ImagePcker) {
            parent = parent1
            
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            
            let storage = Storage.storage()
            storage.reference().child("temp").putData(image.jpegData(compressionQuality: 0.35)!, metadata: nil) { (_, error) in
                
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                } else {
                    print("Success")
                }
                
            }
            
            //parent.data = image.jpegData(compressionQuality: 0.35)!
        }
        
        
        
    }
}


