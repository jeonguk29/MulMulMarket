//
//  ContentView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/23/24.
//

import SwiftUI

struct ContentView: View {
    // property
    @State var initPageNumber: Int = 0
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        ZStack {
            if status {
                Home()
            }
            else {
                NavigationView {
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    //        var body: some View {
    //            // selection: TabView 가 어디 페이지를 가리키는지 설정하는것
    //            TabView(selection: $initPageNumber) {
    //                MainCardView()
    //                    .tabItem {
    //                        Image(systemName: "hand.draw")
    //                        Text("exchange")
    //                    }
    //                    .tag(0) // 0번 화면
    //
    //                ProductUpLoadView()
    //                    .tabItem {
    //                        Image(systemName: "arrow.triangle.2.circlepath.camera")
    //                        Text("upload")
    //                    }
    //                    .tag(1)// 1번 화면
    //
    //                Text("프로필 화면")
    //                    .tabItem {
    //                        Image(systemName: "person.fill")
    //                        Text("My Page")
    //                    }
    //                    .tag(2)// 2번 화면
    //
    //                Login()
    //                    .navigationBarHidden(true)
    //                    .navigationBarBackButtonHidden(true)
    //                    .tag(3)// 3번 화면
    //            }
    //            .accentColor(.red)
    //        }
}

#Preview {
    ContentView()
}
