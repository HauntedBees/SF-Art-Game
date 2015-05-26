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
	public class Splurlee extends PlumbCore {
		private var itsAFunctionOfT:Number;
		private var initY:int;
		private var timer:int;
		private var delta:Number;
		private var radius:Number;
		public function Splurlee(parent:DisplayObjectContainer, pX:int, pY:int, dT:Number = Math.PI / 12, r:Number = 80) {
			super(parent, pX, pY);
			if (!SelectionMemory.soundOff) {
				SelectionMemory.sHandler.dark.play();
			}
			icon = new splurlees();
			icon.x = pX;
			icon.y = pY;
			icon.gotoAndPlay(Math.ceil(Math.random() * 40));
			initY = pY;
			itsAFunctionOfT = 0;
			timer = 200;
			radius = r;
			delta = dT;
			_parent.addChild(icon);
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			icon.x -= 12;
			icon.y = initY + radius * Math.sin(itsAFunctionOfT);
			itsAFunctionOfT += delta;
			if (icon.hitTestObject(player)) {
				destroy = true;
				return 1;
			}
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet())) {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.blood.play();
					}
					destroy = true;
					i.removeMeFromThisWorld();
					break;
				}
			}
			timer--;
			if (timer <= 0) {
				destroy = true;
			}
			return 0;
		}
	}
}