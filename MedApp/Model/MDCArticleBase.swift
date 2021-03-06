//
//  MDCArticleBase.swift
//
//  Created by Philip Starner on 8/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class MDCArticleBase {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pagination = "pagination"
    static let data = "data"
  }

  // MARK: Properties
  public var pagination: MDCPagination?
  public var data: [MDCData]?

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
    pagination = MDCPagination(json: json[SerializationKeys.pagination])
    if let items = json[SerializationKeys.data].array { data = items.map { MDCData(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pagination { dictionary[SerializationKeys.pagination] = value.dictionaryRepresentation() }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
