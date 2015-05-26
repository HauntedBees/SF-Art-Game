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
	public class WorstEnemy extends PlumbCore {
		private var health:int;
		private var moveSet:Array;
		private var timer:int;
		private var harpoonss:Array;
		public function WorstEnemy(parent:DisplayObjectContainer, pX:int, pY:int) {
			super(parent, pX, pY);
			icon = new myownclone();
			icon.x = pX;
			icon.y = pY;
			_parent.addChild(icon);
			health = 20;
			timer = 15;
			moveSet = [];
			harpoonss = [];
		}
		public override function cleanUp():void {
			for each(var U:MirrorValue in moveSet) {
				U.cleanUp();
			}
			moveSet = [];
			for each(var B:MirrorHarpoon in harpoonss) {
				B.cleanUp();
			}
			harpoonss = [];
			_parent.removeChild(icon);
			icon = null;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var willPlayerHurt:int = 0;
			moveSet.push(new MirrorValue(keys, click, angee));
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet())) {
					health -= 1;
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.blood.play();
					}
					i.removeMeFromThisWorld();
				}
			}
			for each(var j:MirrorHarpoon in harpoonss) {
				j.update();
				if (player.hitTestObject(j.iconGet())) {
					willPlayerHurt += 1;
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.blood.play();
					}
					j.removeMeFromThisWorld();
				}
			}
			if (timer <= 0) {
				if (MirrorValue(moveSet[0]).gClick()) {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.harpoon.play();
					}
					harpoonss.push(new MirrorHarpoon(_parent, icon.x - 25 * Math.cos(MirrorValue(moveSet[0]).gAng() * Math.PI / 180), icon.y + 7 * Math.sin(MirrorValue(moveSet[0]).gAng() * Math.PI / 180), MirrorValue(moveSet[0]).gAng()));
				}
				switch(MirrorValue(moveSet[0]).gKey()) {
					case 1:
					case 11:
						icon.y -= 8;
						break;
					case 2:
						icon.x += 4;
						break;
					case 7:
					case 3:
						icon.y -= 8;
						icon.x += 4;
						break;
					case 4:
					case 14:
						icon.y += 8;
						break;
					case 6:
						icon.y += 8;
						icon.x += 4;
						break;
					case 8:
						icon.x -= 4;
						break;
					case 9:
						icon.y -= 8;
						icon.x -= 4;
						break;
					case 12:
						icon.y += 8;
						icon.x -= 4;
						break;
				}
				MirrorValue(moveSet[0]).cleanUp();
				moveSet.splice(0, 1);
			} else {
				if (timer == 15) {
					icon.y = player.y;
				}
				timer -= 1;
			}
			if (health <= 0) {
				icon.gotoAndPlay(12);
				destroy = true;
			}
			return willPlayerHurt;
		}
	}
}