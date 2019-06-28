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
                        Circle().frame(width: 32, height: 32).overlay(Image("OlympusProfilePicture").resizable().clipShape(Circle()).frame(width: 30, height: 30))
                    }
                }
                
            }
            
            
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color("GradientColorSetNumberOne"), Color("GradientColorSetNumberTwo")]), startPoint: .leading, endPoint: .trailing)).overlay(
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
                }.foregroundColor(Color("BlankCardColors"))
            
            
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
