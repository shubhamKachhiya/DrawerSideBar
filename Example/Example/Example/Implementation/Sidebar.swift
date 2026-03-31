//
//  Sidebar.swift
//  CustomSideBar
//
//  Created by shubham kachhiya on 30/03/26.
//

import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

struct Sidebar: View {
    
    var safeArea: EdgeInsets
    var action: (_ name: String) -> ()
    
    let menuItems: [MenuItem] = [
            MenuItem(icon: "doc.text", title: "My Journal"),
            MenuItem(icon: "face.smiling", title: "Insights Mood"),
            MenuItem(icon: "brain.head.profile", title: "AI Trucker’s Coach"),
            MenuItem(icon: "crown", title: "My Subscription"),
            MenuItem(icon: "trash", title: "Trash Bin"),
            MenuItem(icon: "phone", title: "Contact Us"),
            MenuItem(icon: "info.circle", title: "About Us"),
            MenuItem(icon: "lock.shield", title: "Privacy Policy"),
            MenuItem(icon: "doc.plaintext", title: "Terms and Conditions")
        ]
    
    var body: some View {
        ZStack{
            Color.blue
            
            VStack(alignment: .leading, spacing: 50) {
                
                VStack(alignment: .leading, spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                    
                    Text("David Smith")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 20){
                    ForEach(menuItems) { item in
                        MenuRow(item: item)
                            .onTapGesture {
                                action(item.title)
                            }
                    }
                }
            }
            .padding(.top, safeArea.top)
            .padding(.bottom, safeArea.bottom)
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    Sidebar(safeArea: EdgeInsets(), action: {name in })
}

struct MenuRow: View {
    let item: MenuItem
    
    var body: some View {
        HStack {
            Image(systemName: item.icon)
                .frame(width: 24)
                .fontWeight(.bold)
            
            Text(item.title)
                .font(.subheadline)
                .fontWeight(.bold)
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundColor(.white)
    }
}
