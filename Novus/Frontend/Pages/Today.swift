//
//  Today.swift
//  Novus
//
//  Created by Reuben Catchpole on 28/06/19.
//  Copyright © 2019 PolarTeam. All rights reserved.
//

import SwiftUI

struct Today : View {
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
                        Circle().frame(width: 32, height: 32).overlay(Image("89728389ea0a0201f538832f194ecf0f").resizable().clipShape(Circle()).frame(width: 30, height: 30))
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
struct Today_Previews : PreviewProvider {
    static var previews: some View {
        Today()
    }
}
#endif
