package {
	import flash.display.DisplayObjectContainer;
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
	public class Clip
	{
		private var _parent:DisplayObjectContainer;
		private var icon:Sprite;
		private var power:int;
		private var ang:int;
		private var z:int;
		private var vel:Number;
		private var zVel:int;
		public function Clip(parent:DisplayObjectContainer, itype:int, pX:int, pY:int, angle:int) {
			_parent = parent;
			z = 150;
			vel = 5 * Math.random();
			zVel = -10;
			switch(itype) {
				case 1:
					icon = new clipPistol();
					power = 2;
					break;
				case 4:
					icon = new clipShotgun();
					power = 4;
					break;
				case 7:
					icon = new clipTommygun();
					power = 1;
					break;
				default:
					icon = new bulletPistol();
					power = 2;
					break;
			}
			icon.x = pX;
			icon.y = pY;
			icon.rotation = angle;
			_parent.addChild(icon);
			ang = angle;
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
			icon.x += vel * Math.cos(ang * Math.PI / 180) - vel / 2 + vel * Math.random();
			icon.y += vel * Math.sin(ang * Math.PI / 180) - vel / 2 + vel * Math.random();
			icon.rotation += -vel + (vel * 2) * Math.random();
			z += zVel;
			icon.scaleX = z / 100;
			icon.scaleY = z / 100;
			if (z < 90 && zVel == -10) {
				zVel = 5;
				vel /= 2;
			} else if (z > 100 && zVel == 5) {
				zVel = -2;
				vel /= 2;
			} else if (zVel < 90 && zVel == -2) {
				zVel = 0;
				vel = 0;
			}
		}
	}

}