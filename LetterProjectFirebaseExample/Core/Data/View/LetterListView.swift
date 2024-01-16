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
                            LetterDetailView()
                        } label: {
                            VStack {
                                HStack {
                                    Text("To: \(letter.recipient)")
                                    
                                    Spacer()
                                } //HStack
                                
                                Text(letter.summary)
                                
                                HStack {
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        Text("From: \(letter.writer)")
                                        
                                        //Text(letter.date)
                                    } //VStack
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

struct LetterDetailView: View {
    var body: some View {
        Text("Hello World")
    }
}

struct AddNewLetterView: View {
    @EnvironmentObject var letterViewModel: FirestoreViewModel
    
    var body: some View {
        Button {
            letterViewModel.addLetter(writer: "meow",
                                      recipient: "you",
                                      summary: "helooo",
                                      date: Date())
        } label: {
            Text("Add")
        }
    }
}

#Preview {
    LetterListView()
}
