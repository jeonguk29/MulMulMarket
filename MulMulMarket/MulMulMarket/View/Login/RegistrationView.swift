//
//  RegistrationView.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/3/24.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegistrationViewModel()
    
    //@Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            Spacer()
            
            // logo image
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 30)
                .padding()
            
            // text fields
            VStack {
                // 프로필 이미지선택
                PhotosPicker(selection: $viewModel.selectedItem) {
                    // 내부적 처리는 뷰 모델을 통해 하는것을 권장함
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: nil, size: .xxLarge)
                    }
                }
                .padding()
                
                TextField("성함을 입력해주세요", text: $viewModel.fullname)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .onChange(of: viewModel.fullname) { _ in
                        viewModel.validateForm() // 이름이 변경될 때마다 validateForm 호출
                    }
                
                TextField("닉네임을 입력해주세요", text: $viewModel.nickname)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .onChange(of: viewModel.nickname) { _ in
                        viewModel.validateForm() // 닉네임이 변경될 때마다 validateForm 호출
                    }
            }
            
            Button {
                Task {
                    do {
                        try await viewModel.createUser()
                        DispatchQueue.main.async {
                            dismiss() // 버튼이 눌리면 화면 닫기 // 버튼이 눌리면 화면 닫기
                        }
                    } catch {
                        print("Failed to create user: \(error)")
                    }
                }
            } label: {
                Text("계정 생성")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemPink))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            .disabled(!viewModel.isFormValid) // 폼이 유효하지 않으면 버튼 비활성화
            
            Spacer()

            Divider()
            
        }
    }
}

#Preview {
    RegistrationView()
}
