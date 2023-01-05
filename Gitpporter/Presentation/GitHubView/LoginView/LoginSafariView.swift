//
//  LoginSafariView.swift
//  Gitpporter
//
//  Created by 이준혁 on 2023/01/05.
//

import SwiftUI
import SafariServices

struct LoginSafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<LoginSafariView>) {
        return
    }
}
