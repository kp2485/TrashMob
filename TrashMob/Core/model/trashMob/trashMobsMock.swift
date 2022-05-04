//
//  TrashMobsMock.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/4/22.
//

import Foundation


private struct TrashMobsMock: Codable {
  let trashMobs: [TrashMob]
}

private func loadTrashMobs() -> [TrashMob] {
  guard let url = Bundle.main.url(
    forResource: "TrashMobsMock",
    withExtension: "json"
  ), let data = try? Data(contentsOf: url) else { return [] }
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  let jsonMock = try? decoder.decode(TrashMobsMock.self, from: data)
  return jsonMock?.trashMobs ?? []
}

extension TrashMob {
  static let mock = loadTrashMobs()
}
