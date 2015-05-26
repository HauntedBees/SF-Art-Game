package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
	public class Fleer {
		private var _parent:DisplayObjectContainer;
		private var _background:DisplayObjectContainer;
		private var icon:MovieClip;
		private var ang:int;
		private var prevrot:int;
		private var dead:Boolean;
		private var health:int;
		private var goreBits:Array;
		public function Fleer(parent:DisplayObjectContainer, bg:DisplayObjectContainer, pX:int, pY:int) {
			goreBits = [];
			health = 5;
			dead = false;
			if (Math.random() > 0.5) {
				icon = new guyRun1();
			} else {
				icon = new guyRun2();
			}
			_parent = parent;
			_background = bg;
			icon.x = pX;
			icon.y = pY;
			ang = -180 + 360 * Math.random();
			icon.rotation = ang;
			_parent.addChild(icon);
			prevrot = 0;
		}
		public function cleanUp():void {
			for each(var g:NublyBlood in goreBits) {
				g.cleanUp();
			}
			goreBits = [];
			_parent.removeChild(icon);
			icon = null;
		}
		public function update(p:Sprite, b:Array, dX:Number, dY:Number, pos:int):uint {
			var particlesOnScreen:int = pos + goreBits.length;
			var cycles:int = 20;
			cycles -= Math.round(particlesOnScreen / 500);
			if (cycles < 4) {
				cycles = 4;
			}
			for each(var gorelol:NublyBlood in goreBits) {
				gorelol.update();
				gorelol.scrollX( -dX);
				gorelol.scrollY( -dY);
			}
			if (!dead) {
				var vec:Vec = checkIfShot(b, cycles);
				var shot:int = vec.power;
				if (shot > 0) {
					shootSomeBloodEverywhere((5 / (health - shot + 1)) * shot, vec.angle);
					health -= shot;
					if (health <= 0) {
						var px:int = icon.x;
						var py:int = icon.y;
						_parent.removeChild(icon);
						icon = new guyDie();
						icon.x = px;
						icon.y = py;
						icon.rotation = ang;
						_parent.addChild(icon);
						dead = true;
						PeopleParser.killCount += 1;
						PeopleParser.Wordle.dialogue.text = PeopleParser.getAStory();
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.death.play();
						}
					} else {
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.hurt.play();
						}
					}
				}
				icon.x += 5 * Math.cos((ang + 90) * Math.PI / 180);
				icon.y += 5 * Math.sin((ang + 90) * Math.PI / 180);
				if (((ang + 90) - Math.atan((p.y - icon.y) / (p.x - icon.x) * 180 / Math.PI)) <= 10) {
					if (Math.random() < 0.5) {
						ang += 20;
					} else {
						ang -= 20;
					}
				} else {
					var rot:int = -10 + 20 * Math.random();
					if (prevrot > 0) { rot += 10 * Math.random(); } else if (prevrot < 0) { rot -= 10 * Math.random(); }				
					if (rot > 0) { prevrot = 1; } else { prevrot = -1; }
					ang += rot;
				}
				icon.rotation = ang;
			}
			return goreBits.length;
		}
		private function shootSomeBloodEverywhere(goreMagnitude:int, angle:int):void {
			var gore:int = 10 * (goreMagnitude / 2 + goreMagnitude * Math.random() + 5 * Math.random());
			if (goreMagnitude > 15) {
				gore *= 2;
			}
			if (gore < 10) {
				gore = 10;
			}
			for (var i:int = 0; i < gore; i++) {
				var chunk:NublyBlood 
				if (Math.random() > 0.75) {
					chunk = new NublyBlood(_background, icon.x, icon.y, angle + 180, goreMagnitude / 8);
				} else {
					chunk = new NublyBlood(_background, icon.x, icon.y, angle, goreMagnitude);
				}
				goreBits.push(chunk);
			}
		}
		private function checkIfShot(b:Array, cycles:int):Vec {
			for each(var v:Vec in b) {
				if (v.position.x - icon.x < 25 && v.position.y - icon.y < 25) {
					var shot:Boolean = didIJustGetShotInTheFace(v, cycles, new Rectangle(icon.x - 5, icon.y - 5, 10, 10));
					if (shot) {
						return v;
					}
				}
			}
			return new Vec(new Point(0, 0), 0, 0);
		}
		private function didIJustGetShotInTheFace(v:Vec, cycles:int, boundingBox:Rectangle):Boolean {
			var hitPoint:Point = new Point(v.position.x, v.position.y);
			for (var i:int = 0; i < cycles; i++) {
				hitPoint.x -= 20 / cycles * Math.cos((v.angle + 90) * Math.PI / 180);
				hitPoint.y -= 20 / cycles * Math.sin((v.angle + 90) * Math.PI / 180);
				if (boundingBox.containsPoint(hitPoint)) {
					return true;
				}
			}
			return false;
		}
		public function scrollX(a:Number):void {
			icon.x += a;
		}
		public function scrollY(a:Number):void {
			icon.y += a;
		}
	}
}