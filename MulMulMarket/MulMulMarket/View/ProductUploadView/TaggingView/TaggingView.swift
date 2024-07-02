//
//  TaggingView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/1/24.
//

import SwiftUI

struct TaggingView: View {
    @State var text : String = ""
    
    @State var tags: [Tag] = []
    @State var showAlert: Bool = false
   
    var body: some View {
        VStack{
            Text ("Filter \nMenus")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor (Color(.black))
                .frame(maxWidth: .infinity, alignment: .leading)
            // Custom Tag View...
            TagView(maxLimit: 150, tags: $tags)
                .frame(height: 280)
                .padding(.top, 20)
            
            // TextField...
            TextField("apple", text: $text)
                .font(.title3)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder (Color(.black) .opacity (0.2), lineWidth: 1)
                )
            // Setting only Textfield as Dark..
                //.environment (\.colorScheme, .dark)
                .padding(.vertical, 18)
            
            Button {
                // Action
                addTag(tags: tags, text: text, fontSize: 16, maxLimit: 150) { alert, tag in
                    
                    if alert {
                        showAlert.toggle()
                    }else{
                        tags.append(tag)
                        text = ""
                    }
                }
                
            } label: {
                Text("Add Tag")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.black))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 45)
                    .background(Color(.systemGray))
                    .cornerRadius(10)
            }
            //Disabling Button...
            .disabled(text == "")
            .opacity(text == "" ? 0.6 : 1)
            
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .background(
//            Color(.systemPink)
//                .ignoresSafeArea()
//        )
        .alert(isPresented: $showAlert){
            Alert(title: Text("Error"), message: Text("tag Limit Exceeded try to delete some tags !!!"), dismissButton: .destructive(Text("OK")))        }
       
    }
}

#Preview {
    TaggingView()
}
