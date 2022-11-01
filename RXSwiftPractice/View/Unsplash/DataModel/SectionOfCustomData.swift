//
//  SectionOfCustomData.swift
//  RXSwiftPractice
//
//  Created by 신동희 on 2022/11/01.
//

import Foundation
import Differentiator


struct SectionOfCustomData {
  var header: String
  var items: [SearchResult]
}


extension SectionOfCustomData: SectionModelType {
   init(original: SectionOfCustomData, items: [SearchResult]) {
    self = original
    self.items = items
  }
}
