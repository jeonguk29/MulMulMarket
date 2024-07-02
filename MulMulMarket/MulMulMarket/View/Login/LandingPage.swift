//
//  LandingPage.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//

import SwiftUI

struct LandingPage: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var selectedCategory : Category = categories.first!
    @State var selectedtab : String = "house"
    var white: Color = .white.opacity(0.75)
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedtab) {
                Home(selectedCategory: selectedCategory)
                    .tag("house")
                Color.yellow
                    .tag("bookmark")
                ChannelView()
                    .tag("message")
                Color.green
                    .tag("person")
            }
            TabBar(selectedTab: $selectedtab)
        }
        .background(Color("bg"))
        .ignoresSafeArea()
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
