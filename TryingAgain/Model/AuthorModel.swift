//
//  AuthorModel.swift
//  TryingAgain
//
//  Created by Liban Abdinur on 7/23/22.
//

import Foundation

struct AuthorModel: Codable{
    
    let authorName: String
    let books: [BookModel]
}

struct BookModel: Codable{
    let title: String
    let cover_image: String
    let pages: Int
    let releaseDate: String
}
