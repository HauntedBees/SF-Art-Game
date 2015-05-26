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
	public class NublyBlood {
		private var _parent:DisplayObjectContainer;
		private var icon:MovieClip;
		private var rot:int;
		private var vel:Number;
		public function NublyBlood(bg:DisplayObjectContainer, pX:int, pY:int, ang:int, power:int) {
			_parent = bg;
			icon = new blood();
			icon.gotoAndStop(Math.ceil(Math.random() * 27));
			icon.x = pX;
			icon.y = pY;
			rot = ang - (power * 2) + (power * 4) * Math.random();
			icon.rotation = rot;
			_parent.addChild(icon);
			vel = 4 * power * Math.random();
		}
		public function cleanUp():void {
			_parent.removeChild(icon);
			icon = null;
		}
		public function scrollX(a:Number):void {
			icon.x += a;
		}
		public function scrollY(a:Number):void {
			icon.y += a;
		}
		public function update():void {
			if (vel > 0) {
				icon.x += vel * Math.cos((rot + 90) * Math.PI / 180);
				icon.y += vel * Math.sin((rot + 90) * Math.PI / 180);
				vel *= 0.5;
				if (vel < 0.1) {
					vel = 0;
				}
			}
		}
	}
}