//
//  ViewStateKey.swift
//  furniture-finalproject
//
//  Created by andra-dev on 20/08/24.
//

import SwiftUI

struct ViewStateKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var viewState: Binding<Bool> {
        get { self[ViewStateKey.self] }
        set { self[ViewStateKey.self] = newValue }
    }
}
