package {
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
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
	public class CreditsCop extends CreditsEntity {
		private var HP:int;
		private var speed:Number;
		public var CLICK:Boolean;
		private var dX:int;
		private var dY:int;
		private var vX:int;
		private var vY:int;
		public function CreditsCop(layer:DisplayObjectContainer, collideLayer:DisplayObjectContainer, dx:int, dy:int) {
			super(layer, collideLayer);
			icon = new cop();
			icon.x = dx;
			icon.y = dy;
			jumptimer = 0;
			HP = 10 * Math.random();
			speed = 0.5 + 4.5 * Math.random();
			icon.scaleX = 0.75 + 0.5 * Math.random();
			icon.scaleY = 0.75 + 0.5 * Math.random();
			_parent.addChild(icon);
			vX = 0;
			vY = 0;
		}
		public function processCommands(player:CreditsPlayer, mouseX:int, mouseY:int):int {
			icon.rotation = 0;
			if (!collide.hitTestPoint(icon.x, icon.y + icon.height / 2 + 2, true)) {
				jumping = true;
			}
			icon.x += vX;
			icon.y += vY;
			vX *= 0.9;
			vY *= 0.9;
			if (Math.abs(vX) < 0.1 && Math.abs(vY) <= 0.1) {
				vX = 0;
				vY = 0;
			}
			if (!thud) {
				if (!player.arrested && Math.random() < 0.8) {
					if (player.icon.x > (icon.x + 2)) {
						icon.gotoAndStop(2);
						icon.scaleX = Math.abs(icon.scaleX);
						icon.x += speed;
					} else if (player.icon.x < (icon.x - 2)) {
						icon.gotoAndStop(2);
						icon.scaleX = -Math.abs(icon.scaleX);
						icon.x -= speed;
					} else {
						if (player.icon.y > (icon.y - 10) && player.icon.y < (icon.y + 10)) {
							icon.gotoAndStop(7);
							icon.rotation = -20 + 40 * Math.random();
							player.arrestTimer += 1;
							if (player.appliedForce > (3 * HP * Math.random())) {
								vX = -30 + 60 * Math.random();
								vY = -10 * Math.random();
							}
						}
					}
					if (player.icon.y < (icon.y - 10)) {
						if (!jumping && jumptimer == 0) {
							jumptimer = 12;
						}
						jumping = true;
						if (jumptimer > 0) {
							jumptimer -= 1;
							icon.y -= jumptimer;
							fallVelocity = 0;
						}
					}
					/*if ((player.icon.y > (icon.y + 10)) && !jumping) {
						icon.y += icon.height / 1.5;
						jumping = true;
					}*/
				} else {
					icon.gotoAndStop(1);
				}
			} else {
				if (thudTimer == 10) {
					HP -= 4 + 3 * Math.random();
				}
				icon.gotoAndStop(6);
			}
			if (HP <= 0) {
				thud = true;
				icon.gotoAndStop(6);
				icon.alpha -= 0.1;
				if (icon.alpha <= 0) {
					return 1;
				}
			}
			if (jumping) {
				if (fallVelocity > 9) {
					fallVelocity = 9;
					if (!thud) { icon.gotoAndStop(4); }
				} else {
					if (!thud) { icon.gotoAndStop(3); }
				}
				icon.y += fallVelocity;
				fallVelocity += 0.25;
			}
			if (vX != 0 || vY != 0) {
				var ispin:int = (Math.random() > 0.5)?4:5;
				icon.gotoAndStop(ispin);
				icon.rotation = 360 * Math.random();
				icon.x = mouseX;
				icon.y = mouseY;
			}
			update();
			return 0;
		}
	}
}