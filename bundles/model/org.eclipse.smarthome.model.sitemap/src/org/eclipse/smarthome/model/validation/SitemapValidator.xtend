/**
 * Copyright (c) 2014-2017 by the respective copyright holders.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
/*
 * generated by Xtext
 */
package org.eclipse.smarthome.model.validation

import org.eclipse.smarthome.model.sitemap.Frame
import org.eclipse.smarthome.model.sitemap.LinkableWidget
import org.eclipse.smarthome.model.sitemap.Sitemap
import org.eclipse.smarthome.model.sitemap.SitemapPackage
import org.eclipse.smarthome.model.sitemap.Widget
import org.eclipse.xtext.validation.Check

//import org.eclipse.xtext.validation.Check
/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class SitemapValidator extends AbstractSitemapValidator {

	@Check
	def void checkFramesInFrame(Frame frame) {
		for (Widget w : frame.children) {
			if (w instanceof Frame) {
				error("Frames must not contain other frames",
					SitemapPackage.Literals.FRAME.getEStructuralFeature(SitemapPackage.FRAME__CHILDREN));
				return;
			}
		}
	}

	@Check
	def void checkFramesInWidgetList(Sitemap sitemap) {
		var containsFrames = false
		var containsOtherWidgets = false

		for (Widget w : sitemap.children) {
			if (w instanceof Frame) {
				containsFrames = true
			} else {
				containsOtherWidgets = true
			}
			if (containsFrames && containsOtherWidgets) {
				error("Sitemap should contain either only frames or none at all",
					SitemapPackage.Literals.SITEMAP.getEStructuralFeature(SitemapPackage.SITEMAP__NAME));
				return
			}
		}
	}

	@Check
	def void checkFramesInWidgetList(LinkableWidget widget) {
		if (widget instanceof Frame) {

			// we have a dedicated check for frames in place
			return;
		}
		var	containsFrames = false
		var	containsOtherWidgets = false
		for (Widget w : widget.children) {
			if (w instanceof Frame) {
				containsFrames = true
			} else {
				containsOtherWidgets = true
			}
			if (containsFrames && containsOtherWidgets) {
				error("Linkable widget should contain either only frames or none at all",
					SitemapPackage.Literals.FRAME.getEStructuralFeature(SitemapPackage.LINKABLE_WIDGET__CHILDREN));
				return
			}
		}
	}

}
