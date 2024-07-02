//
//  LoginViewModel.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//


import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var phNo = ""
    @Published var code = ""
    
    // 인증코드 실패시
    @Published var errorMsg = ""
    @Published var error = false
    
    // Storing CODE for verification..
    @Published var CODE = ""
    @Published var gotoVerify = false
    @AppStorage("log_Status") var status = false
    @Published var loading = false
    
    // 현재 디바이스의 지역에 해당하는 국가 코드를 반환 ex 한국에서는 "KR" 리턴 값은 82
    func getCountryCode() -> String {
       
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries[regionCode] ?? ""
    }
    
    // sending code ke user
    func sendCode() {
        
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        /*
         isAppVerificationDisabledForTesting = true를 설정하면, Firebase는 실제 SMS 메시지를 보내지 않고도 테스트용으로 전화번호 인증을 수행할 수 있게 해줍니다. 이 설정을 사용하면 전화번호 인증을 쉽게 테스트할 수 있습니다.
         */
        let number = "+\(getCountryCode())\(phNo)"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            
            if let error = err {
                
                self.errorMsg = error.localizedDescription
                withAnimation{self.error.toggle()}
                return
            }
            
            self.CODE = CODE ?? "" // 인증 코드 받기
            self.gotoVerify = true
        }
    }
    
    // 코드 인증, 인증 성공시 사용자를 로그인
    func verifyCode() {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code) // verificationCode를 사용하여 전화번호 인증 자격 증명(credential)을 생성합니다.
        
        loading = true
        
        // 인증을 기반으로 로그인
        Auth.auth().signIn(with: credential) { (result, err) in
            
            self.loading = false
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation{self.error.toggle()}
                return
            }
            
            withAnimation{self.status = true}
        }
    }
    
    func requestCode() {
        
        sendCode()
        
        withAnimation {
            self.errorMsg = "Code Sent"
            self.error.toggle()
        }
    }
}
