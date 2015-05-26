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
	public class Kelp extends PlumbCore {
		private var timer:int;
		private var hitPlayer:Boolean;
		public function Kelp(parent:DisplayObjectContainer, pX:int, pY:int) {
			super(parent, pX, pY);
			icon = new kelp();
			icon.gotoAndStop(Math.ceil(6 * Math.random()));
			icon.x = pX;
			icon.y = pY;
			_parent.addChild(icon);
			timer = -1;
			hitPlayer = false;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var retval:int = 0;
			if (timer < 0) {
				var doom:Boolean = false;
				if (!hitPlayer && icon.hitTestObject(player)) {
					hitPlayer = true;
					retval = 1;
				}
				for each(var i:Harpoon in harpoons) {
					if (icon.hitTestObject(i.iconGet())) {
						doom = true;
						break;
					}
				}
				if (doom) {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.kelp.play();
					}
					timer = 20;
					icon.gotoAndPlay(7);
				}
			} else {
				timer -= 1;
				if (timer == 0) {
					destroy = true;
					hitPlayer = true;
				}
			}
			return retval;
		}
	}
}