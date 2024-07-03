//
//  LoginViewModel.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/2/24.
//

import SwiftUI
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var phNo = ""
    @Published var code = ""
    @Published var errorMsg = ""
    @Published var error = false
    @Published var CODE = ""
    @Published var gotoVerify = false
    @Published var userSession: FirebaseAuth.User?
    @Published var loading = false // 이걸로 Verification View에서 ProgressView를 돌림 
    
    // MARK: - Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(){
        setupSubscribers()
    }
    
    // MARK: - Subscribers Setup
    
    ///컴바인을 활용해 로그인했는지 확인하는 코드
    /// - Parameters:
    ///   - x : x
    /// - Returns: x
    private func setupSubscribers() {
        AuthService.shared.$userSession
            .sink { [weak self] userSessionFromAuthService in
                self?.userSession = userSessionFromAuthService
            }
            .store(in: &cancellables)
    }

    /// / 현재 디바이스의 지역에 해당하는 국가 코드를 반환 ex 한국에서는 "KR" 리턴 값은 82
    /// - Parameters:
    ///   - x : x
    /// - Returns: 국가코드
    func getCountryCode() -> String {
        let regionCode = Locale.current.regionCode ?? ""
        return countries[regionCode] ?? ""
    }
    
    /// 전화번호를 통해 인증 코드를 받는 코드
    /// - Parameters:
    ///   - x : x
    /// - Returns: x
    func sendCode() {
        
        let number = "+\(getCountryCode())\(phNo)"
        
        /*
         Auth.auth().settings?.isAppVerificationDisabledForTesting = true
         isAppVerificationDisabledForTesting = true를 설정하면, Firebase는 실제 SMS 메시지를 보내지 않고도 테스트용으로
         전화번호 인증을 수행할 수 있게 해줍니다. 이 설정을 사용하면 전화번호 인증을 쉽게 테스트할 수 있습니다.
         */
        
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation { self.error.toggle() }
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    
    /// 인증 코드를 통해 유효한 값인지 확인하고 계정을 로그인 및 생성
    /// - Parameters:
    ///   -
    /// - Returns:
    func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Task {
            do {
                try await AuthService.shared.login(credential: credential)
                DispatchQueue.main.async {
                    self.loading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.loading = false
                    self.errorMsg = error.localizedDescription
                    withAnimation { self.error.toggle() }
                }
            }
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
