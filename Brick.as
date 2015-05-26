package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
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
	public class Brick extends PlumbCore {
		private var timer:int;
		private var speed:Number;
		public function Brick(parent:DisplayObjectContainer, pX:int, pY:int) {
			super(parent, pX, pY);
			icon = new brick();
			icon.x = pX;
			icon.y = pY;
			speed = 1 + Math.random() * 3;
			icon.gotoAndStop(1);
			timer = 5 + 200 * Math.random();
			_parent.addChild(icon);
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var retval:int = 0;
			var doom:Boolean = false;
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet())) {
					i.removeMeFromThisWorld();
					break;
				}
			}
			icon.rotation = Math.atan2(player.y - icon.y, player.x - icon.x - _parent.x) * 180 / Math.PI;
			if (player.y - icon.y > 5) {
				icon.y += speed;
			} else if (player.y - icon.y < -5) {
				icon.y -= speed;
			}
			if (player.x - (icon.x + _parent.x) > 5) {
				icon.x += speed;
			} else if (player.x - (icon.x + _parent.x) < -5) {
				icon.x -= speed;
			}
			timer -= 1;
			if (timer > 60) {
				if (timer % 30 == 0) {
					icon.gotoAndStop(2);
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.timer.play();
					}
				} else {
					icon.gotoAndStop(1);
				}
			} else if (timer > 30) {
				if (timer % 10 == 0) {
					icon.gotoAndStop(2);
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.timer.play();
					}
				} else {
					icon.gotoAndStop(1);
				}
			} else if (timer > 15) {
				if (timer % 4 == 0) {
					icon.gotoAndStop(2);
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.timer.play();
					}
				} else {
					icon.gotoAndStop(1);
				}
			} else if (timer > 0) {
				if (timer % 2 == 0) {
					icon.gotoAndStop(2);
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.timer.play();
					}
				} else {
					icon.gotoAndStop(1);
				}
			} else {
				if (!SelectionMemory.soundOff) {
					SelectionMemory.sHandler.mine.play();
				}
				doom = true;
				retval = 2;
			}
			destroy = doom;
			return retval;
		}
	}

}