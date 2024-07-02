//
//  Verification.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//


import SwiftUI

struct Verification: View {
    
    @ObservedObject var loginData : LoginViewModel
    @Environment(\.presentationMode) var present
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button(action: {present.wrappedValue.dismiss()}) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("인증 코드로 본인확인")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                        Spacer()
                        if loginData.loading{ProgressView()}
                    }
                    .padding()
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                    HStack(spacing: 15) {
                        // 전달된 code를 보여주는 화면
                        ForEach(0..<6,id: \.self) { index in
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal,20)
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                    Text("해당 번호가 맞으신가요? \(loginData.phNo)")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    HStack(spacing: 6) {
                        Text("인증 코드가 오지 않았나요?")
                            .foregroundColor(.gray)
                        Button(action: loginData.requestCode) {
                            Text("다시 보내기")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.black)
                        }
                    }
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
//                        Text("Get via Call")
//                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            .foregroundColor(.black)
//                    }
//                    .padding(.top,6)
                    
                    Button(action: loginData.verifyCode) {
                        Text("계정 확인 및 회원가입")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color(.pink))
                            .cornerRadius(20)
                    }
                    .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)// 화면 전체 높이의 1.8분의 1로 설정
                .background(Color.white)
                .cornerRadius(20)
                
                // costum nomor pad
                CostumNumberPad(value: $loginData.code, isVerify: true)
            }
            .padding()
            .background(Color(.systemGray6).ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error { // 문제가 있을때 표시 
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func getCodeAtIndex(index: Int) -> String {
        // 특정 인덱스에 문자가 있는지 여부를 문자열에서 확인하고 문자가 있는 인덱스가 의미하는 경우 반환합니다.
        if loginData.code.count > index {
            let start = loginData.code.startIndex
            let current = loginData.code.index(start, offsetBy: index)
            return String(loginData.code[current])
        }
        return ""
    }
}

struct CodeView: View {
    
    var code: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(code)
                .foregroundColor(.black)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title2)
                .frame(height: 45)
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
