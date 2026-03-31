//
//  ContentView.swift
//  CustomSideBar
//
//  Created by shubham kachhiya on 30/03/26.
//

import SwiftUI
import DrawerSideBar

struct ContentView: View {
    
    @State var name: String = "Main Content"
    @State var isSideBarOpened = false
    
    var body: some View {
        SideBarNavigationView(isSideBarOpened: $isSideBarOpened, sideBarWidthRatio: 0.7, mainViewScaleSize: 0.8) { safeArea in
            
            Sidebar(safeArea: safeArea, action: { name in
                self.name = name
                isSideBarOpened = false
            })
            
        } main: { safeArea in
            MainView(safeArea: safeArea, name: self.name)
        }
        
        
    }
}

#Preview {
    ContentView()
}
