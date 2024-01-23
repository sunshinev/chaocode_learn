//
//  ContentView.swift
//  MyResume
//
//  Created by jaysun on 2024/1/22.
//

import SwiftUI

struct ContentView: View {
    
    let me = Resume.shared
    
    let skillImage = ["mysql","python","swift","xd"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30){
                userinfo
                skill
                expericence
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
    
    var userinfo: some View {
        VStack {
            HStack{
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 180)
                VStack(alignment: .leading, spacing: 20) {
                    Text(me.name)
                        .font(.title)
                        .bold()
                    Text(me.title)
                    Label(me.location, systemImage: "location")
                        .foregroundColor(.secondary)
                }
            }
            
            Text(me.bio)
                .frame(maxWidth: .infinity)
                .font(.title3)
                .lineSpacing(10)
            
            Text("ContactMe")
                .font(.title2.weight(.bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.brown))
        }
    }
    
    var expericence: some View {
        VStack {
            Text("Experience")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                .frame(maxWidth: .infinity,alignment: .leading)
            HStack {
                Text("1")
                VStack {
                    ForEach(me.experiences, id: \.start) { item in
                        VStack (alignment: .leading, spacing: 10){
                            Text("\(item.start)——\(item.end)")
                                .foregroundColor(.secondary)
                            Text(item.title)
                                .font(.title2.bold())
                            Text(item.company)
                                .font(.title2)
                            
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    var skill: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Skill")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                .frame(maxWidth: .infinity,alignment: .leading)
            HStack(spacing:30){
        
                ForEach(skillImage, id: \.self) { item in
                    VStack{
                        Image(item)
                            .resizable()
                            .scaledToFit()
                        Text(item)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
