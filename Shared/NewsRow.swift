//
//  NewsRow.swift
//  WWDC21
//
//  Created by Joe Stanziano on 6/8/21.
//

import Foundation
import SwiftUI

struct NewsRow: View {
    var item: NewsItem
    var placeholder = UIImage(systemName: "network")!
    @State private var image: UIImage?
    
func fetchThumbnail(for id: String) async throws -> UIImage? {
    let realString = id.replacingOccurrences(of: "\\", with: "")
    guard let url = URL(string: realString) else { return nil }
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let maybeImage = UIImage(data: data) else { return nil}
    return maybeImage
}
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image(uiImage: self.image ?? placeholder )
                    .resizable()
                    .frame(width: 40, height: 40)
                
                    .onAppear {
                        async {
                            self.image = try? await self.fetchThumbnail(for: item.main_image)
                        }
                    }
                Text(item.title)
                    .font(.headline)
                
                Text(item.strap)
                    .foregroundColor(.secondary)
            }
        }
    }
}

