//
//  ContentView.swift
//  visionOS Web Video
//
//  Created by Thomas Kackley on 2/6/24.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.mediaPlaybackRequiresUserAction = false
        webConfiguration.allowsInlineMediaPlayback = false
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebViewWrapper
        
        init(_ parent: WebViewWrapper) {
            self.parent = parent
        }
    }
}

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                WebViewWrapper(url: "https://youtube.com")
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: geo.size.width/40, height: geo.size.height/40)))
                    .padding()
                
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
