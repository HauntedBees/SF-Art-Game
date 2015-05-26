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
	public class CreditsEntity {
		public var icon:MovieClip;
		protected var _parent:DisplayObjectContainer;
		protected var collide:DisplayObjectContainer;
		protected var fallVelocity:Number;
		protected var jumping:Boolean;
		protected var thud:Boolean;
		protected var thudTimer:int;
		protected var jumptimer:int;
		public function CreditsEntity(layer:DisplayObjectContainer, collideLayer:DisplayObjectContainer) {
			_parent = layer;
			collide = collideLayer;
			fallVelocity = 0;
			jumping = false;
			thudTimer = 0;
			thud = false;
		}
		public function cleanUp():void {
			_parent.removeChild(icon);
			icon = null;
		}
		public function update():void {
			collisionsCheck();
		}
		private function collisionsCheck():void {
			if (thudTimer > 0) {
				thudTimer -= 1;
				if (thudTimer == 0) {
					thud = false;
				}
			}
			while (collide.hitTestPoint(icon.x, icon.y + icon.height / 2, true)) {
				icon.y--;
				jumping = false;
				if (fallVelocity >= 8) {
					thud = true;
					thudTimer = 10;
				}
				fallVelocity = 0;
			}
			/*while (collide.hitTestPoint(icon.x, icon.y - icon.height / 2, true)) {
				icon.y++;
			}
			while (collide.hitTestPoint(icon.x - icon.width / 2, icon.y, true)) {
				icon.x++;
			}
			while (collide.hitTestPoint(icon.x + icon.width / 2, icon.y, true)) {
				icon.x--;
			}*/
		}
	}
}