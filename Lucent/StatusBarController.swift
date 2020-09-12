//
//  StatusItemController.swift
//  Lucent
//
//  Created by Huw Rowlands on 12/9/20.
//  Copyright © 2020 Huw Rowlands. All rights reserved.
//

import Cocoa

final class StatusItemController {

	private lazy var eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
		if self?.popover.isShown == true {
			self?.closePopover(sender: event)
		}
	}
	private let item: NSStatusItem

	private let popover: NSPopover = {
		let popover = NSPopover()
		popover.contentViewController = ViewController.fromStoryboard
		return popover
	}()

	init(title: String) {
		self.item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
		item.button?.title = "☀️"
		item.button?.action = #selector(togglePopover(_:))
	}

	@objc func togglePopover(_ sender: NSButton) {
		if popover.isShown {
			closePopover(sender: sender)
		} else {
			showPopover(sender: sender)
		}
	}

	func showPopover(sender: Any?) {
		if let button = item.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
			eventMonitor.start()
		}
	}

	func closePopover(sender: Any?) {
		popover.performClose(sender)
		eventMonitor.stop()
	}

}
