//
//  AlertContent.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import Foundation

struct AlertContent: Identifiable, Equatable {
    var id = UUID().uuidString

    enum Action: Identifiable, Equatable {
        static func == (lhs: AlertContent.Action, rhs: AlertContent.Action) -> Bool {
            switch (lhs, rhs) {
            case (let .cancel(lhsValue, _), let .cancel(rhsValue, _)),
                (let .destructive(lhsValue, _), let .destructive(rhsValue, _)),
                (let .default(lhsValue, _), let .default(rhsValue, _)):
                return lhsValue == rhsValue
            default:
                return false
            }
        }

        var id: String {
            switch self {
            case let .cancel(label, _):
                return "cancel, \(label)"
            case let .destructive(label, _):
                return "destructive, \(label)"
            case let .default(label, _):
                return "default, \(label)"
            }
        }

        case cancel(label: String, callback: () -> Void)
        case destructive(label: String, callback: () -> Void)
        case `default`(label: String, callback: () -> Void)
    }

    let title: String?
    let body: String?

    let actions: [Action]

    init(title: String? = nil, body: String? = nil, actions: [Action]) {
        self.title = title
        self.body = body
        self.actions = actions
    }
}
