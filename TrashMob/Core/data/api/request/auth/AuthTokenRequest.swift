//
//  AuthTokenRequest.swift
//  TrashMob
//
//  Created by Kyle Peterson on 5/6/22.
//

import Foundation

enum AuthTokenRequest: RequestProtocol {
  case auth

  var path: String {
    "/v2/oauth2/token"
  }

  var params: [String: Any] {
    [
      "grant_type": APIConstants.grantType,
      "client_id": APIConstants.clientId,
      "client_secret": APIConstants.clientSecret
    ]
  }

  var addAuthorizationToken: Bool {
    false
  }

  var requestType: RequestType {
    .POST
  }
}
