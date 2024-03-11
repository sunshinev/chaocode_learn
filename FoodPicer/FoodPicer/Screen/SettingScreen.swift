//
//  SettingScreen.swift
//  FoodPicer
//
//  Created by jaysun on 2024/2/27.
//

import SwiftUI


extension UserDefaults {
    enum Key: String {
        case shouldUseDarkMode
        case startTab
        case foodList
        case preferredWeightUnit
        case preferredEnergyUnit
    }
}

extension AppStorage {
    init(wrappedValue: Value, _ k: UserDefaults.Key, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue, k.rawValue,store: store)
    }
    init(wrappedValue: Value, _ k: UserDefaults.Key, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, k.rawValue,store: store)
    }
}


extension AppStorage where Value: MyUnitProtocol {
    init(wrappedValue: Value = .defaultUnit, _ k: UserDefaults.Key, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, k.rawValue,store: store)
    }
}

struct SettingScreen: View {
    @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode: Bool = false
    @AppStorage(.preferredWeightUnit) private var unit: MyWeightUnit
    @AppStorage(.startTab) private var startTab: HomeScreen.Tab = .picker
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
        Form(content:  {
            Section("基本设定") {
                List {
                    Toggle(isOn: $shouldUseDarkMode) {
                        Label("深色模式",systemImage: .moon)
                    }
                    
                    Picker(selection: $unit) {
                        ForEach(MyWeightUnit.allCases) { $0 }
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
            }
            
            Section("危险区域") {
                ForEach(Dialog.allCases) { dialog in
                    Button(dialog.rawValue) {
                        confirmationDialog = dialog
                    }
                }
            }
            .confirmationDialog(confirmationDialog.rawValue, isPresented: shouldShowDialog, titleVisibility: .visible) {
                Button("确定",role: .destructive) {
                    confirmationDialog.action()
                }
            } message: {
                Text(confirmationDialog.message)
            }
        })
    }
}

private enum Dialog: String, CaseIterable, Identifiable {
    case resetSetting = "重置设定"
    case resetFoodList = "重置食物清单"
    case inactive
    
    var id: Self { self }
    
    static let allCases: [Dialog] = [.resetSetting, .resetFoodList]
    
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
    
    func action() {
        switch self {
        case .resetSetting:
            let key: [UserDefaults.Key] = [.shouldUseDarkMode,.startTab,.preferredWeightUnit]
            key.forEach { k in
                UserDefaults.standard.removeObject(forKey: k.rawValue)
            }
        case .resetFoodList:
            UserDefaults.standard.removeObject(forKey: UserDefaults.Key.foodList.rawValue)
            return
        case .inactive:
            return
        }
    }
}


#Preview {
    SettingScreen()
}


