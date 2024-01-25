//
//  ContactView.swift
//  MyResume
//
//  Created by jaysun on 2024/1/23.
//

import SwiftUI

struct ContactView: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "phone")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.brown))
                    .padding(10)
                    .onTapGesture {
                        openURL(url: Resume.shared.phoneUrl)
                    }
                
                
                ForEach(Resume().socialMedia, id: \.self.name) { item in
                    Image(item.name.lowercased())
                        .resizable().aspectRatio(contentMode: .fit)
                        .padding(10)
                        .onTapGesture {
                            openURL(url: item.url)
                        }
                }
            }
   
            Text("Cancel")
                .font(.title3)
                .foregroundColor(.secondary)
                .onTapGesture {
                    isShow = false
                }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(uiColor: .tertiarySystemBackground))
        )
        .padding()
    }
    
    func openURL (url: String) {
        
        if let urlVal = URL(string: url) {
            
            if UIApplication.shared.canOpenURL(urlVal) {
                print("url can open")
                UIApplication.shared.open(urlVal)
            }else {
                print("open url failed \(url)")
            }
            
        }else {
            print("extract failed \(url)")
            return
        }
    }
}

#Preview {
    ContactView(isShow: .constant(true))
        .background(.yellow)
}
