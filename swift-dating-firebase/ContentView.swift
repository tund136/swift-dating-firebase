//
//  ContentView.swift
//  swift-dating-firebase
//
//  Created by Danh Tu on 13/09/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

struct LoginView: View {
    @StateObject var model = ModelData()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                ZStack {
                    if UIScreen.main.bounds.height < 750 {
                        Image(systemName: "bolt.heart.fill")
                    } else {
                        Image(systemName: "bolt.heart.fill")
                    }
                }
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
                .font(.system(size: 150))
                .frame(width: 200, height: 200)
                .background(Color.white.opacity(0.2))
                .cornerRadius(20)
                
                VStack(spacing: 4) {
                    HStack(spacing: 0) {
                        Text("Dating")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Text("Match")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                    }
                    
                    Text("Let's choose your match")
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                Spacer()
                
                VStack(spacing: 20) {
                    CustomTextField(image: "person", playholder: "Email", text: $model.email)
                    
                    CustomTextField(image: "lock", playholder: "Password", text: $model.password)
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("LOG IN")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 180)
                        .background(Color.white)
                        .clipShape(Capsule())
                })
                .padding(.top)
                
                HStack(spacing: 20) {
                    Text("Don't have an account?")
                        .foregroundColor(.white.opacity(0.7))
                    
                    Button(action: {
                        model.isSignUp.toggle()
                    }, label: {
                        Text("Sign Up Now")
                            .foregroundColor(.white)
                            .bold()
                    })
                }
                .padding(.top)
                
                Spacer(minLength: 0)
                
                Button(action: model.resetPassword, label: {
                    Text("Forgot password?")
                        .foregroundColor(.white)
                        .bold()
                })
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $model.isSignUp) {
            SignUpView(model: model)
        }
        .alert(isPresented: $model.isLinkSent) {
            Alert(title: Text("Message"), message: Text("Password Reset Link has been sent."), dismissButton: .destructive(Text("OK")))
        }
        
    }
}

struct CustomTextField: View {
    var image: String
    var playholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: image)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            ZStack {
                if playholder == "Password" || playholder == "Re-enter Password" {
                    SecureField(playholder, text: $text)
                } else {
                    TextField(playholder, text: $text)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 65)
            .frame(height: 60)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct SignUpView: View {
    @ObservedObject var model: ModelData
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            LinearGradient(gradient: .init(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            Button(action: {
                model.isSignUp.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            })
            .padding(.trailing)
            .padding(.top)
            
            VStack {
                Spacer()
                
                Image(systemName: "bolt.heart.fill")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red)
                    .font(.system(size: 150))
                    .frame(width: 200, height: 200)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                
                VStack(spacing: 4) {
                    HStack(spacing: 0) {
                        Text("New")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Text("Profile")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                    }
                    
                    Text("Create a profile for you!")
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                Spacer()
                
                VStack(spacing: 20) {
                    CustomTextField(image: "person", playholder: "Email", text: $model.emailSignUp)
                    
                    CustomTextField(image: "lock", playholder: "Password", text: $model.passwordSignUp)
                    
                    CustomTextField(image: "lock", playholder: "Re-enter Password", text: $model.reEnterPassword)
                }
                .padding(.top)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("SIGN UP")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.red)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 180)
                        .background(Color.white)
                        .clipShape(Capsule())
                })
                .padding(.top)
                
                Spacer()
            }
        }
    }
}

// MVVM Model
class ModelData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var emailSignUp = ""
    @Published var passwordSignUp = ""
    @Published var reEnterPassword = ""
    @Published var resetEmail = ""
    @Published var isLinkSent = false
    
    // AlertView with TextField
    func resetPassword() {
        let alert = UIAlertController(title: "Reset Password", message: "Enter your email address to reset your password", preferredStyle: .alert)
        
        alert.addTextField { password in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { _ in
            self.resetEmail = alert.textFields![0].text!
            
            // Presenting alert when email link has been sent
            self.isLinkSent.toggle()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

// Checking with smaller devices

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
