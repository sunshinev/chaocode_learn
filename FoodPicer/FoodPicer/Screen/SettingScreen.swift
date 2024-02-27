//
//  SettingScreen.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/27.
//

import SwiftUI


enum Unit: String, CaseIterable, Identifiable, View {
    case gram = "g", pound="lb"
    
    var id: Self { self }
    
    var body: some View {
        Text(rawValue)
    }
}


struct SettingScreen: View {
    
    @State private var shouldUseDarkMode = false
    @State private var unit: Unit = .gram
    @State private var startTab: HomeScreen.Tab = .picker
    @State private var confirmationDialog: Dialog = .inactive
    
    private var shouldShowDialog: Binding<Bool> {
        Binding(
            get: {
                confirmationDialog != .inactive
            },
            set: { _ in confirmationDialog = .inactive }
        )
    }
    
    var body: some View {
        Form {
            Section("基本设定") {
                Toggle(isOn: $shouldUseDarkMode) {
                    Label("深色模式",systemImage: .moon)
                }
                
                Picker(selection: $unit) {
                    ForEach(Unit.allCases) { $0 }
                } label: {
                    Label("单位", systemImage: .unitSign)
                }
                
                Picker(selection: $startTab) {
                    Text("随机食物").tag(HomeScreen.Tab.picker)
                    Text("食物清单").tag(HomeScreen.Tab.list)
                } label: {
                    Label("启动画面", systemImage: .house)
                }
            }
            
            Section("危险区域") {
                ForEach(Dialog.allCases) { dialog in
                    Button(dialog.rawValue) {
                        confirmationDialog = dialog
                    }
                }
            }
            .confirmationDialog(confirmationDialog.rawValue, isPresented: shouldShowDialog, titleVisibility: .visible) {
                Button("确定",role: .destructive) {}
            } message: {
                Text(confirmationDialog.message)
            }


        }
    }
}

private enum Dialog: String, CaseIterable, Identifiable {
    case resetSetting = "重置设定"
    case resetFoodList = "重置食物清单"
    case inactive
    
    var id: Self { self }
    
    var message: String {
        switch self {
        case .resetSetting:
            return "将重置颜色、单位等设置，\n此操作无法复原，确定进行吗？"
        case .resetFoodList:
            return "将重置食物清单，\n此操作无法复原，确定进行吗？"
        case .inactive:
            return ""
        }
    }
}

#Preview {
    SettingScreen()
}


