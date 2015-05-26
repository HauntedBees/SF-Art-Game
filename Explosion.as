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
	public class Explosion extends PlumbCore {
		private var timer:int;
		public var canHurt:Boolean;
		public function Explosion(parent:DisplayObjectContainer, pX:int, pY:int, tiny:Boolean = false) {
			canHurt = true;
			super(parent, pX, pY);
			icon = new explosion();
			icon.rotation = -180 + 360 * Math.random();
			icon.x = pX;
			icon.y = pY;
			if (tiny) {
				icon.scaleX = 0.55;
				icon.scaleY = icon.scaleX;
			}
			_parent.addChild(icon);
			timer = 0;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			timer += 1;
			if (timer >= 28 && timer < 56) {
				canHurt = false;
			} else if (timer >= 56) {
				destroy = true;
			}
			return timer;
		}
	}
}