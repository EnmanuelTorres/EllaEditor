//
//  FilterType.swift
//  EllaEditor
//
//  Created by ENMANUEL TORRES on 15/10/24.
//

enum FilterType {
    case normal
    case vivid
    case vividWarm
    
    var displayName: String {
        switch self {
        case .normal:
            return "Normal"
        case .vivid:
            return "Vivid"
        case .vividWarm:
            return "Vivid Warm"
        }
    }
}
