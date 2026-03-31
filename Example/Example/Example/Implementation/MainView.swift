//
//  MainView.swift
//  CustomSideBar
//
//  Created by shubham kachhiya on 31/03/26.
//

import SwiftUI

struct MainView: View {
    
    var safeArea: EdgeInsets
    var name: String
    
    var body: some View {
        
        ZStack {
            
            Color.white
            
            VStack {
                Text(name)
                    .foregroundStyle(.black)
            }
            .padding(.top, safeArea.top)
            .padding(.bottom, safeArea.bottom)
        }
    }
}

#Preview {
    MainView(safeArea: EdgeInsets(), name: "Test")
}
