//
//  MenuController.swift
//  Lucent
//
//  Created by Huw Rowlands on 12/9/20.
//  Copyright © 2020 Huw Rowlands. All rights reserved.
//

import Cocoa

final class MenuController {

	private let item: NSStatusItem

	init(title: String) {
		self.item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
		item.button?.image = NSImage(named: NSImage.Name("sun"))

		let menu = NSMenu()
		let menuItem = NSMenuItem()
		let statusSlider = NSSlider()
		statusSlider.setFrameSize(NSSize(width: 200, height: 20))
		statusSlider.target = self
		statusSlider.action = #selector(sliderMoved(sender:))

		menu.addItem(NSMenuItem(title: "Brightness:", action: nil, keyEquivalent: ""))

		menuItem.title = "Slider 1"
		menuItem.view = statusSlider
		menu.addItem(menuItem)

		menu.addItem(NSMenuItem.separator())

		item.menu = menu
	}

	@objc func sliderMoved(sender: NSSlider) {
		print("new value: \(sender.floatValue)")
		NSScreen.main?.brightness = sender.floatValue
	}

}
