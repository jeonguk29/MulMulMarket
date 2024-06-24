//
//  ContentView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    
    var body: some View {
        
        
        VStack(content: {
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
            
            Spacer()
            
            CardView(honeyMoon: destinationArray[1])
                .padding()
            
            Spacer()
            
            FooterView(showBookingAlert: $showAlert)
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("SUCCESS"),
            message: Text("wishing a lovely and most precious of the times together for the amazing couple."),
                  dismissButton: .default(Text("Happy Honeymoon!"))
            )
        })
    }
}

#Preview {
    ContentView()
}
