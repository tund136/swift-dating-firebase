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
                
                Image(systemName: "bolt.heart.fill")
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
                
                VStack(spacing: 20) {
                    CustomTextField(image: "person", playholder: "Email", text: $model.email)
                    
                    CustomTextField(image: "lock", playholder: "Password", text: $model.password)
                }

                Spacer(minLength: 0)
            }
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
            
            TextField(playholder, text: $text)
                .padding(.horizontal)
                .padding(.leading, 65)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

// MVVM Model
class ModelData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
