//
//  SwiftUIView.swift
//  Gitpporter
//
//  Created by 이준혁 on 2023/01/04.
//

import SwiftUI
import WebKit

struct LoginWebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: UIViewRepresentableContext<LoginWebView>) -> WKWebView {
        let webview = WKWebView()
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
        return webview
    }
    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<LoginWebView>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}
