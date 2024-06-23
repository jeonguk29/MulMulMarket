//
//  ContentView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack(content: {
            HeaderView()
            
            Spacer()
            
            CardView(honeyMoon: destinationArray[1])
                .padding()
            
            Spacer()
            
            FooterView()
        })
       
    }
}

#Preview {
    ContentView()
}
