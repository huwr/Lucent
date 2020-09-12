//
//  NSScreen+Brightness.swift
//  Lucent
//
//  Created by Huw Rowlands on 12/9/20.
//  Copyright © 2020 Huw Rowlands. All rights reserved.
//

import Cocoa

extension NSScreen {

	var brightness: Float {
		get {
			findBrightness()
		}

		set {
			setBrightness(to: newValue)
		}
	}

	/* Dear Huw, this works, sort of… It would be better to use the private API to set the brightness properly. */

	private func findBrightness() -> Float {
		var iterator: io_iterator_t = 0
		var level: Float = 0

		if IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator) == kIOReturnSuccess {
			let service = IOIteratorNext(iterator)
			IODisplayGetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, &level)
		}

		return level
	}

	private func setBrightness(to level: Float) {
		var iterator: io_iterator_t = 0

		if IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator) == kIOReturnSuccess {
			var service: io_object_t = 1

			/* do for each display */
			while service != 0 {
				service = IOIteratorNext(iterator)
				IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, level)

				IOObjectRelease(service)
			}

		}
	}
}
