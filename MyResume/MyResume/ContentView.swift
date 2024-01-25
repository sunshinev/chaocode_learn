//
//  ContentView.swift
//  MyResume
//
//  Created by jaysun on 2024/1/22.
//


// Human interface guidelines  需要学习

import SwiftUI

struct ContentView: View {
    
    let me = Resume.shared
    
    @State var isShowContactView = false
    
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
        .overlay(
           modalView
        )
        .overlay (alignment: .top){
            contactView
        }
    }
    
    var modalView: some View {
        Color(uiColor: .black)
            .edgesIgnoringSafeArea(.all)
            .opacity(isShowContactView ? 0.4 : 0)
            .onTapGesture {
                isShowContactView = false
            }
    }
    
    var contactView: some View {
        Group {
            if isShowContactView {
                ContactView(isShow: $isShowContactView)
                    .offset(y:UIScreen.main.bounds.maxY*0.2)
                    // 描述了过渡转场的效果
                    .transition(.opacity)
            }
        }
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
            
            
            Button(action: {
                print("click button 2")
                // 动画的参数，是一个时间曲线
                withAnimation {
                    isShowContactView = true
                }
            }, label: {
                Text("ContactMe")
                    .font(.title2.weight(.bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.brown))
            })
            
        }
    }
    
    var expericence: some View {
        VStack {
            Text("Experience")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack (spacing: 0){
                ForEach(me.experiences.indices, id: \.self) { index in
                    HStack {
                        DotLineShap(style: index == 0 ? .bottomHalf : index == me.experiences.count - 1 ? .topHalf : .full)
                            .frame(width: 70)
                        
                        let item = me.experiences[index]
                        
                        VStack (alignment: .leading, spacing: 10){
                            Text("\(item.start)——\(item.end)")
                                .foregroundColor(.secondary)
                            Text(item.title)
                                .font(.title2.bold())
                            Text(item.company)
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                    }
                }
            }
        }
    }
    
    var skill: some View {
        VStack {
            Text("Skill")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                .frame(maxWidth: .infinity,alignment: .leading)
            HStack {
                ForEach(me.skills, id: \.self) { item in
                    VStack {
                        Image(item.lowercased())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        Text(item)
                    }
                    .frame(width: 80)
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
