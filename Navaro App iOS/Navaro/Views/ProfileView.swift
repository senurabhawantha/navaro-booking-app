//
//  ProfileView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    
    @State private var userName: String = "Senura"
    @State private var userEmail: String = "senurabawantha@gmail.com"
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        
        VStack{
            Image("user_img")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .cornerRadius(200)
                .padding(.vertical,30)
            HStack(alignment: .top){
                Text("\(userName)")
                    .foregroundColor(.darkBlue)
                    .fontWeight(.semibold)
                    .font(.system(size: 30))
            }

            
            VStack{
                HStack{
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color.darkBlue)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                        .padding(.leading,5)
                    Text("Email")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                        .padding(.leading,5)
                    
                    
                    Spacer()
                    Text("\(userEmail)")
                        .foregroundColor(Color.gray)
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.gray)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                }
                .padding(.vertical,2)
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            
           
            
            VStack{
                HStack{
                    
                    VStack{
                        Image(systemName: "iphone.sizes")
                            .font(.system(size: 15))
                            .opacity(0.6)
                        
                        
                    }
                    .frame(width: 30,height: 30)
                    Text("Other Contacts")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                }
                HStack{
                    
                    VStack{
                        Text("?")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.darkBlue)
                            .opacity(0.7)
                        
                    }
                    .frame(width: 30,height: 30)
                    Text("Privacy Policy")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                }
                HStack{
                    
                    VStack{
                        Image(systemName: "info.circle")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.darkBlue)
                            .opacity(0.7)

                    }
                    .frame(width: 30,height: 30)
                    Text("About us")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                }
                
                HStack{
                    
                    VStack{
                        Image(systemName: "message.circle")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.darkBlue)
                            .opacity(0.7)

                    }
                    .frame(width: 30,height: 30)
                    Text("Contact us")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                }
            }
            .padding(15)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .padding(.top)
            
            
            Spacer()
            Button(action: {
                logout()
            }) {
                HStack{
                    Spacer()
                    Text("Logout")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical,10)
                .background(Color.lightBlue)
                .cornerRadius(12)

            }
        }
        
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("AppBgColor"))
        .onAppear {
            userName = authViewModel.userModel?.displayName ?? "Senura Bhawantha"
            userEmail = authViewModel.userModel?.email ?? "Senurabawantha@gmail.com"
            
        }
        
        
    }
    
    private func logout() {
        self.authViewModel.signOut()
        
    }
    
    
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
