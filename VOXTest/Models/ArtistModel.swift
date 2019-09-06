//
//  ArtistModel.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation


struct Album: Decodable {
  let album: [DetailAlbumInfo]
}

struct DetailAlbumInfo: Decodable {
  
  let strArtist: String
  let strAlbum: String
  let strAlbumThumb: String
  
}
