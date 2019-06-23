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
            
            SideView().frame(minWidth: 150, maxWidth: 150, minHeight: 500, maxHeight: .infinity,  alignment: .topLeading).background(Color.primary.colorInvert().blur(radius: 10))
            
            BodyView().frame(minWidth: 300, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.primary.colorInvert())
            
        }
    }
}

struct SideView : View {
    var body: some View {
        VStack{
            Text("Test")
            }.padding(.init(top: 50, leading: 10, bottom: 10, trailing: 10))
    }
}

struct BodyView : View {
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading) {
                Text("Monday, 22 June").font(.caption).color(.secondary)
                Text("Today").font(.title).bold()
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                HStack{
                    Image("icons8-search").resizable().frame(width: 25, height: 25)
                    
                    Circle().foregroundColor(Color.purple).frame(width: 27, height: 27).overlay(Image("89728389ea0a0201f538832f194ecf0f").resizable().clipShape(Circle()).frame(width: 25, height: 25))
                }
            }
            
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
