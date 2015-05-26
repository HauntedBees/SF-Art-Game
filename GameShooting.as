package {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
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
	public class GameShooting {
		private var _hLayer:DisplayObjectContainer;
		private var _pLayer:DisplayObjectContainer;
		private var _bLayer:DisplayObjectContainer;
		private var player:MovieClip;
		private var moving:Boolean;
		private var currentGun:int;
		private var gHud:HUD;
		private var rotFactor:int = 15;
		private var movFactor:int  = 8;
		private var SHIFT:Boolean;
		private var bullets:Array;
		private var clips:Array;
		private var bodies:Array;
		private var map:Sprite;
		private var playedR:Boolean;
		private var scrollBox:Rectangle;
		private var tarjei:FleeTarget;
		private var tracker:Sprite;
		private var victoryScreen:MovieClip;
		private var winstate:int;
		public function GameShooting(playerL:DisplayObjectContainer, bg:DisplayObjectContainer, hud:DisplayObjectContainer, mobAmount:int, mapSel:int, toggle:Boolean = false) {
			winstate = 0;
			scrollBox = new Rectangle(125, 65, 230, 80);
			_pLayer = playerL;
			_bLayer = bg;
			_hLayer = hud;
			moving = false;
			playedR = false;
			currentGun = 1;
			switch(mapSel) {
				case 1:
					map = new sMap1();
					break;
				case 2:
					map = new sMap2();
					break;
				case 3:
					map = new sMap3();
					break;
				case 4:
					map = new sMap4();
					break;
				case 5:
					map = new sMap5();
					break;
				case 6:
					map = new sMap6();
					break;
				case 7:
					map = new sMap7();
					break;
				case 8:
					map = new sMap8();
					break;
				default:
					map = new sMap1();
					break;
			}
			_bLayer.addChild(map);
			bodies = [];
			for (var i = 0; i < mobAmount; i++) {
				var victim:Fleer = new Fleer(_pLayer, _bLayer, -500 + 1000 * Math.random(), -500 + 1000 * Math.random());
				bodies.push(victim);
			}
			tarjei = new FleeTarget(_pLayer, _bLayer, -500 + 1000 * Math.random(), -500 + 1000 * Math.random());
			player = new pShoot();
			player.x = 240;
			player.y = 120;
			player.gotoAndStop(currentGun);
			_hLayer.addChild(player);
			tracker = new tTracker();
			tracker.x = player.x;
			tracker.y = player.y;
			_hLayer.addChild(tracker);
			gHud = new HUD(_hLayer, toggle);
			bullets = [];
			clips = [];
			PeopleParser.Wordle = new words();
			PeopleParser.Wordle.x = PeopleParser.Wordle.width / 2;
			PeopleParser.Wordle.y = 200;
			PeopleParser.Wordle.dialogue.text = "";
			_hLayer.addChild(PeopleParser.Wordle);
		}
		public function cleanUp():void {
			for each(var p:Fleer in bodies) {
				p.cleanUp();
			}
			bodies = [];
			for each(var c:Clip in clips) {
				c.cleanUp();
			}
			clips = [];
			for each(var b:Bullet in bullets) {
				b.cleanUp();
			}
			tarjei.cleanUp();
			tarjei = null;
			bullets = [];
			_hLayer.removeChild(tracker);
			tracker = null;
			_hLayer.removeChild(PeopleParser.Wordle);
			PeopleParser.Wordle = null;
			_hLayer.removeChild(player);
			player = null;
			_bLayer.removeChild(map);
			map = null;
			scrollBox.setEmpty();
			scrollBox = null;
			gHud.cleanUp();
			gHud = null;
			_hLayer.removeChild(victoryScreen);
			victoryScreen = null;
		}
		/**
		 * @return output: 1 = don't reset keys (machine gun), 2 = game complete
		 */
		public function update(keys:uint, altkeys:uint, shift:Boolean):uint {
			var process:Boolean = true;
			if (winstate != 0) {
				winstate += 1;
				if (winstate < 100 && winstate > 0) {
					if (winstate % 8 != 0) { process = false; }
				} else if(winstate >= 100) {
					process = false;
					victoryScreen = new mComplete();
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.KO.play();
					}
					victoryScreen.x += victoryScreen.width / 2;
					victoryScreen.y += victoryScreen.height / 4 - 10;
					_hLayer.addChild(victoryScreen);
					winstate = -1;
				} else {
					process = false;
					winstate += -2;
					if (winstate <= -90) {
						return 2;
					}
				}
			}
			if(process) {
				SHIFT = shift;
				var output:uint = 0;
				var moved:Boolean = true;
				var forceUpdate:Boolean = false;
				if (altkeys > 0) {
					var results:uint = gHud.matches(altkeys);
					if ((results & 3) == 3) {
						currentGun = 7;
						gHud.moveSelect(7);
					} else if ((results & 2) == 2) {
						currentGun = 4;
						gHud.moveSelect(4);
					} else if ((results & 1) == 1) {
						currentGun = 1;
						gHud.moveSelect(1);
					}
					forceUpdate = true;
				}
				switch(keys) {
					case 1:
					case 11:
						player.y -= movFactor;
						shiftRot(180);
						break;
					case 2:
						player.x -= movFactor;
						shiftRot(90);
						break;
					case 7:
					case 3:
						player.y -= movFactor / Math.sqrt(2);
						player.x -= movFactor / Math.sqrt(2);
						shiftRot(135);
						break;
					case 4:
					case 14:
						player.y += movFactor;
						shiftRot(0);
						break;
					case 6:
						player.y += movFactor / Math.sqrt(2);
						player.x -= movFactor / Math.sqrt(2);
						shiftRot(45);
						break;
					case 8:
						player.x += movFactor;
						shiftRot(-90);
						break;
					case 9:
						player.y -= movFactor / Math.sqrt(2);
						player.x += movFactor / Math.sqrt(2);
						shiftRot(-135);
						break;
					case 12:
						player.y += movFactor / Math.sqrt(2);
						player.x += movFactor / Math.sqrt(2);
						shiftRot(-45);
						break;
					case 0:
					case 5:
					case 10:
					case 15:
						moved = false;
						break;
				}
				if (gHud.reloadingCheck()) {
					player.gotoAndStop(currentGun + 2);
					if (!playedR) {
						playedR = true;
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.reload.play();
						}
					}
				} else if ((moved && !moving) || (moved && forceUpdate)) {
					player.gotoAndStop(currentGun + 1);
					playedR = false;
				} else if ((!moved && moving) || (!moved && forceUpdate)) {
					player.gotoAndStop(currentGun);
					playedR = false;
				}
				moving = moved;
				var b:Bullet;
				var c:Clip;
				var f:Fleer;
				if (gHud.firingCheck()) {
					if (currentGun == 7) { output = 1; }
					fire();
				}
				var dX:Number = 0;
				var dY:Number = 0;
				if (player.x <= scrollBox.left) {
					if (map.x < 720) {
						dX = player.x - scrollBox.left;
						player.x -= dX;
						map.x -= dX;
					} else {
						if (player.x < 10) {
							player.x = 10;
						}
					}
				} else if (player.x >= scrollBox.right) {
					if(map.x > -465) {
						dX = player.x - scrollBox.right;
						player.x -= dX;
						map.x -= dX;
					} else {
						if (player.x > 470) {
							player.x = 470;
						}
					}
				}
				if (player.y <= scrollBox.top) {
					if(map.y < 700) {
						dY = player.y - scrollBox.top;
						player.y -= dY;
						map.y -= dY;
					} else {
						if (player.y < 10) {
							player.y = 10;
						}
					}
				} else if (player.y >= scrollBox.bottom) {
					if(map.y > -615) {
						dY = player.y - scrollBox.bottom;
						player.y -= dY;
						map.y -= dY;
					} else {
						if (player.y > 200) {
							player.y = 200;
						}
					}
				}
				var bMov:Array = [];
				for each(b in bullets) {
					b.update(player);
					if (b.destroyMe()) {
						var rm:int = bullets.indexOf(b);
						bullets.splice(rm, 1);
						b.destroyThis();
					} else {
						bMov.push(b.angPos());
						b.scrollX( -dX);
						b.scrollY( -dY);
					}
				}
				for each(c in clips) {
					c.update();
					c.scrollX( -dX);
					c.scrollY( -dY);
				}
				var particlesOnScreen:uint = clips.length + bullets.length + bodies.length;
				for each(f in bodies) {
					particlesOnScreen += f.update(player, bMov, dX, dY, particlesOnScreen);
					f.scrollX( -dX);
					f.scrollY( -dY);
				}
				tarjei.update(player, bMov, dX, dY, particlesOnScreen, map.width / 2, map.height / 2, map.x, map.y);
				tarjei.scrollX( -dX);
				tarjei.scrollY( -dY);
				if (tarjei.isDead() && winstate == 0) {
					winstate = 1;
				}
				tracker.x = player.x;
				tracker.y = player.y;
				tracker.rotation = Math.atan2((tarjei.icon.y - player.y), (tarjei.icon.x - player.x)) * 180 / Math.PI + 90;
				return output;
			}
			return 0;
		}
		private function fire():void {
			if(currentGun!=1){
				var bullet:Bullet = new Bullet(_bLayer, currentGun, player.x, player.y, player.rotation);
				var clip:Clip = new Clip(_bLayer, currentGun, player.x, player.y, player.rotation);
				bullets.push(bullet);
				clips.push(clip);
				if (currentGun == 4) {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.shotgun.play();
					}
					var xSeed:Number = Math.random();
					var ySeed:Number = Math.random();
					player.x -= xSeed * 15 * Math.cos((player.rotation + 90) * Math.PI / 180);
					player.y -= ySeed * 15 * Math.sin((player.rotation + 90) * Math.PI / 180);
				} else {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.tommygun.play();
					}
				}
			} else {
				if (!SelectionMemory.soundOff) {
					SelectionMemory.sHandler.pistol.play();
				}
				var bullet1:Bullet = new Bullet(_bLayer, currentGun, player.x + 10 * Math.cos(player.rotation), player.y + 10 * Math.sin(player.rotation), player.rotation);
				var clip1:Clip = new Clip(_bLayer, currentGun, player.x + 10 * Math.cos(player.rotation), player.y +  10 * Math.sin(player.rotation), player.rotation);
				var bullet2:Bullet = new Bullet(_bLayer, currentGun, player.x - 10 * Math.cos(player.rotation), player.y - 10 * Math.sin(player.rotation), player.rotation);
				var clip2:Clip = new Clip(_bLayer, currentGun, player.x - 10 * Math.cos(player.rotation), player.y -  10 * Math.sin(player.rotation), player.rotation);
				bullets.push(bullet1, bullet2);	
				clips.push(clip1, clip2);
			}
			gHud.resetFire();
		}
		private function shiftRot(angle:int):void {
			if (!SHIFT) {
				if ((player.rotation >= 0 && angle >= 0) || (player.rotation < 0 && angle < 0)) {
					if (player.rotation > angle) {
						player.rotation -= rotFactor;
					} else if (player.rotation < angle) {
						player.rotation += rotFactor;
					}
				} else if (player.rotation >= 0 && angle < 0) {
					if (player.rotation >= 90 && angle <= -90) {
						player.rotation += rotFactor;
					} else if (player.rotation < 90 && angle > -90) {
						player.rotation -= rotFactor;
					} else if (player.rotation >= 90 && angle > -90) {
						player.rotation += rotFactor;
					} else if (player.rotation < 90 && angle <= -90) {
						player.rotation -= rotFactor;
					}
				} else if (player.rotation < 0 && angle >= 0) {
					if (player.rotation < -90 && angle >= 90) {
						player.rotation -= rotFactor;
					} else if (player.rotation < -90 && angle < 90) {
						player.rotation += rotFactor;
					} else if (player.rotation >= -90 && angle >= 90) {
						player.rotation -= rotFactor;
					} else if (player.rotation >= -90 && angle < 90) {
						player.rotation += rotFactor;
					}
				}
			}
		}
	}
}