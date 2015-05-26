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
	public class PowerOrb extends PlumbCore {
		private var flipped:Boolean;
		private var initX:int;
		private var countdown:int;
		public function PowerOrb(parent:DisplayObjectContainer, pX:int, pY:int, r:Number) {
			super(parent, pX, pY);
			icon = new halo();
			icon.x = pX;
			icon.y = pY;
			initX = pX;
			countdown = 5;
			flipped = false;
			icon.rotation = r + 180;
			_parent.addChild(icon);
		}
		public function killMe():void {
			destroy = true;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var retval:int = 0;
			if (countdown <= 0) {
				countdown -= 1;
				if (!flipped && countdown <= -10) {
					for each(var i:Harpoon in harpoons) {
						if (icon.hitTestObject(i.iconGet())) {
							icon.rotation = i.getAng() + 180;
							i.removeMeFromThisWorld();
							flipped = true;
							break;
						}
					}
				}
				if (icon.hitTestObject(player)) {
					destroy = true;
					retval = 1;
				}
				if (icon.y < -10 || icon.y > 250 || icon.x > (initX + 100) || icon.x < (initX - 500)) {
					destroy = true;
				}
				icon.x -= 10 * Math.cos(icon.rotation * Math.PI / 180);
				icon.y -= 10 * Math.sin(icon.rotation * Math.PI / 180);
			} else {
				countdown -= 1;
			}
			return retval;
		}
	}
}