//
//  ContentView.swift
//  NovusUI
//
//  Created by Reuben Catchpole on 23/06/19.
//  Copyright © 2019 Reuben Catchpole. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State var selected = "today"
    
    var body: some View {
        
//        HStack(spacing: 0){
//
//            List{
//                Spacer()
//                VStack(alignment: .leading){
//                HStack(spacing: 3){
//                Image("icons-76").resizable().frame(width: 20, height: 20).colorMultiply(selected == "today" || selected == "news" || selected == "updates" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray)
//                    Text("Store").font(.body).color(.gray)
//                }
//                VStack(alignment: .leading, spacing: 10){
//                    Text("Today").color(selected == "today" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "today"
//                    }
//                    Text("News").color(selected == "news" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "news"
//                    }
//                    Text("Updates").color(selected == "updates" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "updates"
//                    }
//                Spacer()
//                }.padding(.leading)
//                HStack(spacing: 3){
//                    Image("icons-77").resizable().frame(width: 20, height: 20).colorMultiply(selected == "applications" || selected == "tweaks" || selected == "themes" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray)
//                    Text("Categories").font(.body).color(.gray)
//                }
//                VStack(alignment: .leading, spacing: 10){
//
//                    Text("Applications").color(selected == "applications" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "applications"
//                    }
//                    Text("Tweaks").color(selected == "tweaks" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "tweaks"
//                    }
//                    Text("Themes").color(selected == "themes" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "themes"
//                    }
//                Spacer()
//                }.padding(.leading)
//
//                HStack(spacing: 3){
//                   Image("icons-78").resizable().frame(width: 20, height: 20).colorMultiply(selected == "repositories" || selected == "packages" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray)
//                    Text("Manage").font(.body).color(.gray)
//
//                }
//                    VStack(alignment: .leading, spacing: 10){ Text("Repositories").color(selected == "repositories" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                        self.selected = "repositories"
//                        }
//                        Text("Packages").color(selected == "packages" ? Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255) : .gray).tapAction {
//                            self.selected = "packages"
//                        }
//                }.padding(.leading)
//                }
//
//            }.listStyle(.sidebar).frame(width: 200)
//
//            BodyView().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
//
//        }
        
        HStack(alignment: .center){
            
            Button(action: {runAPT}) {Text("Add Source")}

            Spacer()

            Button(action: {}) {Text("Refresh")}

            Spacer()

            Button(action: {}) {Text("Install")}

        }.frame(width: 300, height: 300).padding(.all)
            
    }
}

struct SideView : View {
    var body: some View {
        VStack{
            TextField(.constant(""), placeholder: Text("Search for packages"))
            }
    }
}

struct BodyView : View {
    var body: some View {
        VStack{
        HStack(alignment: .top){
            VStack(alignment: .leading) {
                Text("Monday, 22 June").font(.caption).color(.secondary)
                Text("Today").font(.title).bold()
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack{
                    Circle().foregroundColor(Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255)).frame(width: 32, height: 32).overlay(Image("89728389ea0a0201f538832f194ecf0f").resizable().clipShape(Circle()).frame(width: 30, height: 30))
                }
            }
            
            }
            
            
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(red: 160.0 / 255, green: 140.0 / 255, blue: 237.0 / 255), Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255)]), startPoint: .leading, endPoint: .trailing)).overlay(
                HStack{
                    VStack {
                        Image("NovusLogo").resizable().aspectRatio(1, contentMode: .fit)
                        
                    }
                    
                    
                VStack(alignment: .leading){
                    
                Text("Welcome to Novus").font(.title).color(.white).bold()
                Text("A reimagined way of getting everything!").color(.white).font(.subheadline).opacity(0.42)
                    
                }
                    
                
                    
            }.padding(40)).cornerRadius(8)
            
            HStack{
                RoundedRectangle(cornerRadius: 8)
                RoundedRectangle(cornerRadius: 8)
            }.foregroundColor(.init(white: 0.92))
            
            
        }.padding(.all)
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .topLeading)
    }
}
#endif
