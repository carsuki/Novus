//
//  ContentView.swift
//  NovusUI
//
//  Created by Reuben Catchpole on 23/06/19.
//  Copyright © 2019 Reuben Catchpole. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        
        HStack(alignment: .center){
            
//            List{
//
//                Button(action: {}, label: { Text("Today") })
//                Button(action: {}, label: { Text("News") })
//                Button(action: {}, label: { Text("Updates") })
//            }.listStyle(.sidebar).frame(width: 200).padding(.top)
//
//            BodyView().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.primary.colorInvert())

            
            Button(action: {}) {Text("Add Source")}
            
            Spacer()
            
            Button(action: {}) {Text("Refresh")}
            
            Spacer()
            
            Button(action: {}) {Text("Install")}
            
        }.frame(width: 800, height: 500).padding(.all)
            
    }
}

struct SideView : View {
    var body: some View {
        VStack{
            TextField(.constant(""), placeholder: Text("Search for packages"))
            }.padding(.init(top: 35, leading: 10, bottom: 10, trailing: 10))
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
            }.foregroundColor(.init(white: 0.95))
            
            
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
