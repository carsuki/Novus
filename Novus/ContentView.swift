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
        
        HStack(spacing: 0){
            
            SideView().frame(minWidth: 150, maxWidth: 150, minHeight: 500, maxHeight: .infinity,  alignment: .topLeading).background(Color.primary.colorInvert().blur(radius: 8))
            
            BodyView().frame(minWidth: 300, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.primary.colorInvert())
            
        }
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
                    Image("icons8-search").resizable().frame(width: 25, height: 25)
                    
                    Circle().foregroundColor(Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255)).frame(width: 27, height: 27).overlay(Image("89728389ea0a0201f538832f194ecf0f").resizable().clipShape(Circle()).frame(width: 25, height: 25))
                }
            }
            
            }
            
            
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color(red: 160.0 / 255, green: 140.0 / 255, blue: 237.0 / 255), Color(red: 123.0 / 255, green: 94.0 / 255, blue: 191.0 / 255)]), startPoint: .leading, endPoint: .trailing)).overlay(
                HStack{
                Image("NovusLogo").resizable().frame(width: 200, height: 200, alignment: .leading)
                    
                Spacer()
                    
                VStack(alignment: .leading){
                    
                Text("Welcome to Novus").font(.headline).foregroundColor(.white)
                Text("A reimagined way of getting everything!").foregroundColor(.white).font(.caption).opacity(0.42)
                    
                }
                    
                
                    
            }.padding(40)).frame(height: 170, alignment: .leading).cornerRadius(8)
            
            
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
