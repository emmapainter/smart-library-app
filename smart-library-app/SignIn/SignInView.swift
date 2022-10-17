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
    @State var user = Auth.auth().currentUser
       
    var body: some View {
        if let user = user {
            VStack{
                Text(user.uid)
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        self.user = nil
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
                            try await self.user = authController.completeSignInWithApple(result: result)?.user
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
