//
//  MDCPagination.swift
//
//  Created by Philip Starner on 8/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class MDCPagination {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let perPage = "perPage"
    static let currentPage = "currentPage"
  }

  // MARK: Properties
  public var perPage: Int?
  public var currentPage: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    perPage = json[SerializationKeys.perPage].int
    currentPage = json[SerializationKeys.currentPage].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = perPage { dictionary[SerializationKeys.perPage] = value }
    if let value = currentPage { dictionary[SerializationKeys.currentPage] = value }
    return dictionary
  }

}
