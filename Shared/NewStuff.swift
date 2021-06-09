//
//  NewStuff.swift
//  WWDC21
//
//  Created by Joe Stanziano on 6/8/21.
//

import SwiftUI

struct NewStuff: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
            Text("**Hello**, World!")
            Button("Add"){
                AsyncImage(url: URL(string: "https://www.hackingwithswift.com/img/paul-2.png")) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 25))

            }
            

        }
    }
}

struct NewStuff_Previews: PreviewProvider {
    static var previews: some View {
        NewStuff()
    }
}
