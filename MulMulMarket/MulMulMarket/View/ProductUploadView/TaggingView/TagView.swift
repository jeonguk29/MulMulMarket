//
//  TagVIew.swift
//  MulMulMarket
//
//  Created by 정정욱 on 7/1/24.
//

import SwiftUI

// Custom View...
struct TagView: View {
    var maxLimit: Int // 모든 태그의 총 문자 수 제한
    @Binding var tags: [Tag] // Tag 객체 배열을 바인딩으로 받아 외부 상태를 읽고 쓸 수 있음
    
    var title: String = "Add some Tags"
    var fontSize: CGFloat = 12 // 태그 텍스트의 글꼴 크기.
    
    // Adding Geometry Effect to Tag...
    @Namespace var animation
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // 교환 하고 싶은 물건들의 태그를 입력해주세요
            Text(title)
                .font(.callout)
                .foregroundStyle(Color(.black))
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(getRows(), id: \.self) { rows in
                        HStack(spacing: 6) {
                            ForEach(rows) { tag in
                                RowView(tag: tag)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
                .padding(.vertical)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.black.opacity(0.2), lineWidth: 1)
            )
            .animation(.easeInOut, value: tags)
            .overlay(
                // Limit....
                Text("\(getSize(tags: tags))/\(maxLimit)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(12),
                alignment : .bottomTrailing
                )
            
            
        }
        // since onChange will perfrom little late...
//        .onChange(of: tags) { newValue in
//        
//        }
       
    }
    
    
    // 목적 : 하나의 태그를 캡슐 형태로 표시
    // 컨텍스트 메뉴 : 사용자가 태그를 길게 눌러 삭제할 수 있도록 합니다. 
    @ViewBuilder
    func RowView(tag: Tag) -> some View {
        Text(tag.text)
        // applying same font size..
        // else size will vary..
            .font(.system(size: fontSize))
        // adding capsule..
            .padding (.horizontal, 14)
            .padding(.vertical, 8)
            .background (
                Capsule()
                    .fill(Color.gray)
            )
            .foregroundColor(Color(.black))
            .lineLimit(1)
        // Delete...
            .contentShape(Capsule())
            .contextMenu{
                Button("Delete"){
                    //deleting..
                    tags.remove(at: getIndex(tag: tag))
                }
            }
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    // 주어진 태그의 인덱스를 반환합니다.
    func getIndex(tag: Tag) -> Int {
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        
        return index
    }
    
    // Basic Logic..
    // Splitting the array when it exceeds the screen size....
    // 가용 화면 너비를 초과하는 태그를 다음 행으로 넘기며 태그를 행으로 분할합니다.
    func getRows() -> [[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        // caluclating text width...
        var totalWidth: CGFloat = 0
        
        // For safety extra 10...
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
        
        tags.forEach { tag in
            // updating total width...
            // adding the capsule size into total width with spacing..
            // 14 + 14 + 6 + 6
            // extra 6 for safety...
            totalWidth += (tag.size + 40)
            
            // checking if totalwidth is greater than size...
            if totalWidth > screenWidth{
                // adding row in rows...
                // clearing the data...
                // checking for long string..
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            }else{
                currentRow.append(tag)
            }
        }
        
        // Safe check...
        // if having any value storing it in rows...
        if !currentRow.isEmpty{
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
}

#Preview {
    TaggingView()
}

// 새로운 태그의 크기를 계산하고, 문자 제한을 초과하지 않는지 확인합니다.
func addTag(tags: [Tag], text: String, fontSize: CGFloat, maxLimit: Int, completion : @escaping (Bool, Tag) -> () ){
   
    // getting Text Size ...
    let font = UIFont.systemFont(ofSize: fontSize)
    let attributes = [NSAttributedString.Key.font : font]
    let size = (text as NSString).size(withAttributes: attributes)
    print(size)
    
    let tag = Tag(text: text, size: size.width)
    if(getSize(tags: tags) + text.count) < maxLimit {
        completion(false, tag)
    }else {
        completion(true, tag)
    }
    
}

// 모든 태그의 총 문자 수를 반환합니다.
func getSize (tags: [Tag]) -> Int {
    var count: Int = 0
    tags.forEach { tag in
        count += tag.text.count
    }
    return count
}
