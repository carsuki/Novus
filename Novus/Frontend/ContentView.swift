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
        
        HStack(spacing: 0){

            List{
                Spacer()
                VStack(alignment: .leading){
                    HStack(spacing: 3){
                        Image("Store").resizable().frame(width: 20, height: 20).colorMultiply(selected == "today" || selected == "news" || selected == "updates" ? Color("SideBarColorHighlighting") : .gray)
                        Text("Store").font(.body).color(.gray)
                    }
                    VStack(alignment: .leading, spacing: 10){
                        Text("Today").color(selected == "today" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "today"
                        }
                        Text("News").color(selected == "news" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "news"
                        }
                        Text("Updates").color(selected == "updates" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "updates"
                        }
                        Spacer()
                        }.padding(.leading)
                    HStack(spacing: 3){
                        Image("Categories").resizable().frame(width: 20, height: 20).colorMultiply(selected == "applications" || selected == "addons" || selected == "themes" ? Color("SideBarColorHighlighting") : .gray)
                        Text("Categories").font(.body).color(.gray)
                    }
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text("Applications").color(selected == "applications" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "applications"
                        }
                        Text("Addons").color(selected == "addons" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "addons"
                        }
                        Text("Themes").color(selected == "themes" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "themes"
                            
                        }
                        Spacer()
                        }.padding(.leading)
                    
                    HStack(spacing: 3){
                        Image("Manage").resizable().frame(width: 20, height: 20).colorMultiply(selected == "repositories" || selected == "packages" ? Color("SideBarColorHighlighting") : .gray)
                        Text("Manage").font(.body).color(.gray)
                        
                    }
                    VStack(alignment: .leading, spacing: 10){ Text("Repositories").color(selected == "repositories" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                        self.selected = "repositories"
                        }
                        Text("Packages").color(selected == "packages" ? Color("SideBarColorHighlighting") : .gray).tapAction {
                            self.selected = "packages"
                        }
                        }.padding(.leading)
                }
                
                }.listStyle(.sidebar).frame(width: 200)
            
            if selected == "today"{

            Today().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "news" {
                
                News().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "updates" {
                
                Updates().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "applications" {
                
                Applications().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "addons" {
                
                Addons().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "themes" {
                
                Themes().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "repositories" {
                
                Repositories().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            } else if selected == "packages" {
                
                Packages().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .top).background(Color.secondary.colorInvert())
                
            }

        }
        
        
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity,  alignment: .topLeading)
    }
}
#endif
}
