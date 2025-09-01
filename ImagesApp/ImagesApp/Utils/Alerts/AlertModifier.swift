//
//  AlertModifier.swift
//  ImagesApp
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var alert: AlertContent?

    var showAlert: Binding<Bool> { Binding<Bool> {
        alert != nil
    } set: { newValue, _ in
        guard newValue == false else { return }
        alert = nil
    }
    }

    func body(content: Content) -> some View {
        content.alert(alert?.title ?? "",
                      isPresented: showAlert,
                      presenting: alert) { alert in

            ForEach(alert.actions) { action in
                switch action {
                case let .cancel(label, callback):
                    Button(label, role: ButtonRole.cancel, action: callback)
                case let .destructive(label, callback):
                    Button(label, role: ButtonRole.destructive, action: callback)
                case let .default(label, callback):
                    Button(label, action: callback)
                }
            }
        } message: { alert in
            if let body = alert.body {
                Text(body)
            }
        }
    }
}
