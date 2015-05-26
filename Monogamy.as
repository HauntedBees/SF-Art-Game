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
	public class Monogamy extends PlumbCore {
		private var health:int;
		private var bricks:Array;
		public var explosions:Array;
		private var scars:Array;
		public function Monogamy(parent:DisplayObjectContainer, pX:int, pY:int, BR:Boolean = false) {
			super(parent, pX, pY);
			if (BR) {
				icon = new brickwallBR();
			} else {
				icon = new brickwall();
			}
			icon.x = pX;
			icon.y = pY;
			bricks = [];
			explosions = [];
			scars = [];
			_parent.addChild(icon);
			health = 80;
		}
		public override function cleanUp():void {
			for each(var U:Brick in bricks) {
				U.cleanUp();
			}
			for each(var E:Explosion in explosions) {
				E.cleanUp();
			}
			for each(var S:MovieClip in scars) {
				_parent.removeChild(S);
			}
			bricks = [];
			explosions = [];
			scars = [];
			_parent.removeChild(icon);
			icon = null;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var willPlayerHurt:int = 0;
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet())) {
					health -= 1;
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.pistol.play();
					}
					var brick:Brick = new Brick(_parent, i.iconGet().x, i.iconGet().y);
					var wc:MovieClip = new wcrack();
					wc.gotoAndStop(Math.ceil(Math.random() * 5));
					wc.x = i.iconGet().x + 10 + 30 * Math.random();
					wc.y = i.iconGet().y;
					_parent.addChild(wc);
					scars.push(wc);
					bricks.push(brick);
					i.removeMeFromThisWorld();
					break;
				}
			}
			if (health <= 0) {
				destroy = true;
			}
			for each(var bb:Brick in bricks) {
				var damparse:int = bb.update(player, harpoons);
				willPlayerHurt += (damparse & 1);
				if (damparse & 2) {
					var e:Explosion = new Explosion(_parent, bb.getPos().x, bb.getPos().y, true);
					explosions.push(e);
				}
				if (bb.destroyMe()) {
					var rom:int = bricks.indexOf(bb);
					bricks.splice(rom, 1);
					bb.cleanUp();
				}
			}
			return willPlayerHurt;
		}
	}
}