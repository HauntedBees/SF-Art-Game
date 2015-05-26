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
	public class Deceptus extends PlumbCore {
		private var health:int;
		private var powerOrbs:Array;
		private var dir:int;
		private var speed:Number;
		private var hit:int;
		public function Deceptus(parent:DisplayObjectContainer, pX:int, pY:int, BR:Boolean = false) {
			super(parent, pX, pY);
			if (BR) {
				icon = new angelBR();
			} else {
				icon = new angel();
			}
			icon.x = pX;
			icon.y = pY;
			speed = 2;
			dir = 1;
			hit = 0;
			_parent.addChild(icon);
			powerOrbs = [];
			health = 35;
		}
		public override function cleanUp():void {
			for each(var U:PowerOrb in powerOrbs) {
				U.cleanUp();
			}
			powerOrbs = [];
			_parent.removeChild(icon);
			icon = null;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var willPlayerHurt:int = 0;
			for each(var i:Harpoon in harpoons) {
				if (icon.hitTestObject(i.iconGet()) && !i.snappedeedoo()) {
					if (hit == 0) {
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.uterus.play();
						}
						i.ohSnapOhSnapComeToOurMacaroniPartyAndTakeANap();
					} else {
						icon.play();
						health -= 1;
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.tommygun.play();
						}
						i.removeMeFromThisWorld();
					}
				}
			}
			if (hit == 0) {
				for each(var bb:PowerOrb in powerOrbs) {
					willPlayerHurt += bb.update(player, harpoons);
					if (icon.hitTestObject(bb.getSprite())) {
						health -= 1;
						dir = 0;
						hit = 1;
						icon.gotoAndPlay(21);
						bb.killMe();
						SelectionMemory.sHandler.queries.stop();
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.anHurt[Math.floor(Math.random() * 5)].play();
						}
					}
					if (bb.destroyMe()) {
						var rom:int = powerOrbs.indexOf(bb);
						powerOrbs.splice(rom, 1);
						bb.cleanUp();
					}
				}
			}
			if (Math.random() > 0.98 && powerOrbs.length == 0 && hit == 0) {
				var B:int = Math.floor(Math.random() * 7);
				if (!SelectionMemory.soundOff) {
					SelectionMemory.sHandler.queries = SelectionMemory.sHandler.angel[B].play();
				}
				var pPp:Point = _parent.globalToLocal(new Point(player.x, player.y));
				var X:Number = Math.atan2(pPp.y - icon.y, pPp.x - icon.x + 30) * 180 / Math.PI;
				icon.gotoAndPlay(14);
				powerOrbs.push(new PowerOrb(_parent, icon.x - 30, icon.y, X));
				dir *= 5;
			}
			if (dir == 1) {
				icon.y += speed;
				if (icon.y > 240) {
					icon.y = 240;
					dir = -1;
				}
			} else if (dir == -1) {
				icon.y -= speed;
				if (icon.y < 0) {
					icon.y = 0;
					dir = 1;
				}
			} else if (dir > 1) {
				dir -= 1;
			} else if (dir < -1) {
				dir += 1;
			} else if (dir == 0) {
				if (hit == 1) {
					icon.y += 5;
					if (icon.y > 215) {
						icon.y = 215;
						hit = 2;
						icon.gotoAndStop(28);
					}
				} else if (hit >= 2) {
					hit += 1;
					if (hit > (300 / speed)) {
						dir = -1;
						speed += 0.25;
						icon.gotoAndPlay(1);
						hit = 0;
					}
				}
			}
			if (health <= 0) {
				destroy = true;
			}
			return willPlayerHurt;
		}
	}
}