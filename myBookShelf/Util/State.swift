//
//  State.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/05/18.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import Foundation
import EmptyStateKit

enum State: CustomState {
 
    case noNotifications
    case noSearch
    case noInternet
 
    var image: UIImage? {
        switch self {
        case .noNotifications: return UIImage(named: "Messages")
        case .noSearch: return UIImage(named: "Search")
        case .noInternet: return UIImage(named: "Internet")
        }
    }
 
    var title: String? {
        switch self {
        case .noNotifications: return "No message notifications"
        case .noSearch: return "No results"
        case .noInternet: return "We’re Sorry"
        }
    }
 
    var description: String? {
        switch self {
        case .noNotifications: return "Sorry, you don't have any message. Please come back later!"
        case .noSearch: return "Please try another search item"
        case .noInternet: return "Our staff is still working on the issue for better experience"
        }
    }
 
    var titleButton: String? {
        switch self {
        case .noNotifications: return "Search again?"
        case .noSearch: return "Save Book"
        case .noInternet: return "Try again?"
        }
    }
}
