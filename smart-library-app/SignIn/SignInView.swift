//
//  SigninView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/16/22.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct SignInView: View {
    let authController = AuthController()
    @State var firebaseUser = Auth.auth().currentUser
    @EnvironmentObject private var user: User
       
    var body: some View {
        if let user = firebaseUser {
            VStack{
                Text(user.uid)
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        self.firebaseUser = nil
                    } catch let error {
                        print(error)
                    }
                }){ Text("Sign Out") }
            }
        } else {
            SignInWithAppleButton(
                onRequest: { request in
                    authController.requestSignInWithApple(request: request)
                },
                onCompletion: { result in
                    Task {
                        do {
                            try await self.firebaseUser = authController.completeSignInWithApple(result: result)?.user
                            self.user.loggedIn = true
                        } catch let error {
                            print(error)
                        }
                    }
                    
                }
            ).frame(width: 280, height: 45, alignment: .center)
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
