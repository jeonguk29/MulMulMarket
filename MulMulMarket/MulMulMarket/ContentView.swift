//
//  ContentView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 6/23/24.
//

import SwiftUI
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LoginViewModel()
    @State var initPageNumber: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                
                if viewModel.userSession != nil {
                    // 로그인된 상태일 때
                    if UserService.shared.currentUser == nil {
                        // 현재 사용자 정보가 없으면 RegistrationView로 이동
                        
                        RegistrationView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                        
                    } else {
                        // 현재 사용자 정보가 있으면 TabView로 전환
                        TabView(selection: $initPageNumber) {
                            MainCardView()
                                .tabItem {
                                    Image(systemName: "hand.draw")
                                    Text("exchange")
                                }
                                .tag(0) // 0번 화면
                            
                            ProductUpLoadView()
                                .tabItem {
                                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                                    Text("upload")
                                }
                                .tag(1) // 1번 화면
                        }
                        .accentColor(.pink)
                    }
                } else {
                    // 로그인되지 않은 상태일 때 Login 화면 표시
                    
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    
                }
            }
        }
        .onAppear {
            //  AuthService.shared.signOut()
            // 사용자의 현재 상태를 가져오는 작업 수행
            Task {
                do {
                    try await UserService.shared.fetchCurrentUser()
                } catch {
                    print("Failed to fetch current user: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
