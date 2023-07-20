//
//  Note.swift
//  Notes Watch App
//
//  Created by Atakan Apan on 7/20/23.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
