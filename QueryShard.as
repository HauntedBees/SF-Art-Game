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
	public class QueryShard extends PlumbCore {
		private var ang:int = 0;
		public function QueryShard(parent:DisplayObjectContainer, pX:int, pY:int, anng:int, f:int) {
			super(parent, pX, pY);
			icon = new queryShard();
			icon.x = pX;
			icon.y = pY;
			icon.gotoAndStop(f);
			ang = anng;
			_parent.addChild(icon);
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			icon.x += 5 * Math.cos((ang + 90) * Math.PI / 180);
			icon.y += 5 * Math.sin((ang + 90) * Math.PI / 180);
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
					break;
				}
			}
			return 0;
		}
	}
}