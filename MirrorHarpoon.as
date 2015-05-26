package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
	public class MirrorHarpoon {
		private var _parent:DisplayObjectContainer;
		private var icon:MovieClip;
		private var ang:int;
		private var destroy:Boolean;
		private var snapped:Boolean;
		public function MirrorHarpoon(parent:DisplayObjectContainer, pX:int, pY:int, angle:int) {
			destroy = false;
			_parent = parent;
			icon = new mirrorharpoon();
			snapped = false;
			icon.x = pX;
			icon.y = pY;
			ang = angle;
			icon.rotation = ang;
			_parent.addChild(icon);
		}
		public function getAng():Number {
			return ang;
		}
		public function snappedeedoo():Boolean {
			return snapped;
		}
		public function ohSnapOhSnapComeToOurMacaroniPartyAndTakeANap():void {
			if (!snapped) {
				icon.play();
				snapped = true;
			}
		}
		public function iconGet():Sprite {
			return icon;
		}
		public function cleanUp():void {
			_parent.removeChild(icon);
			icon = null;
		}
		public function removeMeFromThisWorld():void {
			destroy = true;
		}
		public function destroyMe():Boolean {
			return destroy;
		}
		public function update():void {
			if(!snapped) {
				icon.x -= 10 * Math.cos(ang * Math.PI / 180);
				icon.y -= 10 * Math.sin(ang * Math.PI / 180);
				if (icon.x > (600 - _parent.x)) {
					destroy = true;
				}
			} else {
				icon.y += 3;
				icon.rotation += 3;
				if (icon.y > 240) {
					destroy = true;
				}
			}
		}
	}
}