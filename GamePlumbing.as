package {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
	public class GamePlumbing {
		private var _pLayer:DisplayObjectContainer;
		private var _bLayer:DisplayObjectContainer;
		private var _hLayer:DisplayObjectContainer;
		private var _xLayer:DisplayObjectContainer;
		private var light:Sprite;
		private var player:MovieClip;
		private var movFactor:int  = 8;
		private var pipeDream:Sprite;
		private var lightangle:int = 30;
		private var lpower:int = 480;
		private var waybackground:Sprite;
		private var pipeElements:Array;
		private var harpooners:Array;
		private var hazards:Array;
		private var explosions:Array;
		private var healthBar:MovieClip;
		private var health:int;
		private var shotWait:int;
		private var scrollRate:Number;
		private var boss:PlumbCore;
		private var bossnum:int;
		private var gamestate:int;
		private var someSortOfTimer:int;
		private var darkness:Sprite;
		private var endtext:MovieClip;
		private var endname:MovieClip;
		private var btype:int;
		private var targName:int;
		private var sB:SmokeBlaster;
		private var victory:int;
		private var pressZ:MovieClip;
		public function GamePlumbing(playerL:DisplayObjectContainer, bg:DisplayObjectContainer, hud:DisplayObjectContainer, bbg:DisplayObjectContainer, mapSpeed:Number = 1.5, spawnrate:Number = 1, enemy:int = 1, tName:int = 1) {
			_pLayer = playerL;
			_xLayer = bbg;
			_bLayer = bg;
			_hLayer = hud;
			targName = tName;
			victory = 0;
			someSortOfTimer = 0;
			gamestate = 1;
			bossnum = enemy;
			health = 1;
			scrollRate = mapSpeed;
			shotWait = 0;
			waybackground = new drainBG();
			waybackground.x += waybackground.width / 2;
			waybackground.y += waybackground.height / 2;
			_xLayer.addChild(waybackground);
			pipeDream = new piping();
			pipeDream.y += pipeDream.height / 2;
			pipeDream.x += pipeDream.width / 2;
			_bLayer.addChild(pipeDream);
			harpooners = [];
			hazards = [];
			addElementsToPipe(spawnrate);
			player = new prot_swim();
			player.x = 60;
			player.y = 120;
			_hLayer.addChild(player);
			healthBar = new hBar();
			healthBar.x = player.x;
			healthBar.y = player.y - 20;
			healthBar.gotoAndStop(1);
			_hLayer.addChild(healthBar);
			light = new Sprite();
			_hLayer.addChild(light);
			_bLayer.mask = light;
			explosions = [];
			btype = enemy;
			iWillStopYouEvilBoss(enemy);
		}
		public function cleanUp():void {
			_hLayer.removeChild(pressZ);
			pressZ = null;
			if (boss.destroyMe()) {
				sB.cleanUp();
				sB = null;
			}
			_hLayer.removeChild(endname);
			_hLayer.removeChild(endtext);
			_hLayer.removeChild(darkness);
			endname = null;
			endtext = null;
			darkness = null;
			btype = 0;
			targName = 0;
			someSortOfTimer = 0;
			gamestate = 0;
			boss.cleanUp();
			scrollRate = 0;
			shotWait = 0;
			health = 0;
			_hLayer.removeChild(healthBar);
			healthBar = null;
			for each(var e:Explosion in explosions) {
				e.cleanUp();
			}
			explosions = [];
			for each(var H:PlumbCore in hazards) {
				H.cleanUp();
			}
			hazards = [];
			for each(var h:Harpoon in harpooners) {
				h.cleanUp();
			}
			harpooners = [];
			for each(var b:MovieClip in pipeElements) {
				_bLayer.removeChild(b);
			}
			pipeElements = [];
			_xLayer.removeChild(waybackground);
			waybackground = null;
			lpower = 0;
			lightangle = 0;
			_bLayer.removeChild(pipeDream);
			pipeDream = null;
			movFactor = 0;
			_hLayer.removeChild(player);
			player = null;
			light = null;
		}
		private function iWillStopYouEvilBoss(bosss:int):void {
			switch(bosss) {
				case 6:
					boss = new WorstEnemy(_bLayer, 1820, 120);
					break;
				case 5:
					boss = new Deceptus(_bLayer, 1820, 125);
					break;
				case 4:
					boss = new Monogamy(_bLayer, 1872, 120);
					break;
				case 3:
					boss = new Chairs(_bLayer, 1820, 120);
					break;
				case 2:
					boss = new TheQuery(_bLayer, 1820, 125);
					break;
				case 1:
				default:
					boss = new BabyDearest(_bLayer, 1820, 125);
					break;
			}
		}
		public function getBoss():int {
			return bossnum;
		}
		private function addElementsToPipe(spawnrate:Number):void {
			pipeElements = [];
			var counter:int = 0;
			while ((Math.random() < 0.85 || counter < 50) && counter < 300) {
				counter += 1;
				var blood:MovieClip = new bStains();
				blood.gotoAndStop(Math.ceil(Math.random() * 11));
				blood.x = 1920 * Math.random();
				blood.y = 10 + 220 * Math.random();
				_bLayer.addChild(blood);
				pipeElements.push(blood);
			}
			counter = 0;
			while ((Math.random() < 0.65 || counter < 25) && counter < 200) {
				counter += 1;
				var sludges:MovieClip = new sludge();
				sludges.gotoAndStop(Math.ceil(Math.random() * 4));
				sludges.x = 1920 * Math.random();
				sludges.y = 10 + 220 * Math.random();
				_bLayer.addChild(sludges);
				pipeElements.push(sludges);
			}
			counter = 0;
			while (Math.random() < 0.95 && counter < 150) {
				counter += 1;
				var dbris:MovieClip = new debris();
				dbris.gotoAndStop(Math.ceil(Math.random() * 19));
				dbris.x = 1920 * Math.random();
				dbris.y = 235;
				if (dbris.currentFrame == 6 || dbris.currentFrame == 10 || dbris.currentFrame == 11 || dbris.currentFrame == 12 || dbris.currentFrame == 13 || dbris.currentFrame == 14 || dbris.currentFrame == 15 || dbris.currentFrame == 16 || dbris.currentFrame == 18 || dbris.currentFrame == 19) {
					dbris.rotation = -20 + 40 * Math.random();
				}
				_bLayer.addChild(dbris);
				pipeElements.push(dbris);
			}
			counter = 0;
			while ((Math.random() < (0.85 * spawnrate) || counter < (30 * spawnrate)) && counter < 80) {
				counter += 1;
				var k:Kelp = new Kelp(_bLayer, 300 + 1120 * Math.random(), 10 + 220 * Math.random());
				hazards.push(k);
			}
			counter = 0;
			while ((Math.random() < (0.75 * spawnrate) || counter < (25 * spawnrate)) && counter < 50) {
				counter += 1;
				var m:Mine = new Mine(_bLayer, 300 + 1120 * Math.random(), 10 + 220 * Math.random());
				hazards.push(m);
			}
			counter = 0;
			while ((Math.random() < (0.65 * spawnrate) || counter < (15 * spawnrate)) && counter < 50) {
				counter += 1;
				var f:Fish = new Fish(_bLayer, 300 + 1120 * Math.random(), 10 + 220 * Math.random());
				hazards.push(f);
			}
		}
		public function update(keys:uint, mouseX:Number, mouseY:Number, click:Boolean):uint {
			if (gamestate == 1) {
				var angee:Number = Math.atan2(player.y + 8 - mouseY, player.x + 25 - mouseX) * 180 / Math.PI + 180;
				if (angee > 315 || angee < 45) {
					player.rotation = angee;
				} else if (angee > 315) {
					angee = 315;
				} else if (angee < 45 ) {
					angee = 45;
				}
				light.graphics.clear();
				if (healthBar.alpha > 0) {
					healthBar.alpha -= 0.02;
					healthBar.x = player.x;
					healthBar.y = player.y - 20;
				}
				light.graphics.beginFill(0xffffcc);
				light.graphics.drawCircle(player.x, player.y, 40);
				light.graphics.endFill();
				var shot:Boolean = false;
				if (shotWait > 0) {
					shotWait -= 1;
				}
				if (click && shotWait <= 0) {
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.harpoon.play();
					}
					shotWait = 8;
					shot = true;
					light.graphics.beginFill(0xffffcc);
					light.graphics.drawCircle(player.x + 25, player.y + 8, 25);
					light.graphics.endFill();
					harpooners.push(new Harpoon(_bLayer, player.x + 25 * Math.cos(angee * Math.PI / 180) - _bLayer.x, player.y + 7 * Math.sin(angee * Math.PI / 180), angee));
				}
				for each(var h:Harpoon in harpooners) {
					h.update();
					if (h.destroyMe()) {
						var rm:int = harpooners.indexOf(h);
						harpooners.splice(rm, 1);
						h.cleanUp();
					}
				}
				var pHurt:Number = 0;
				for each(var HA:PlumbCore in hazards) {
					var n:int = HA.update(player, harpooners);		// b00: 2's bit: explode, 1's bit: damage player
					pHurt += (n & 1);
					if (n & 2) {
						var e:Explosion = new Explosion(_bLayer, HA.getPos().x, HA.getPos().y);
						explosions.push(e);
					}
					if (HA.destroyMe()) {
						var rem:int = hazards.indexOf(HA);
						hazards.splice(rem, 1);
						HA.cleanUp();
					}
				}
				for each(var ex:Explosion in explosions) {
					var r:int = ex.update();
					if (ex.canHurt && player.hitTestObject(ex.getSprite())) {
						ex.canHurt = false;
						pHurt += 1;
					}
					if (r > 28) {
						light.graphics.beginFill(0xffffcc, 0);
						light.graphics.drawCircle(ex.getPos().x + _bLayer.x, ex.getPos().y, 7 * (56 - r));
						light.graphics.endFill();
					} else {
						light.graphics.beginFill(0xffffcc);
						light.graphics.drawCircle(ex.getPos().x + _bLayer.x, ex.getPos().y, 7 * r);
						light.graphics.endFill();
					}
					if (ex.destroyMe()) {
						var ram:int = explosions.indexOf(ex);
						explosions.splice(ram, 1);
						ex.cleanUp();
					}
				}
				if (boss is Deceptus) {
					light.graphics.beginFill(0xffffcc);
					light.graphics.drawCircle(boss.getPos().x + _bLayer.x, boss.getPos().y, 30);
					light.graphics.endFill();
				}
				if (boss is Monogamy) {
					for each(var exe:Explosion in Monogamy(boss).explosions) {
						var re:int = exe.update();
						if (exe.canHurt && player.hitTestObject(exe.getSprite())) {
							exe.canHurt = false;
							pHurt += 1;
						}
						if (re > 28) {
							light.graphics.beginFill(0xffffcc, 0);
							light.graphics.drawCircle(exe.getPos().x + _bLayer.x, exe.getPos().y, 7 * (56 - re));
							light.graphics.endFill();
						} else {
							light.graphics.beginFill(0xffffcc);
							light.graphics.drawCircle(exe.getPos().x + _bLayer.x, exe.getPos().y, 7 * re);
							light.graphics.endFill();
						}
						if (exe.destroyMe()) {
							var rame:int = Monogamy(boss).explosions.indexOf(exe);
							Monogamy(boss).explosions.splice(rame, 1);
							exe.cleanUp();
						}
					}
				}
				if (Math.random() < 0.99) {
					light.graphics.beginFill(0xffffcc);
					light.graphics.moveTo(player.x + 15, player.y + 5);
					var angle:Number = Math.atan2(player.y + 5 - mouseY, player.x + 15 - mouseX);
					for (var i:int = 0; i <= lightangle; i += 5) {
						var ray_angle:Number = ((angle * 180 / Math.PI) + 180 - lightangle / 2 + i) * (Math.PI / 180);
						for (var j:int = 1; j <= 6; j++) {
							if (_bLayer.hitTestPoint(player.x + 15 + (lpower / 6 * j) * Math.cos(ray_angle), player.y + 5 + (lpower / 6 * j) * Math.sin(ray_angle), true)) {
								break;
							}
						}
						light.graphics.lineTo(player.x + 15 + (lpower / 6 * j) * Math.cos(ray_angle), player.y + 5 + (lpower / 6 * j) * Math.sin(ray_angle));
					}
					light.graphics.lineTo(player.x + 15, player.y + 5);
					light.graphics.endFill();
				}
				switch(keys) {
					case 1:
					case 11:
						player.y -= movFactor;
						break;
					case 2:
						player.x -= movFactor;
						break;
					case 7:
					case 3:
						player.y -= movFactor / Math.sqrt(2);
						player.x -= movFactor / Math.sqrt(2);
						break;
					case 4:
					case 14:
						player.y += movFactor;
						break;
					case 6:
						player.y += movFactor / Math.sqrt(2);
						player.x -= movFactor / Math.sqrt(2);
						break;
					case 8:
						player.x += movFactor;
						break;
					case 9:
						player.y -= movFactor / Math.sqrt(2);
						player.x += movFactor / Math.sqrt(2);
						break;
					case 12:
						player.y += movFactor / Math.sqrt(2);
						player.x += movFactor / Math.sqrt(2);
						break;
					case 0:
					case 5:
					case 10:
					case 15:
						//moved = false;
						break;
				}
				if (player.y <= 10) {
					player.y = 10;
				} else if (player.y >= 230) {
					player.y = 230;
				}
				if (player.x <= 20) {
					player.x = 20;
				} else if (player.x >= 460) {
					player.x = 460;
				}
				if (_bLayer.x < -1300) {
					pHurt += boss.update(player, harpooners, keys, shot, angee);
				}
				if (boss.destroyMe()) {
					gamestate = 6;
					sB = new SmokeBlaster(_bLayer, boss.getSprite().x, boss.getSprite().y, boss.getSprite().width, boss.getSprite().height);
				}
				if (pHurt > 0) {
					health += 1;
					if (!SelectionMemory.soundOff) {
						SelectionMemory.sHandler.blood.play();
					}
					var hhhh:int = Math.round(health / 3);
					if (hhhh == 0) { hhhh = 1; }
					healthBar.gotoAndStop(hhhh);
					healthBar.alpha = 1;
					healthBar.x = player.x;
					healthBar.y = player.y - 20;
					if (health > 24) {
						gamestate = 2;
					}
				}
				if (_bLayer.x > -1430) {
					_bLayer.x -= scrollRate;
				} else {
					if (boss is Monogamy) {
						if (player.x > 430) {
							player.x = 430;
						}
					} else  if (player.x > 240) {
						player.x = 240;
					}
				}
			} else if (gamestate == 2) {
				player.rotation = 0;
				player.scaleY *= -1;
				healthBar.alpha = 1;
				healthBar.x = player.x;
				healthBar.y = player.y - 20;
				gamestate = 3;
				someSortOfTimer = 90;
				darkness = new pureBlack();
				darkness.x += 240;
				darkness.y += 120;
				darkness.alpha = 0;
				_bLayer.mask = null;
				_hLayer.removeChild(light);
				_hLayer.addChild(darkness);
			} else if (gamestate == 3) {
				someSortOfTimer -= 1;
				player.y -= 0.5;
				healthBar.y -= 0.5;
				darkness.alpha += 0.012;
				if (someSortOfTimer <= 0) {
					gamestate = 4;
				}
			} else if (gamestate == 4) {
				endtext = new cueCards();
				endtext.gotoAndStop((btype * 2) - 1);
				endtext.x += 240;
				endtext.y += 120;
				_hLayer.addChild(endtext);
				endname = new nameList();
				endname.gotoAndStop(targName);
				var xy:Point = new Point();
				switch(endtext.currentFrame) {
					case 1:
						xy.x = 226.5;
						xy.y = 4;
						break;
					case 3:
						xy.x = 66.5;
						xy.y = 4;
						break;
					case 5:
						xy.x = 46.5;
						xy.y = 4;
						break;
					case 7:
						xy.x = 354.5;
						xy.y = 4;
						break;
					case 9:
						xy.x = 178.5;
						xy.y = 4;
						break;
					case 11:
						xy.x = 0;
						xy.y = -40;
						break;
				}
				victory = 1;
				endname.x += xy.x + endname.width / 2;
				endname.y += xy.y + endname.height / 2;
				_hLayer.addChild(endname);
				pressZ = new pressZanim();
				pressZ.x = 480 - 66;
				pressZ.y = 240 - pressZ.height / 2;
				_hLayer.addChild(pressZ);
				pressZ.alpha = 0.1;
				gamestate = 5;
			} else if (gamestate == 5 && (click || (keys & 16))) {
				return victory;
			} else if (gamestate == 6) {
				sB.update();
				gamestate = 7;
				someSortOfTimer = 90;
				darkness = new pureBlack();
				darkness.x += 240;
				darkness.y += 120;
				darkness.alpha = 0;
				_bLayer.mask = null;
				_hLayer.removeChild(light);
				_hLayer.addChild(darkness);
			} else if (gamestate == 7) {
				sB.update();
				someSortOfTimer -= 1;
				darkness.alpha += 0.012;
				if (someSortOfTimer <= 0) {
					gamestate = 8;
				}
			} else if (gamestate == 8) {
				endtext = new cueCards();
				endtext.gotoAndStop((btype * 2));
				endtext.x += 240;
				endtext.y += 120;
				_hLayer.addChild(endtext);
				endname = new nameList();
				endname.gotoAndStop(targName);
				var yx:Point = new Point();
				switch(endtext.currentFrame) {
					case 2:
						yx.x = 18.5;
						yx.y = 34;
						break;
					case 4:
						yx.x = 66.5;
						yx.y = 4;
						break;
					case 6:
						yx.x = 174.5;
						yx.y = 4;
						break;
					case 8:
						yx.x = 186.5;
						yx.y = 34;
						break;
					case 10:
						yx.x = 338.5;
						yx.y = 4;
						break;
					case 12:
						yx.x = 0;
						yx.y = -40;
						break;
				}
				endname.x += yx.x + endname.width / 2;
				endname.y += yx.y + endname.height / 2;
				victory = 2;
				_hLayer.addChild(endname);
				pressZ = new pressZanim();
				pressZ.x = 480 - 66;
				pressZ.y = 240 - pressZ.height / 2;
				_hLayer.addChild(pressZ);
				pressZ.alpha = 0.1;
				gamestate = 5;
			} 
			return 0;
		}
	}
}