//
//  AuthService.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore


// Firebase와 통신과 관련된 모든 코드를 넣을 것임 사용자 로그인, 등륵 등등
class AuthService {
  
    @Published var userSession: FirebaseAuth.User? // 사용자가 로그인 했는지 판단 
    
    static let shared = AuthService() // 싱글톤으로 이로직을 구현하지 않으면 여러 인스턴스가 생기기 때문에
    // 로그인, 로그아웃을 하더라도 View가 반영되지 않을 수 있음 init 될때마다 userSession가 새로 생기기 때문임
    
    init() {
        self.userSession = Auth.auth().currentUser // 로그인 했다면 로그인 정보 로컬에 저장됨
        loadCurrentUserData() // 로그인 했다면 정보 가져오기
        print("User session id is \(userSession?.uid)")
    }

    @MainActor
    func login(credential : PhoneAuthCredential) async throws {
        do {
            // 인증을 기반으로 로그인
            let result =  try await Auth.auth().signIn(with: credential)
                
                self.userSession = result.user // 로그인 하면 세션에 결과 넣어주기
                loadCurrentUserData()  // 로그인 했다면 정보 가져오기
            
        } catch {
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
        }
     
    }
    
    // 보라색 오류 없애는 방법
    @MainActor //사용자를 생성하고 사용자 데이터를 업로드하는 API 호출을 시작할때 백그라운드 스레드에서 진행 되기 때문에 다시 메인 스레드로 돌아오게 지시해줘야함 dispatchq.main,async와 동일함 최신 방식
    func createUser(profileImageUrl : String, fullname: String, nickname: String) async throws {
        do {
            try await self.uploadUserData(profileImageUrl : profileImageUrl, fullname: fullname, nickname: nickname, id:  self.userSession?.uid)
            loadCurrentUserData()
            //print("Created user \(result.user.uid)") // 등록시 uid를 반환
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    /// 실제 사용자 정보를 컬렉션에 생성하는 함수
    /// - Parameters:
    ///   - email, fullname, id : createUser메서드에서 넘겨 받는 값들
    /// - Returns: 없음
    private func uploadUserData(profileImageUrl : String, fullname: String, nickname: String, id: String?) async throws {
        guard let id = id else { return } //
        let user = User(id: id, fullname: fullname, nickname: nickname, profileImageUrl: profileImageUrl) // 비번저장하면 소송걸림
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return } //⭐️
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out on backend
            self.userSession = nil // update routing logic
            UserService.shared.currentUser = nil // 세션도 지우고 저장된 사용자 정보도 지우고
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    
 
    
    
    /// 로그인 사용자 정보를 알맞게 다시 로딩하는 메서드
    /// 사용자 로그아웃하고 다시 다른 계정으로 로그인 하면 직전 사용자 정보가 남아있음 프로필 사진, 이름 등등
    /// init은 앱 세션만 한번 초기화 됨 앱 종료후 다시 실행하면 정상 작동함 알맞은 로그인 사용자로
    /// 기존에 해당 코드가 init즉 초기화 될때만 호출하여 로그아웃 이후 새로 로그인을 했을때도 호출하기 위해 분리 앱 재실행 하지 않기 위해
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
}
