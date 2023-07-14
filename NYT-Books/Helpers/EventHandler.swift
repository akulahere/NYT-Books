//
//  EventHandler.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import Foundation

typealias EventHandler<EventType> = (EventType) -> Void
