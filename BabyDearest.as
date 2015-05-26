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
	public class BabyDearest extends PlumbCore {
		private var health:int;
		private var uteralLining:Array;
		private var rBloods:Array;
		public function BabyDearest(parent:DisplayObjectContainer, pX:int, pY:int, BR:Boolean = false) {
			super(parent, pX, pY);
			if (BR) {
				icon = new babyDearestBR();
			} else {
				icon = new babyDearest();
			}
			icon.x = pX;
			icon.y = pY;
			_parent.addChild(icon);
			health = 40;
			uteralLining = [];
			rBloods = [];
			for (var i:int = 0; i < 16; i++) {
				var u:UteralLining = new UteralLining(parent, pX, pY, i * 23, 1);
				uteralLining.push(u);
			}
			for (var j:int = 0; j < 16; j++) {
				var u2:UteralLining = new UteralLining(parent, pX, pY, j * 23);
				uteralLining.push(u2);
			}
		}
		public override function cleanUp():void {
			for each(var U:UteralLining in uteralLining) {
				U.cleanUp();
			}
			uteralLining = [];
			for each(var B:redBloodCell in rBloods) {
				B.cleanUp();
			}
			rBloods = [];
			_parent.removeChild(icon);
			icon = null;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var willPlayerHurt:int = 0;
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet())) {
					health -= 1;
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.baby[Math.floor(Math.random() * 5)].play();
					}
					i.removeMeFromThisWorld();
					if (icon.currentFrame < 23) {
						icon.gotoAndPlay(22);
					}
					break;
				}
			}
			if (health <= 0) {
				destroy = true;
			}
			for each(var u:UteralLining in uteralLining) {
				willPlayerHurt += u.update(player, harpoons);
				if (u.destroyMe()) {
					var rem:int = uteralLining.indexOf(u);
					uteralLining.splice(rem, 1);
					var aX:int = 12.5 * Math.random();
					for (var bl:int = 0; bl < 16; bl++) {
						var b:redBloodCell = new redBloodCell(_parent, u.loc.x, u.loc.y, aX + bl * 23);
						rBloods.push(b);
					}
					u.cleanUp();
				}
			}
			for each(var bb:redBloodCell in rBloods) {
				willPlayerHurt += bb.update(player, harpoons);
				if (bb.destroyMe()) {
					var ram:int = rBloods.indexOf(bb);
					rBloods.splice(ram, 1);
					bb.cleanUp();
				}
			}
			return willPlayerHurt;
		}
	}
}