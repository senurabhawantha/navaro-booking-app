//
//  SignUpView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Image("AppBg")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 6)
            
            Color.white.opacity(0.05)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.width / 1.5)
                
                VStack(spacing: 8) {
                    HStack{
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 14))
                            .padding(.vertical,15)
                            .padding(.horizontal,15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                        
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 14))
                            .padding(.vertical,15)
                            .padding(.horizontal,15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                    }
                    
                    TextField("Email", text: $email)
                        .font(.system(size: 14))
                        .padding(.vertical,15)
                        .padding(.horizontal,15)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 14))
                        .padding(.vertical,15)
                        .padding(.horizontal,15)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    guard !firstName.isEmpty else {
                        alertMessage = "Please enter your first name."
                        showAlert = true
                        return
                    }
                    
                    guard !lastName.isEmpty else {
                        alertMessage = "Please enter your last name."
                        showAlert = true
                        return
                    }
                    
                    guard !email.isEmpty else {
                        alertMessage = "Please enter your email."
                        showAlert = true
                        return
                    }
                    
                    guard !password.isEmpty else {
                        alertMessage = "Please enter your password."
                        showAlert = true
                        return
                    }
                    
                    authViewModel.signUpWithEmail(email: email, password: password, firstName: firstName, lastName: lastName) { success in
                        if success {
                            
                        }
                    }
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 14))
                        .padding(.vertical,15)
                        .padding(.horizontal,15)
                        .fontWeight(.bold)
                        .background(Color.white)
                        .foregroundColor(Color("DarkBlue"))
                        .cornerRadius(10)
                }

                
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.5))
                    Text("OR")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.5))
                }
                
                
                
                Button(action: {
                    
                }) {
                        HStack {
                            Image("google_ico")
                                .resizable()
                                .frame(width: 22, height: 22)
                                .scaledToFit()
                            Text("Login with Google")
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,15)
                        .padding(.horizontal,15)
                        .background(Color.white)
                        .foregroundColor(Color("DarkBlue"))
                        .cornerRadius(10)
                    }
                
                Spacer()
                NavigationLink(destination: LoginView()
                    .environmentObject(authViewModel)) {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        Text("Login")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    
                }
                
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
            
            
        }
        
        .navigationBarBackButtonHidden(true)
        
        .onReceive(authViewModel.$isAuthenticated) { authenticated in
            if authenticated {
                
            }
        }
        
        .onReceive(authViewModel.$authError) { error in
            if let error = error {
                alertMessage = error
                showAlert = true
            }
        }
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Sign Up Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    
}



#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
