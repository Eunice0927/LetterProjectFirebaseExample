//
//  DataListView.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/16/24.
//

import SwiftUI

struct LetterListView: View {
    @EnvironmentObject var letterViewModel: FirestoreViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(letterViewModel.letters, id: \.self) { letter in
                        NavigationLink {
                            LetterDetailView(writer: letter.writer, recipient: letter.recipient, summary: letter.summary, date: letterViewModel.dateString(date: letter.date))
                        } label: {
                            VStack {
                                HStack {
                                    Text("To: \(letter.recipient)")
                                    
                                    Spacer()
                                    
                                    Text("\(letterViewModel.dateString(date: letter.date))")
                                        .foregroundStyle(.beigeGray)
                                } //HStack
                                
                                Text(letter.summary)
                                
                                HStack {
                                    Spacer()
                                    
                                    Text("From: \(letter.writer)")
                                } //HStack
                            } //VStack
                        } //Label
                    } //ForeEach
                } //List
            } //VStack
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddNewLetterView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            } //toolbar
        } //NavigationStack
        .onAppear {
            letterViewModel.fetchAllLetters()
        }
    }
}

#Preview {
    LetterListView()
}
