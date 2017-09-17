//
//  SoundList.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-16.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit

class Ringtone {
	var name: String = ""
	var url: String = ""
	var ext: String = ""
	
	init(name: String, url: String, ext: String) {
		self.name = name
		self.url = url
		self.ext = ext
	}
}

internal struct Sounds {
	internal static let apex = Ringtone(name: "Apex", url: "Apex", ext: "mp3")
	internal static let beacon = Ringtone(name: "Beacon", url: "Beacon", ext: "mp3")
	internal static let bulletin = Ringtone(name: "Bulletin", url: "Bulletin", ext: "mp3")
	internal static let byTheSeaside = Ringtone(name: "By The Seaside", url: "By The Seaside", ext: "mp3")
	internal static let chimes = Ringtone(name: "Chimes", url: "Chimes", ext: "mp3")
	internal static let circuit = Ringtone(name: "Circuit", url: "Circuit", ext: "mp3")
	internal static let constellation = Ringtone(name: "Constellation", url: "Constellation", ext: "mp3")
	internal static let cosmic = Ringtone(name: "Cosmic", url: "Cosmic", ext: "mp3")
	internal static let crystals = Ringtone(name: "Crystals", url: "Crystals", ext: "mp3")
	internal static let hillside = Ringtone(name: "Hillside", url: "Hillside", ext: "mp3")
	internal static let illuminate = Ringtone(name: "Illuminate", url: "Illuminate", ext: "mp3")
	internal static let nightOwl = Ringtone(name: "Night Owl", url: "Night Owl", ext: "mp3")
	internal static let opening = Ringtone(name: "Opening", url: "Opening", ext: "mp3")
	internal static let playtime = Ringtone(name: "Playtime", url: "Playtime", ext: "mp3")
	internal static let presto = Ringtone(name: "Presto", url: "Presto", ext: "mp3")
	internal static let radar = Ringtone(name: "Radar", url: "Radar", ext: "mp3")
	internal static let radiate = Ringtone(name: "Radiate", url: "Radiate", ext: "mp3")
	internal static let ripples = Ringtone(name: "Ripples", url: "Ripples", ext: "mp3")
	internal static let sencha = Ringtone(name: "Sencha", url: "Sencha", ext: "mp3")
	internal static let signal = Ringtone(name: "Signal", url: "Signal", ext: "mp3")
	internal static let silk = Ringtone(name: "Silk", url: "Silk", ext: "mp3")
	internal static let slowRise = Ringtone(name: "Slow Rise", url: "Slow Rise", ext: "mp3")
	internal static let stargaze = Ringtone(name: "Stargaze", url: "Stargaze", ext: "mp3")
	internal static let summit = Ringtone(name: "Summit", url: "Summit", ext: "mp3")
	internal static let twinkle = Ringtone(name: "Twinkle", url: "Twinkle", ext: "mp3")
	internal static let uplift = Ringtone(name: "Uplift", url: "Uplift", ext: "mp3")
	internal static let waves = Ringtone(name: "Waves", url: "Waves", ext: "mp3")
	
}


func getRingtones() -> [Ringtone] {
	return [
		Sounds.apex,
		Sounds.beacon,
		Sounds.bulletin,
		Sounds.byTheSeaside,
		Sounds.chimes,
		Sounds.circuit,
		Sounds.constellation,
		Sounds.cosmic,
		Sounds.crystals,
		Sounds.hillside,
		Sounds.illuminate,
		Sounds.nightOwl,
		Sounds.opening,
		Sounds.playtime,
		Sounds.presto,
		Sounds.radar,
		Sounds.radiate,
		Sounds.ripples,
		Sounds.sencha,
		Sounds.signal,
		Sounds.silk,
		Sounds.slowRise,
		Sounds.stargaze,
		Sounds.summit,
		Sounds.twinkle,
		Sounds.uplift,
		Sounds.waves
	]
}
