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
	public class Fish extends PlumbCore {
		private var hitPlayer:Boolean;
		private var dir:Number;
		private var deadd:Boolean;
		public function Fish(parent:DisplayObjectContainer, pX:int, pY:int) {
			dir = 4 * Math.random() - 2;
			deadd = false;
			super(parent, pX, pY);
			icon = new fish();
			icon.x = pX;
			icon.y = pY;
			_parent.addChild(icon);
			hitPlayer = false;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var retval:int = 0;
			if (!deadd) {
				var doom:Boolean = false;
				icon.y += dir;
				if (icon.y < 20) {
					icon.y = 20;
					dir *= -1;
				} else if (icon.y > 220) {
					icon.y = 220;
					dir *= -1;
				}
				if (Math.random() > 0.95) {
					dir = 10 * Math.random() - 5;
				}
				if (!hitPlayer && icon.hitTestObject(player)) {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.fish.play();
					}
					hitPlayer = true;
					retval = 1;
				}
				for each(var i:Harpoon in harpoons) {
					if (icon.hitTestObject(i.iconGet())) {
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.fish.play();
						}
						i.removeMeFromThisWorld();
						doom = true;
						hitPlayer = true;
						break;
					}
				}
				if (doom) {
					deadd = true;
					icon.scaleY *= -1;
				}
			} else {
				icon.y -= 2;
			}
			return retval;
		}
	}
}