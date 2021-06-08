//
//  NewsList.swift
//  WWDC21
//
//  Created by Joe Stanziano on 6/8/21.
//

import Foundation
import SwiftUI

struct NewsItem: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let strap: String
}
struct SearchSuggestions: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
}

struct NewsList: View {
    @State private var searchText = ""
    @State private var news = [
        NewsItem(id: 0, title: "The latest news", strap: "pull to refresh")
    ]
    
    @State private var suggestions = [
        SearchSuggestions(id: 0, title: "WWDC"),
        SearchSuggestions(id: 1, title: "SwiftUI"),
        SearchSuggestions(id: 2, title: "iOS")
    ]
    
    var searchResults: [NewsItem] {
        if searchText.isEmpty {
            return news
        } else {
            return news.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.strap.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(searchResults, id: \.self) { item in
                    NavigationLink(destination: Text(item.strap)){
                        VStack(alignment: .leading){
                            Text(item.title)
                                .font(.headline)
                                
                            Text(item.strap)
                                .foregroundColor(.secondary)
                        }
                       
                    }
                    .swipeActions {
                        Button("Like"){
                            print("I like \(item.title)")
                        }.tint(.mint)
                    }
                }
            }
            .navigationTitle("Trending News")
            .refreshable {
                do {
                    let url = URL(string: "https://www.hackingwithswift.com/samples/news-1.json")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    news = try JSONDecoder().decode([NewsItem].self, from: data)
                } catch {
                    print("oops")
                    news = []
                }
            }
        }
        .searchable(text: $searchText) {
            if searchText.count >= 3 {
                ForEach(searchResults, id: \.self) { result in
                    Text("Are you looking for \(result.title)?")
                        .searchCompletion(result.strap)
                }
            } else {
                ForEach(suggestions, id: \.self) { suggestion in
                    Text(suggestion.title)
                        .searchCompletion(suggestion.title)
                }
            }
        }
    }
}
