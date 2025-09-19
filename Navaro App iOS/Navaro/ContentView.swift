//
//  ContentView.swift
//  Navaro
//
//  Created by Guest User on 2025-09-09//

import SwiftUI
import Firebase
import FirebaseAuth
import LocalAuthentication

import SwiftUI

struct ContentView: View {
    var body: some View {
        SplashView()
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}




import SwiftUI
import LocalAuthentication

struct FaceIDView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var authFailed = false

    var body: some View {
        VStack {
            Text("Authenticating with Face ID...")
                .padding()
            ProgressView()
        }
        .onAppear(perform: authenticateWithFaceID)
        .alert("Authentication Failed", isPresented: $authFailed) {
            Button("OK") {
                authViewModel.signOut()
            }
        }
    }

    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate to continue"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    if success {
                        authViewModel.didCompleteBiometricAuth = true
                    } else {
                        authViewModel.signOut()
                        authFailed = true
                    }
                }
            }
        } else {
            authViewModel.signOut()
        }
    }
}



//struct SplashView: View {
//    @State private var isLoading = true
//    @EnvironmentObject var authViewModel: AuthViewModel
//
//    var body: some View {
//        VStack {
//            if isLoading {
//                Image("AppLogo")
//                    .resizable()
//                    .frame(width: 150,height: 150)
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            isLoading = false
//                        }
//                    }
//            } else {
//                if authViewModel.isAuthenticated {
//                    if authViewModel.didCompleteBiometricAuth {
//                        MainTabView()
//                    } else {
//                        FaceIDView()
//                    }
//                } else {
//                    LoginView()
//                }
//            }
//        }
//    }
//}

struct SplashView: View {
    @State private var isLoading = true
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.orange]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() // makes it cover the entire screen
            
            VStack {
                if isLoading {
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isLoading = false
                            }
                        }
                } else {
                    if authViewModel.isAuthenticated {
                        if authViewModel.didCompleteBiometricAuth {
                            MainTabView()
                        } else {
                            FaceIDView()
                        }
                    } else {
                        LoginView()
                    }
                }
            }
        }
    }
}




struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            BookingHistoryView()
                .tabItem {
                    Label("Booking", systemImage: "bookmark.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}



#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}

