package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
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
	public class SpriteCore {
		protected var icon:MovieClip;
		protected var _parent:DisplayObjectContainer;
		protected var destroy:Boolean;
		public function SpriteCore(parent:DisplayObjectContainer, pX:int, pY:int) {
			destroy = false;
			_parent = parent;
		}
		public function cleanUp():void {
			_parent.removeChild(icon);
			icon = null;
		}
		public function destroyMe():Boolean {
			return destroy;
		}
		public function getPos():Point {
			return new Point(icon.x, icon.y);
		}
		public function getSprite():MovieClip {
			return icon;
		}
	}
}