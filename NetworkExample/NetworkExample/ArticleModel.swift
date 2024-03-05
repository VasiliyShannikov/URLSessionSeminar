//
//  ArticleModel.swift
//  NetworkExample
//
//  Created by Vasiliy Shannikov on 05.03.2024.
//

import Foundation

struct ListModel: Decodable {
    let status: String?
    let articles: [ArticleModel]
}

struct ArticleModel: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

