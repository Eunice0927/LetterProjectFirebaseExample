//
//  LetterDetailView.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/16/24.
//

import SwiftUI

struct LetterDetailView: View {
    var writer: String
    var recipient: String
    var summary: String
    var date: String
    
    var body: some View {
        VStack {
            HStack {
                Text("보낸 사람")
                Text(writer)
            }
            
            HStack {
                Text("받는 사람")
                Text(recipient)
            }
            
            HStack {
                Text("날짜")
                
                Text("\(date)")
            }
            
            HStack {
                Text("내용")
                
                Text(summary)
            }
        }
    }
}

#Preview {
    LetterDetailView()
}
