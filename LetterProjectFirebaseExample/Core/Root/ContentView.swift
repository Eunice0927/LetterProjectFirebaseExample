//
//  ContentView.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                //userSession이 있으면 ProfileView를 보여줌
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}
#Preview {
    ContentView()
}
