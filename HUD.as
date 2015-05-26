package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
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
	public class HUD {
		private var sCore:Sprite;
		private var selection:Sprite;
		private var gun:int;
		private var key1:MovieClip;
		private var key2:MovieClip;
		private var key3:MovieClip;
		private var key4:MovieClip;
		private var key5:MovieClip;
		private var am1:MovieClip;
		private var am2:MovieClip;
		private var aM1:MovieClip;
		private var aM2:MovieClip;
		private var ammo:int;
		private var ammomax:int;
		private var _parent:DisplayObjectContainer;
		private var reloading:Boolean;
		private var firing:Boolean;
		private var switches:Boolean;
		public function HUD(parent:DisplayObjectContainer, toggle:Boolean) {
			switches = toggle;
			gun = 1;
			ammo = 6;
			ammomax = 6;
			reloading = false;
			firing = false;
			_parent = parent;
			sCore = new gunHUD();
			sCore.x = 240;
			sCore.y = 226.5;
			_parent.addChild(sCore);
			selection = new hSelect();
			selection.x = 29;
			selection.y = 227.5;
			_parent.addChild(selection);
			key1 = new gunKeys();
			key1.gotoAndStop(1);
			key1.x = 8.5;
			key1.y = 232.5;
			_parent.addChild(key1);
			key2 = new gunKeys();
			key2.gotoAndStop(2);
			key2.x = 63.5;
			key2.y = 232.5;
			_parent.addChild(key2);
			key3 = new gunKeys();
			key3.gotoAndStop(3);
			key3.x = 120.5;
			key3.y = 232.5;
			_parent.addChild(key3);
			key4 = new gunKeys();
			key4.gotoAndStop(16);
			key4.x = 174.5;
			key4.y = 232.5;
			_parent.addChild(key4);
			key5 = new gunKeys();
			key5.gotoAndStop(10);
			key5.x = 454.5;
			key5.y = 232.5;
			_parent.addChild(key5);
			am1 = new ammoNum();
			am1.gotoAndStop(11);
			am1.scaleX = 1.5;
			am1.scaleY = am1.scaleX;
			am1.x = 260;
			am1.y = 222;
			_parent.addChild(am1);
			am2 = new ammoNum();
			am2.gotoAndStop(6);
			am2.scaleX = am1.scaleX;
			am2.scaleY = am1.scaleX;
			am2.x = 265;
			am2.y = 222;
			_parent.addChild(am2);
			aM1 = new ammoNum();
			aM1.gotoAndStop(11);
			aM1.scaleX = am1.scaleX;
			aM1.scaleY = am1.scaleX;
			aM1.x = 270;
			aM1.y = 232;
			_parent.addChild(aM1);
			aM2 = new ammoNum();
			aM2.gotoAndStop(6);
			aM2.scaleX = am1.scaleX;
			aM2.scaleY = am1.scaleX;
			aM2.x = 275;
			aM2.y = 232;
			_parent.addChild(aM2);
		}
		public function cleanUp():void {
			_parent.removeChild(key1);
			_parent.removeChild(key2);
			_parent.removeChild(key3);
			_parent.removeChild(key4);
			_parent.removeChild(key5);
			_parent.removeChild(am1);
			_parent.removeChild(am2);
			_parent.removeChild(aM1);
			_parent.removeChild(aM2);
			_parent.removeChild(sCore);
			_parent.removeChild(selection);
			key1 = null;
			key2 = null;
			key3 = null;
			key4 = null;
			key5 = null;
			am1 = null;
			am2 = null;
			aM1 = null;
			aM2 = null;
			sCore = null;
			selection = null;
		}
		public function matches(x:uint):uint {
			reloading = false;
			var i:uint = 0;
			if ((getKeyFromFrame(key1.currentFrame) & x)== getKeyFromFrame(key1.currentFrame)) {
				i = 1;
				if (!switches) {
					shuffleBitches();
				}
				moveSelect(1);
			} else if ((getKeyFromFrame(key2.currentFrame) & x)== getKeyFromFrame(key2.currentFrame)) {
				i = 2;
				if (!switches) {
					shuffleBitches();
				}
				moveSelect(4);
			} else if ((getKeyFromFrame(key3.currentFrame) & x)== getKeyFromFrame(key3.currentFrame)) {
				i = 3;
				if (!switches) {
					shuffleBitches();
				}
				moveSelect(7);
			}
			if ((getKeyFromFrame(key5.currentFrame) & x) == getKeyFromFrame(key5.currentFrame)) {
				i += 4;
				if (gun == 3) { i = 40; }
				if (ammo == 0) {
					if (!switches) {
						shuffleBitches();
					}
					reload();
				} else {
					ammo--;
					if (gun == 1) { ammo--; }
					firing = true;
				}
				ammoUpdate();
			}
			return i;
		}
		public function resetFire():void {
			firing = false;
		}
		public function firingCheck():Boolean {
			return firing;
		}
		public function reloadingCheck():Boolean {
			return reloading;
		}
		private function reload():void {
			ammo = ammomax;
			reloading = true;
		}
		private function shuffleBitches():void {
			var i:int = Math.ceil(Math.random() * 15);
			var j:int = 0;
			var k:int = 0;
			var l:int = 0;
			while (j == i || j == 0) {
				j = Math.ceil(Math.random() * 15);
			}
			while (k == j || k == i || k == 0) {
				k = Math.ceil(Math.random() * 15);
			}
			
			while (l == k || l == j || l == i || l == 0) {
				l = Math.ceil(Math.random() * 15);
			}
			key1.gotoAndStop(i);
			key2.gotoAndStop(j);
			key3.gotoAndStop(k);
			key5.gotoAndStop(l);
		}
		private function ammoUpdate():void {
			if (ammo < 10) {
				am1.gotoAndStop(11);
				if (ammo % 10 == 0) {
					am2.gotoAndStop(10);
				} else {
					am2.gotoAndStop(ammo % 10);
				}
			} else {
				am1.gotoAndStop(Math.floor(ammo / 10));
				if (ammo % 10 == 0) {
					am2.gotoAndStop(10);
				} else {
					am2.gotoAndStop(ammo % 10);
				}
			}
			if (ammomax < 10) {
				aM1.gotoAndStop(11);
				aM2.gotoAndStop(ammomax);
			} else {
				aM1.gotoAndStop(Math.floor(ammomax / 10));
				if (ammomax % 10 == 0) {
					aM2.gotoAndStop(10);
				} else {
					aM2.gotoAndStop(ammomax % 10);
				}
			}
		}
		public function moveSelect(x:int):void {
			var i:int = 0;
			switch(x) {
				case 1:
					i = 29;
					gun = 1;
					ammo = 12;
					ammomax = 12;
					break;
				case 4:
					i = 85;
					gun = 2;
					ammo = 2;
					ammomax = 2;
					break;
				case 7:
					i = 141;
					gun = 3;
					ammo = 99;
					ammomax = 99;
					break;
			}
			ammoUpdate();
			selection.x = i;
		}
		private function getKeyFromFrame(fr:uint):uint {
			var i:uint = 0;
			switch(fr) {
				case 3:
					i = 4;
					break;
				case 2:
					i = 2;
					break;
				case 1:
					i = 1;
					break;
				case 4:
					i = 8;
					break;
				case 5:
					i = 16;
					break;
				case 6:
					i = 32;
					break;
				case 7:
					i = 64;
					break;
				case 8:
					i = 128;
					break;
				case 9:
					i = 256;
					break;
				case 10:
					i = 512;
					break;
				case 11:
					i = 1024;
					break;
				case 12:
					i = 2048;
					break;
				case 13:
					i = 8192;
					break;
				case 14:
					i = 16384;
					break;
				case 15:
					i = 4096;
					break;
			}
			return i;
		}
	}
}