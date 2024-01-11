//
//  AuthViewModel.swift
//  LetterProjectFirebaseExample
//
//  Created by Eunsu JEONG on 1/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//오류: Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
//UI 업데이트는 꼭 메인 스레드에서 진행되어야 한다.
//비동기 네트워킹은 기본적으로 메인이 아닌 다른 스레드에서 진행되므로
//UI 업데이트를 하는 Publish가 만드시 메인 스레드에서 수행되도록 설정하기 위해 @MainActor를 선언해 주는 것이다.

//Actor 내에서 구현이 실행중인 모든 작업은 항상 메인 큐에서 수행하게 된다.
//Task 로 생성된 작업은 (메인 액터에서 생성되지 않는 한) 백그라운드 스레드에서 즉시 실행되며, await 키워드를 사용해서 완료된 값이 돌아올 때까지 기다릴 수 있다.

//내가 아이스크림을 만들고 싶어서 재료(functions)를 사러 마트(Thread)에 감 -> 비동기 함수 호출
//근데 생크림을 찾는 일을 하다가 발을 다쳐서(await) 친구(system)한테 `func 생크림 사야해()` 도와줘라고 말함 -> await를 만나 system에 Thread 제어권 넘김
//친구(system)는 `func 생크림 사야해()` 말고도 할 일이 많아서 일단 부탁을 수락하고 다른데를 돌아다님 -> suspend
//적당하다고 생각하는 때에 `func 생크림을 사야해()`를 수행하도록 나를 마트(Thread)에 내려줌 -> suspend 된 함수를 resume하여 Thread를 할당함
//그럼 난 이제 생크림을 사고 설탕(fucntion)을 사러 감 -> 새 Thread에서 asyncFunction을 실행하고 다음 코드를 이어서 진행
@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? //Firebase user object
    @Published var currentUser: User? //User Data Model
    
    init() {
        //viewModel이 init될 때 이미 존재하는 user가 있는지 확인한다.
        //이 기능은 Firebase에서 제공하는 기능으로 currentUser가 로그인을 했는지(한 상태인지)에 대한 정보를 디바이스에 캐시 데이터로 저장해 둔다.
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(withEamil email: String, password: String) async throws {
        print(#function)
    }
    
    func createUser(withEamil email: String, password: String, fullName: String) async throws {
        do {
            //1. Try to create user -> await its result -> store it to the property
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            //2. Once success, set userSession property
            self.userSession = result.user //result에서 user값을 받아와 userSession에 넣어줌
            
            //3. Create our User object
            //firebase의 user는 firebase에서 새로운 user를 생성하고 uid 를 제공해준다.
            //기타 사용자에게 얻고자 하는 데이터(예: 핸드폰 번호, 생일 등)가 있다면 User Model에 구성을 추가하고 input을 받아야 한다.
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            //4. Encode the object throught the codable protocol
            let encodedUser = try Firestore.Encoder().encode(user)
            
            //5. Upload data to Firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            //if anything goes wrong:
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
