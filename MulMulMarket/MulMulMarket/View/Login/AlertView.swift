//
//  AlertView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//


import SwiftUI

struct AlertView: View {
    
    var msg: String
    @Binding var show: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15, content: {
            Text("Message")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
            
            Text(msg)
                .foregroundColor(.gray)
            
            Button(action: {
                    show.toggle()
            }, label: {
                Text("확인")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("bgButton"))
                    .cornerRadius(15)
            })
            .frame(alignment: .center)
        })
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal,25)
        
        // background dim
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea())
    }
}
