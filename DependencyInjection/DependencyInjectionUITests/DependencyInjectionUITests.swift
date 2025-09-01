//
//  DependencyInjectionUITests.swift
//  DependencyInjectionUITests
//
//  Created by Sushant Verma on 1/9/2025 for DevWorld 2025 (devworld.au)
//

import XCTest

final class DependencyInjectionUITests: XCTestCase {

    struct ScreenState {
        let imageName: String
        let text: String
    }

    @MainActor
    func testExample() throws {
        let expectedStates: [ScreenState] = [ // As per `SortedMessageService`
            .init(imageName: "apple.logo", text: "Apples are red"),
            .init(imageName: "carrot.fill", text: "Carrots make you strong"),
            .init(imageName: "Leaf", text: "Leafs can fly in the wind"),
            .init(imageName: "Flash", text: "Lightning is scary"),
            .init(imageName: "Do Not Disturb", text: "The moon is soothing"),
            .init(imageName: "sun.haze.fill", text: "The sun is bright"),
            .init(imageName: "Water Drop", text: "Water is refreshing"),
        ]

        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchEnvironment["RUNNING_FOR_UI_TEST"] = "1"
        app.launch()

        let actionButton = app.buttons["action-button"]
        let imageView = app.images["image-icon"]
        let textView = app.staticTexts["text-label"]

        for state in expectedStates {
            XCTAssertEqual(state.imageName, imageView.label)
            XCTAssertEqual(state.text, textView.label)
            actionButton.tap()
        }

        // back to the start
        XCTAssertEqual(expectedStates.first?.imageName, imageView.label)
        XCTAssertEqual(expectedStates.first?.text, textView.label)
    }
}
