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
	public class Chairs extends PlumbCore {
		private var health:int;
		private var wave:Array;
		private var laser:Array;
		private var attackState:int;
		private var attackDelay:int;
		private var radius:int;
		private var time:Number;
		private var initX:int;
		private var initY:int;
		private var pattern:int;
		private var dir:int;
		private var dT:Number;
		private var bSet:Number;
		private var bRadius:Number;
		public function Chairs(parent:DisplayObjectContainer, pX:int, pY:int, BR:Boolean = false) {
			super(parent, pX, pY);
			if (BR) {
				icon = new chairsBR();
			} else {
				icon = new chairs();
			}
			icon.x = pX;
			icon.y = pY;
			icon.scaleX = 2;
			icon.scaleY = icon.scaleX;
			_parent.addChild(icon);
			health = 30;
			attackState = 0;
			attackDelay = 90;
			radius = 60;
			time = 180;
			laser = [];
			wave = [];
			initX = pX;
			initY = pY;
			pattern = 1;
			dir = 1;
			dT = 0.2;
		}
		public override function cleanUp():void {
			for each(var U:Splurlee in wave) {
				U.cleanUp();
			}
			wave = [];
			_parent.removeChild(icon);
			icon = null;
		}
		public override function update(player:MovieClip = null, harpoons:Array = null, keys:uint = 0, click:Boolean = false, angee:Number = 0):int {
			var willPlayerHurt:int = 0;
			switch(pattern) {
				case 1:
					icon.x = initX + radius * Math.cos(time);
					icon.y = initY + 2 * radius * Math.sin(time);
					break;
				case 2:
					icon.x = initX + (radius * (Math.SQRT2 * Math.cos(time) * Math.sin(time)) / (Math.sin(time) * Math.sin(time) + 1));
					icon.y = initY + (radius * (Math.SQRT2 * Math.cos(time)) / (Math.sin(time) * Math.sin(time) + 1));
					break;
				case 3:
					icon.x = initX + radius * Math.sin(2 * time) / 2;
					icon.y = initY + radius * Math.cos(time);
					break;
			}
			if (Math.random() > 0.8  && (Math.abs(icon.y - initY - radius) < 5 || Math.abs(icon.y - initY + radius) < 5)) {
				pattern = Math.ceil(Math.random() * 3);
			}
			time += dir * dT;
			if (icon.currentFrame < 11 || icon.currentFrame > 28) {
				for each(var i:Harpoon in harpoons) {
					if (icon.hitTestObject(i.iconGet())) {
						health -= 1;
						SelectionMemory.sHandler.queries.stop();
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.aHurt[Math.floor(Math.random() * 4)].play();
						}
						var splurlee:Splurlee = new Splurlee(_parent, icon.x, icon.y, (Math.PI / 4 * Math.random()), (40 + Math.random() * 60));
						wave.push(splurlee);
						if (health < 30) {
							var splurlef:Splurlee = new Splurlee(_parent, icon.x, icon.y, (Math.PI / 4 * Math.random()), (40 + Math.random() * 60));
							wave.push(splurlef);
						}
						icon.scaleX *= 0.95;
						if (icon.scaleX < 0.65) {
							icon.scaleX = 0.65;
						}
						icon.scaleY = icon.scaleX;
						i.removeMeFromThisWorld();
						if (icon.currentFrame < 13) {
							icon.gotoAndPlay(11);
						}
						if (attackState == 0) {
							dir *= -1;
							radius = 30 + 60 * Math.random();
						}
						break;
					}
				}	
			}
			if (health <= 0) {
				destroy = true;
			}
			attackDelay -= 1;
			if (attackDelay <= 0 && attackState == 0 && Math.random() > 0.96) {
				attackState = 1;
			} else if (attackState == 1) {
				if (attackDelay <= 0) {
					dT -= 0.02;
					attackDelay = 10;
				}
				if (dT <= 0) {
					dT = 0;
					attackState = 2;
					attackDelay = 5 + 40 * Math.random();
				}
			} else if (attackState == 2) {
				attackDelay -= 1;
				if (attackDelay <= 0) {
					attackDelay = 30 + 200 * Math.random();
					attackState = 3;
					bSet = Math.PI / 4 * Math.random();
					bRadius = 40 + Math.random() * 60;
					var B:int = Math.floor(Math.random() * 8);
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.queries = SelectionMemory.sHandler.anger[B].play();
					}
				}
			} else if (attackState == 3) {
				attackDelay -= 1;
				if ((attackDelay % 2) == 0) {
					wave.push(new Splurlee(_parent, icon.x, icon.y, bSet, bRadius));
					if (health <= 20) {
						wave.push(new Splurlee(_parent, icon.x, icon.y, bSet, -bRadius));
					}
				}
				if (attackDelay <= 0) {
					attackState = 4;
				}
			} else if (attackState == 4) {
				if (attackDelay <= 0) {
					dT += 0.02;
					attackDelay = 10;
				}
				if (dT >= 0.2) {
					dT = 0.2;
					attackState = 0;
					attackDelay = 45 + 90 * Math.random();
				}
			}
			for each(var bb:Splurlee in wave) {
				willPlayerHurt += bb.update(player, harpoons);
				if (bb.destroyMe()) {
					var ram:int = wave.indexOf(bb);
					wave.splice(ram, 1);
					bb.cleanUp();
				}
			}
			return willPlayerHurt;
		}
	}
}