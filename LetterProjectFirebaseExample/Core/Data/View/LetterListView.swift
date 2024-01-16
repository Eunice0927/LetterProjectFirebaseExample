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

struct LetterDetailView: View {
    var body: some View {
        Text("Hello World")
    }
}

struct AddNewLetterView: View {
    @EnvironmentObject var letterViewModel: FirestoreViewModel
    @Environment(\.dismiss) var dismiss
    @State var writer: String = ""
    @State var recipient: String = ""
    @State var summary: String = ""
    @State var date: Date = Date()
    
    var body: some View {
        ZStack {
            Form {
                VStack(alignment: .leading) {
                    HStack {
                        Text("보낸 사람")
                        TextField("보낸 사람", text: $writer)
                    }
                    
                    HStack {
                        Text("받는 사람")
                        TextField("받는 사람", text: $recipient)
                    }
                    
                    HStack {
                        Text("날짜")
                        Text("1234-00-00")
                            .foregroundStyle(.beigeGray)
                    }
                    
                    HStack {
                        Text("내용")
                        TextField("내용", text: $summary)
                    }
                } //VStack
            } //Form
            
            VStack {
                Spacer()
                
                Button {
                    letterViewModel.addLetter(writer: writer,
                                              recipient: recipient,
                                              summary: summary,
                                              date: date)
                    letterViewModel.fetchAllLetters()
                    dismiss()
                } label: {
                    Text("Add")
                }
                
                Spacer().frame(height: 20)
            } //VStack
        } //ZStack
    }
}

#Preview {
    LetterListView()
}
