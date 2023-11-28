//
//  NewsModel.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import Foundation

struct responceBurger: Codable {
    let status: String
    let totalResults: Int
    let articles: [newsBurger]
}

struct newsBurger: Codable {
    let source: counterStrike
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

struct counterStrike: Codable {
    let id: String?
    let name: String
}
