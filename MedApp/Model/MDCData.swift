//
//  MDCData.swift
//
//  Created by Philip Starner on 8/13/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class MDCData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let topics = "topics"
    static let media = "media"
    static let slug = "slug"
    static let id = "id"
    static let createdAt = "createdAt"
    static let updatedAt = "updatedAt"
    static let title = "title"
    static let likesCount = "likesCount"
    static let attribution = "attribution"
    static let url = "url"
    static let body = "body"
  }

  // MARK: Properties
  public var summary: String?
  public var topics: [MDCTopics]?
  public var media: [MDCMedia]?
  public var slug: String?
  public var id: Int?
  public var createdAt: String?
  public var updatedAt: String?
  public var title: String?
  public var likesCount: Int?
  public var attribution: MDCAttribution?
  public var url: String?
  public var body: String?

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
    summary = json[SerializationKeys.summary].string
    if let items = json[SerializationKeys.topics].array { topics = items.map { MDCTopics(json: $0) } }
    if let items = json[SerializationKeys.media].array { media = items.map { MDCMedia(json: $0) } }
    slug = json[SerializationKeys.slug].string
    id = json[SerializationKeys.id].int
    createdAt = json[SerializationKeys.createdAt].string
    updatedAt = json[SerializationKeys.updatedAt].string
    title = json[SerializationKeys.title].string
    likesCount = json[SerializationKeys.likesCount].int
    attribution = MDCAttribution(json: json[SerializationKeys.attribution])
    url = json[SerializationKeys.url].string
    body = json[SerializationKeys.body].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = topics { dictionary[SerializationKeys.topics] = value.map { $0.dictionaryRepresentation() } }
    if let value = media { dictionary[SerializationKeys.media] = value.map { $0.dictionaryRepresentation() } }
    if let value = slug { dictionary[SerializationKeys.slug] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = likesCount { dictionary[SerializationKeys.likesCount] = value }
    if let value = attribution { dictionary[SerializationKeys.attribution] = value.dictionaryRepresentation() }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = body { dictionary[SerializationKeys.body] = value }
    return dictionary
  }

}
