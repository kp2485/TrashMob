//
//  RecyclingLocationsMock.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/4/22.
//

import Foundation

private struct RecyclingLocationsMock: Codable {
  let recyclingLocations: [RecyclingLocation]
}

private func loadRecyclingLocations() -> [RecyclingLocation] {
  guard let url = Bundle.main.url(
    forResource: "RecyclingLocationsMock",
    withExtension: "json"
  ), let data = try? Data(contentsOf: url) else { return [] }
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  let jsonMock = try? decoder.decode(RecyclingLocationsMock.self, from: data)
  return jsonMock?.recyclingLocations ?? []
}

extension RecyclingLocation {
  static let mock = loadRecyclingLocations()
}
