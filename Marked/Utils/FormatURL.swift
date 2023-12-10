//
//  FormatURL.swift
//  Marked
//
//  Created by Louis Farmer on 12/7/23.
//

import Foundation

func formatURL(_ inputURL: String) -> String {
    var formattedURL = inputURL

    // Check if the scheme is missing or not https
    if !formattedURL.lowercased().hasPrefix("https://") {
        if !formattedURL.lowercased().hasPrefix("http://") {
            formattedURL = "https://" + formattedURL
        }
    }

    // Check if the host is missing www.
    if let hostRange = formattedURL.range(of: "://www.") {
        // Already contains www., do nothing
    } else if let hostRange = formattedURL.range(of: "://") {
        // Insert www. after ://
        formattedURL.insert(contentsOf: "www.", at: hostRange.upperBound)
    }

    return formattedURL
}

//Helps with keeping URls and images looking good in the app, but the url that is always stored is https://www.examples.exm
func stripURL(_ inputURL: String) -> String {
    var strippedURL = inputURL

    // Remove https://
    strippedURL = strippedURL.replacingOccurrences(of: "https://", with: "")
    
    strippedURL = strippedURL.replacingOccurrences(of: "http://", with: "")

    // Remove www.
    strippedURL = strippedURL.replacingOccurrences(of: "www.", with: "")

    return strippedURL
}
