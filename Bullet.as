package {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Vector3D;
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
	public class Bullet
	{
		private var _parent:DisplayObjectContainer;
		private var icon:Sprite;
		private var power:int;
		private var ang:int;
		private var destroy:Boolean;
		public function Bullet(parent:DisplayObjectContainer, itype:int, pX:int, pY:int, angle:int) {
			destroy = false;
			_parent = parent;
			switch(itype) {
				case 1:
					icon = new bulletPistol();
					power = 2;
					break;
				case 4:
					icon = new bulletShotgun();
					power = 5;
					break;
				case 7:
					icon = new bulletTommygun();
					power = 1;
					break;
				default:
					icon = new bulletPistol();
					power = 3;
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
		public function angPos():Vec {
			return new Vec(new Point(icon.x, icon.y), ang, power);
		}
		public function scrollX(a:Number):void {
			icon.x += a;
		}
		public function scrollY(a:Number):void {
			icon.y += a;
		}
		public function destroyMe():Boolean {
			return destroy;
		}
		public function destroyThis():void {
			_parent.removeChild(icon);
			icon = null;
			power = 0;
			ang = 0;
		}
		public function update(p:Sprite):void {
			icon.x += 20 * Math.cos((ang + 90) * Math.PI / 180);
			icon.y += 20 * Math.sin((ang + 90) * Math.PI / 180);
			if (Math.abs(icon.x - p.x) > 400 || Math.abs(icon.y - p.y) > 200) {
				destroy = true;
			}
		}
	}

}