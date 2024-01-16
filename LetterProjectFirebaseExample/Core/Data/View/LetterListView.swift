//
//  DataListView.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/16/24.
//

import SwiftUI

struct LetterListView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var letterViewModel: FirestoreViewModel
    
    var body: some View {

        Button {
            letterViewModel.addLetter(writer: "me", recipient: "you", summary: "helooo", date: Date())
        } label: {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    LetterListView()
}
