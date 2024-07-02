//
//  SelectPhotos.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/1/24.
//

import SwiftUI
import PhotosUI

struct SelectPhotos: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var imageData: [Data?] = []
    @State var selectImage: Bool = false
    @State var showPermissionAlert: Bool = false
    @State var selectedItemsCounts: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 10){
                    PhotosPicker(
                        selection: $selectedItems,
                        maxSelectionCount: 5,
                        matching: .images
                    ) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(.systemGray4))
                                .frame(width: 100, height: 100)
                            VStack(spacing: 0){
                                Spacer()
                                Image(systemName:"camera")
                                    .frame(width: 40, height: 30)
                                    .foregroundColor(.gray)
                                HStack(spacing: 0){
                                    Text("\(selectedItemsCounts)")
                                        .foregroundColor(.orange)
                                    Text("/5")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                    if selectImage == true {
                        
                        
                        ForEach(imageData.indices, id: \.self) { index in
                            if let data = imageData[index], let uiimage = UIImage(data: data) {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .padding(.leading, 10)
                            }
                        }
                        
                        
                    }
                    
                    Spacer()
                }
            }
            
        }
        .onChange(of: selectedItems) { newValue in
            DispatchQueue.main.async {
                imageData.removeAll()
                selectedItemsCounts = 0
            }
            for (index, item) in selectedItems.enumerated() {
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            imageData.append(data)
                            print("사진 \(index+1) 업로드 완료, \(data)")
                            selectedItemsCounts += 1
                            selectImage = true
                        }
                        
                    case .failure(let failure):
                        print("에러")
                        fatalError("\(failure)")
                    }
                    
                }
            }
            
        }
        
    }
}

#Preview {
    SelectPhotos()
}
