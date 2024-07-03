//
//  RegistrationViewModel.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/3/24.
//

import SwiftUI
import PhotosUI
import _PhotosUI_SwiftUI
import FirebaseStorage

class RegistrationViewModel: ObservableObject {
    @Published var fullname = ""
    @Published var nickname = ""
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
    @Published private(set) var isFormValid = false // 유효성 검사 
    // 프로퍼티가 private(set) 외부에서 읽기는 가능하지만 쓰기는 클래스 내부에서만 가능
    
    private var profileImageData: Data?
 
    
    
    func createUser() async throws {
        guard let imageData = profileImageData else { return }
        
        let profileImageUrl = try await uploadImage(data: imageData)
        try await AuthService.shared.createUser(profileImageUrl: profileImageUrl, fullname: fullname, nickname: nickname)
    }
    
    // 이미지 선택후 호출됨 변환하여 사진으로 만드는 메서드
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        
        // UI 업데이트는 메인 스레드에서 처리되어야 함
        DispatchQueue.main.async {
            self.profileImage = Image(uiImage: uiImage)
            self.profileImageData = imageData
            self.validateForm() // 폼 유효성 검사 수행
        }
    }
    
    // 프로필 이미지 업로드
    private func uploadImage(data: Data) async throws -> String {
        let storageRef = Storage.storage().reference().child("profile_images/\(UUID().uuidString).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let _ = try await storageRef.putDataAsync(data, metadata: metadata)
        let downloadURL = try await storageRef.downloadURL()
        
        return downloadURL.absoluteString
    }
    
    // 값이 하나라도 없으면
    func validateForm() {
           isFormValid = !fullname.isEmpty && !nickname.isEmpty && profileImageData != nil
    }
}
