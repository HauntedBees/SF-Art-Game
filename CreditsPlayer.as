package {
	import flash.display.DisplayObjectContainer;
	/**
	 * Shitty Fucking Art Game
	 * @author Sean Finch
	 * @version 27APR2011
	 */
	/*	Copyright © 2011 - 2015 Sean Finch

    This file is part of Shitty Fucking Art Game.

    bang is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    bang is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with bang.  If not, see <http://www.gnu.org/licenses>. */
	public class CreditsPlayer extends CreditsEntity {
		private var stepCount:int;
		public var arrested:Boolean;
		public var arrestTimer:int;
		public var appliedForce:Number;
		private var grabPower:int;
		private var prevkeys:uint;
		public function CreditsPlayer(layer:DisplayObjectContainer, collideLayer:DisplayObjectContainer, dx:int, dy:int) {
			super(layer, collideLayer);
			icon = new protagonist();
			icon.x = dx;
			icon.y = dy;
			jumptimer = 0;
			arrestTimer = 0;
			arrested = false;
			_parent.addChild(icon);
			stepCount = 0;
			appliedForce = 0;
			grabPower = 2000;
			prevkeys = 0;
		}
		public function getKeys(keys:uint):void {
			icon.rotation = 0;
			if (!collide.hitTestPoint(icon.x, icon.y + icon.height / 2 + 2, true)) {
				jumping = true;
			}
			if (arrestTimer == 0 && !arrested) {
				prevkeys = 0;
				appliedForce = 0;
				if (!thud) {
					if (keys & 2) {
						icon.gotoAndStop(2);
						icon.scaleX = -1;
						icon.x -= 5;
						stepCount += 1;
					} else if (keys & 4) {
						icon.gotoAndStop(2);
						icon.scaleX = 1;
						icon.x += 5;
						stepCount += 1;
					} else {
						icon.gotoAndStop(1);
					}
					if (keys & 1) {
						if (!jumping && jumptimer == 0) {
							jumptimer = 12;
							if (!SelectionMemory.soundOff) {
								SelectionMemory.sHandler.jump.play();
							}
						}
						jumping = true;
						if (jumptimer > 0) {
							jumptimer -= 1;
							icon.y -= jumptimer;
							fallVelocity = 0;
						}
					}
					/*if ((keys & 8) && !jumping) {
						icon.y += icon.height / 1.5;
						jumping = true;
					}*/
					if (stepCount > 6 && !jumping) {
						stepCount = 0;
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.step.play();
						}
					}
				} else {
					icon.gotoAndStop(6);
				}
			} else {
				if (keys > 0 && (keys != prevkeys) && !arrested) {
					appliedForce += 1 + (grabPower / 1000) * Math.random();
					icon.rotation = 360 * Math.random();
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.jump.play();
					}
					icon.x += -3 + 6 * Math.random();
					prevkeys = keys;
				}
				icon.gotoAndStop(4);
				if (arrestTimer >= 3) {
					arrested = true;
					icon.gotoAndStop(7);
				}
				arrestTimer = 0;
			}
			if (arrested) {
				icon.gotoAndStop(7);
				icon.x += icon.scaleX * 3;
			} else if (jumping) {
				if (fallVelocity > 9) {
					fallVelocity = 9;
					if (!thud) { icon.gotoAndStop(5); }
				} else {
					if (!thud) { icon.gotoAndStop(3); }
				}
				icon.y += fallVelocity;
				fallVelocity += 0.25;
			}
			update();
		}
	}
}