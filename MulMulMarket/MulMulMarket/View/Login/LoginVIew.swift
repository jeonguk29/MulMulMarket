//
//  LoginVIew.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//

import SwiftUI

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    @State var isSmall = UIScreen.main.bounds.height < 750 // 사용 중인 장치의 화면 높이가 750 포인트(pt)보다 작은지를 확인
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Spacer()
                    
                    Image("logo-honeymoon-pink")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .padding(.top)
//                    Text("로그인을 위한 전화번호를 입력해 주세요")
//                        .font(.title)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//                        .padding()
                    Text("확인을 위한 6자리 코드를 받게 됩니다.")
                        .font(isSmall ? .subheadline : .headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("로그인을 위한 전화번호를 입력해 주세요")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
//                            Text("+62 \(loginData.phNo)")
                            Text("+ \(loginData.getCountryCode()) \(loginData.phNo)")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.black)
                        }
                        
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        
                        // 화면 이동시 loginData 즉 ViewModel을 새로 생성하여 전달 
                        NavigationLink(destination: Verification(loginData: loginData),isActive: $loginData.gotoVerify) {
                            Text("")
                                .hidden()
                        }
                        Button(action: loginData.sendCode, label: {
                            Text("Go")
                                .foregroundColor(.white)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.vertical,18)
                                .padding(.horizontal,38)
                                .background(Color(.systemPink))
                                .cornerRadius(20)
                        })
                        .disabled(loginData.phNo == "" ? true: false)
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5) // 그림자 주는 방법
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color("bg"))
                .cornerRadius(20)
                
                // costum nomor pad
                CostumNumberPad(value: $loginData.phNo, isVerify: false)
            }
            .background(Color(.systemGray6).ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
    }
}
