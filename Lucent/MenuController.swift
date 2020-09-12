//
//  MenuController.swift
//  Lucent
//
//  Created by Huw Rowlands on 12/9/20.
//  Copyright © 2020 Huw Rowlands. All rights reserved.
//

import Cocoa

final class MenuController {

	private let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

	private lazy var slider: NSSlider = {
		let slider = NSSlider()
		slider.setFrameSize(NSSize(width: 172, height: 30))
		slider.floatValue = NSScreen.main?.brightness ?? 0
		slider.target = self
		slider.action = #selector(sliderMoved(sender:))
		return slider
	}()

	private lazy var sliderContainer: NSView = {
		let view = NSView()
		view.setFrameSize(NSSize(width: 200, height: 30))
		view.addSubview(slider)
		slider.setFrameOrigin(NSPoint(x: 18, y: 0))
		return view
	}()

	init() {
		item.button?.image = NSImage(named: NSImage.Name("sun"))

		let menu = NSMenu()

		let menuItem = NSMenuItem()
		menuItem.view = sliderContainer

		menu.addItem(NSMenuItem(title: "Brightness:", action: nil, keyEquivalent: ""))
		menu.addItem(menuItem)

		menu.addItem(NSMenuItem.separator())

		let openDisplayItem = NSMenuItem(title: "Display Preferences…", action: #selector(openDisplayPreferences(_:)), keyEquivalent: "")
		openDisplayItem.target = self
		menu.addItem(openDisplayItem)

		item.menu = menu
	}

	@objc func sliderMoved(sender: NSSlider) {
		print("new value: \(sender.floatValue)")
		NSScreen.main?.brightness = sender.floatValue
	}

	@objc func openDisplayPreferences(_ sender: Any?) {
		NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Displays.prefPane"))
	}

}
