//
//  UserDefaultInfo.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/17.
//

import Foundation

struct UserDefaultInfo<Value> {
    var key: String
    var defaultValue: Value
}

extension UserDefaultInfo {
    func get() -> Value {
        // 拿不到的話就拿預設的值
        guard let valueUntyped = UserDefaults.standard.object(forKey: self.key) else {
            return self.defaultValue
        }
        guard let value = valueUntyped as? Value else {
            return self.defaultValue
        }
        return value
    }
    
    func set(_ value: Value) {
        UserDefaults.standard.set(value, forKey: self.key)
    }
}

extension UserDefaults {
    // 移除裡面自己設的key
    public func removeDefaults() {
        let defaults = UserDefaults.standard
        defaults.dictionaryRepresentation().keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

