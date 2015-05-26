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
	public class GameHouse extends GamePlatformer {
		private var stairs:MovieClip;
		private var stairsUp:MovieClip;
		private var stairFall:MovieClip;
		private var waybackgroundLEVEL:Sprite;
		private var backgroundLEVEL:Sprite;
		private var foregroundLEVEL:Sprite;
		private var collideLEVEL:Sprite;
		private var backgroundSHIP:Sprite;
		private var foregroundSHIP:Sprite;
		private var waybackgroundSHIP:Sprite;
		private var collideSHIP:Sprite;
		private var iCANNOTbeLIEVEmyEYYYYYYYYYYES:Sprite;
		private var hasEyes:Boolean;
		private var scenery:Sprite;
		private var negaScenery:Sprite;
		private var iPoster:MovieClip;
		private var nPoster:MovieClip;
		private var iBed:MovieClip;
		private var nBed:MovieClip;
		private var iTV:MovieClip;
		private var nTV:MovieClip;
		private var iWindow:MovieClip;
		private var nWindow:MovieClip;
		private var iFlowerPot:MovieClip;
		private var nFlowerPot:MovieClip;
		private var iBushes:MovieClip;
		private var iSon:MovieClip;
		private var nSon:MovieClip;
		private var iSonBubble:MovieClip;
		private var nSonBubble:MovieClip;
		private var iDaughter:MovieClip;
		private var nDaughter:MovieClip;
		private var iDaughterBubble:MovieClip;
		private var nDaughterBubble:MovieClip;
		private var iWife:MovieClip;
		private var nWife:MovieClip;
		private var iNeighbor:MovieClip;
		private var nNeighbor:MovieClip;
		private var iNeighborBubble:MovieClip;
		private var nNeighborBubble:MovieClip;
		private var iButler:MovieClip;
		private var nButler:MovieClip;
		private var iButlerBubble:MovieClip;
		private var nButlerBubble:MovieClip;
		private var spaceShip:MovieClip;
		private var liftOff:Boolean;
		private var exitting:Boolean;
		private var collideBacking:Sprite;
		private var fadeToBlack:Sprite;
		public function GameHouse(bg:DisplayObjectContainer, np:DisplayObjectContainer, pl:DisplayObjectContainer, exiting:Boolean = false, whichGame:int = 1) {
			super(bg, np, pl);
			hasStairs = 1;
			if (exiting) { hasStairs = 2; }
			exitting = exiting;
			hasEyes = false;
			liftOff = false;
			if (!exiting) {
				wayBackground = new houseX();
				background = new house();
				if (SelectionMemory.day == 1) {
					foreground = new houseDD1();
				} else {
					foreground = new houseD();
				}
			} else {
				wayBackground = new houseXNight();
				background = new houseNight();
				if (SelectionMemory.day == 1) {
					foreground = new houseDNightD1();
				} else {
					foreground = new houseDNight();
				}
			}
			wayBackground.x += wayBackground.width / 2;
			wayBackground.y += wayBackground.height / 2;
			background.x += background.width / 2;
			background.y += background.height / 2;
			if (SelectionMemory.day != 5) {
				_backgroundLayer.addChild(background);
				_backgroundLayer.addChild(pan);
				wayBackground.mask = pan;
				foreground.x += foreground.width / 2;
				foreground.y += foreground.height / 2;
				_darkBackgroundLayer.addChild(foreground);
				background.y -= 170;
				foreground.y -= 170;
			}
			_backgroundLayer.addChild(wayBackground);
			wayBackground.y -= 170;
			player.x += 120;
			player.y += 120;
			collisions = new collide1();
			collisions.x = wayBackground.x;
			collisions.y = wayBackground.y + 52;
			_backgroundLayer.addChild(collisions);
			collisions.alpha = 0;
			stairs = new stairwalk();
			_playerLightLayer.addChild(stairs);
			stairs.x = wayBackground.x - 165;
			stairs.y = wayBackground.y + 78;
			stairs.gotoAndStop(1);
			stairs.alpha = 0;
			stairsUp = new stairwalkUp();
			_playerLightLayer.addChild(stairsUp);
			stairsUp.x = wayBackground.x - 165;
			stairsUp.y = wayBackground.y + 78;
			stairsUp.gotoAndStop(1);
			stairsUp.alpha = 0;
			stairFall = new stairfall();
			_playerLightLayer.addChild(stairFall);
			stairFall.x = wayBackground.x - 165;
			stairFall.y = wayBackground.y + 78;
			stairFall.gotoAndStop(1);
			stairFall.alpha = 0;
			if(exiting) {
				stairFall.x = background.x + 165;
				stairsUp.x = background.x + 165;
				stairs.x = background.x + 165;
				stairs.gotoAndStop(117);
				stairsUp.gotoAndStop(117);
				stairFall.gotoAndStop(117);
			}
			if (SelectionMemory.poster == 0) {
				SelectionMemory.poster = Math.ceil(4 * Math.random());
			}
			switch(SelectionMemory.poster) {
				case 2:
					iPoster = new posterB();
					break;
				case 3:
					iPoster = new posterC();
					break;
				case 4:
					iPoster = new posterD();
					break;
				default:
					iPoster = new posterA();
					break;
			}
			if (SelectionMemory.day != 5) {
				scenery = new Sprite();
				iPoster.gotoAndStop(SelectionMemory.day);
				scenery.addChild(iPoster);
				iPoster.x -= 380;
				iPoster.y += 41;
				iBed = new bed();
				iBed.gotoAndStop(SelectionMemory.day);
				scenery.addChild(iBed);
				iBed.x -= 379;
				iBed.y += 87;
				iTV = new TV();
				iTV.gotoAndStop(SelectionMemory.day);
				scenery.addChild(iTV);
				iTV.x -= 269;
				iTV.y += 70;
				iWindow = new window();
				iWindow.gotoAndStop(SelectionMemory.day * 2 - 1);
				scenery.addChild(iWindow);
				iWindow.x -= 320;
				iWindow.y += 43;
				iFlowerPot = new flowerpot();
				iFlowerPot.gotoAndStop(SelectionMemory.day);
				scenery.addChild(iFlowerPot);
				iFlowerPot.x += 90;
				iFlowerPot.y += 183;
			}
			negaScenery = new Sprite();
			nPoster = new posterA();
			nPoster.gotoAndStop(5);
			negaScenery.addChild(nPoster);
			nPoster.x -= 380;
			nPoster.y += 41;
			nBed = new bed();
			nBed.gotoAndStop(5);
			negaScenery.addChild(nBed);
			nBed.x -= 379;
			nBed.y += 87;
			nTV = new TV();
			nTV.gotoAndStop(5);
			negaScenery.addChild(nTV);
			nTV.x -= 269;
			nTV.y += 70;
			nWindow = new window();
			nWindow.gotoAndStop(9);
			negaScenery.addChild(nWindow);
			nWindow.x -= 320;
			nWindow.y += 43;
			nFlowerPot = new flowerpot();
			nFlowerPot.gotoAndStop(5);
			negaScenery.addChild(nFlowerPot);
			nFlowerPot.x += 90;
			nFlowerPot.y += 183;
			if (SelectionMemory.day != 5) {
				iSon = new son();
				scenery.addChild(iSon);
				iSon.x -= 190;
				iSon.y += 81;
				iSonBubble = new sb1();
				iSonBubble.gotoAndStop(Math.ceil(7 * Math.random()));
				scenery.addChild(iSonBubble);
				iSonBubble.x -= 165;
				iSonBubble.y += 26;
				iDaughter = new daughterStand();
				scenery.addChild(iDaughter);
				iDaughter.y += 186;
				iDaughterBubble = new sb3();
				iDaughterBubble.gotoAndStop(Math.ceil(7 * Math.random()));
				scenery.addChild(iDaughterBubble);
				iDaughterBubble.x += 25;
				iDaughterBubble.y += 136;
				if(!exiting){
					iWife = new wifeKiss();
					scenery.addChild(iWife);
					iWife.x += 100;
					iWife.y += 186;
					iWife.gotoAndStop(1);
				} else {
					iWife = new wifeKiss();
					scenery.addChild(iWife);
					iWife.x -= 280;
					iWife.y += 81;
					iWife.scaleX = -1;
					iWife.gotoAndStop(1);
				}
				iNeighbor = new neiClip();
				scenery.addChild(iNeighbor);
				iNeighbor.x += 268;
				iNeighbor.y += 181;
				iNeighborBubble = new sb2();
				iNeighborBubble.gotoAndStop(Math.ceil(7 * Math.random()));
				scenery.addChild(iNeighborBubble);
				iNeighborBubble.x += 260;
				iNeighborBubble.y += 106;
				iButler = new butlerStand();
				scenery.addChild(iButler);
				iButler.x += 1350;
				iButler.y += 183;
				iButlerBubble = new sb4();
				scenery.addChild(iButlerBubble);
				iButlerBubble.x += 1380;
				iButlerBubble.y += 123;
				iButlerBubble.gotoAndStop(Math.ceil(7 * Math.random()));
				nSon = new son();
				negaScenery.addChild(nSon);
				nSon.x -= 190;
				nSon.y += 81;
				nSon.scaleX = -1;
				nSonBubble = new sb1();
				nSonBubble.gotoAndStop(7 + Math.ceil(7 * Math.random()));
				negaScenery.addChild(nSonBubble);
				nSonBubble.x -= 165;
				nSonBubble.y += 26;
				nDaughter = new daughterPhone();
				negaScenery.addChild(nDaughter);
				nDaughter.y += 186;
				nDaughterBubble = new sb3();
				nDaughterBubble.gotoAndStop(7 + Math.ceil(7 * Math.random()));
				negaScenery.addChild(nDaughterBubble);
				nDaughterBubble.x += 25;
				nDaughterBubble.y += 136;
				nWife = new neiPlow();
				negaScenery.addChild(nWife);
				nWife.x -= 379;
				nWife.y += 73;
				nNeighbor = new neiLaugh();
				negaScenery.addChild(nNeighbor);
				nNeighbor.x += 268;
				nNeighbor.y += 182;
				nNeighborBubble = new sb2();
				nNeighborBubble.gotoAndStop(7 + Math.ceil(7 * Math.random()));
				negaScenery.addChild(nNeighborBubble);
				nNeighborBubble.x += 260;
				nNeighborBubble.y += 106;
				nButler = new butlerSmoke();
				negaScenery.addChild(nButler);
				nButler.x += 1350;
				nButler.y += 183;
				nButlerBubble = new sb4();
				negaScenery.addChild(nButlerBubble);
				nButlerBubble.x += 1380;
				nButlerBubble.y += 123;
				nButlerBubble.gotoAndStop(7 + Math.ceil(7 * Math.random()));
				iBushes = new bushes();
				iBushes.gotoAndStop(SelectionMemory.day);
				scenery.addChild(iBushes);
				iBushes.x += 270;
				iBushes.y += 183;
			}
			
			spaceShip = new rocketShip();
			spaceShip.gotoAndStop(1);
			if (SelectionMemory.day != 5) {
				scenery.addChild(spaceShip);
			} else {
				negaScenery.addChild(spaceShip);
			}
			spaceShip.x += 1475;
			if (SelectionMemory.day == 5) {
				spaceShip.x -= 750;
			}
			spaceShip.y += 155;
			if (SelectionMemory.day != 5) {
				switch(whichGame) {
					case 2:
						waybackgroundLEVEL = new levelBX();
						backgroundLEVEL = new levelB();
						foregroundLEVEL = new levelBD();
						collideLEVEL = new levelBcol();
						break;
					case 3:
						waybackgroundLEVEL = new levelCX();
						backgroundLEVEL = new levelC();
						foregroundLEVEL = new levelCD();
						collideLEVEL = new levelCcol();
						break;
					case 4:
						waybackgroundLEVEL = new levelDX();
						backgroundLEVEL = new levelD();
						foregroundLEVEL = new levelDD();
						collideLEVEL = new levelDcol();
						break;
					case 5:
						waybackgroundLEVEL = new levelEX();
						backgroundLEVEL = new levelE();
						foregroundLEVEL = new levelED();
						collideLEVEL = new levelEcol();
						hasEyes = true;
						iCANNOTbeLIEVEmyEYYYYYYYYYYES = new levelEeyes();
						iCANNOTbeLIEVEmyEYYYYYYYYYYES.x = backgroundLEVEL.width;
						iCANNOTbeLIEVEmyEYYYYYYYYYYES.y = backgroundLEVEL.height / 4 - 50;
						break;
					case 1:
					default:
						waybackgroundLEVEL = new levelAX();
						backgroundLEVEL = new levelA();
						foregroundLEVEL = new levelAD();
						collideLEVEL = new levelAcol();
						break;
				}
				waybackgroundLEVEL.x += waybackgroundLEVEL.width;
				wayBackground.addChild(waybackgroundLEVEL);
				backgroundLEVEL.x += backgroundLEVEL.width;
				background.addChild(backgroundLEVEL);
				foregroundLEVEL.x += foregroundLEVEL.width;
				foreground.addChild(foregroundLEVEL);
				collideLEVEL.x += backgroundLEVEL.width;
				collideLEVEL.y -= 50;
				collisions.addChild(collideLEVEL);
			}
			waybackgroundSHIP = new shipLX();
			waybackgroundSHIP.x += wayBackground.width - 300;
			wayBackground.addChild(waybackgroundSHIP);
			if (SelectionMemory.day != 5) {
				if (!exiting) {
					backgroundSHIP = new shipL();
				} else {
					backgroundSHIP = new shipLNight();
				}
				backgroundSHIP.x += background.width - 300;
				background.addChild(backgroundSHIP);
				foregroundSHIP = new shipLD();
				foregroundSHIP.x += foreground.width - 300;
				foreground.addChild(foregroundSHIP);
			}
			collideSHIP = new shipLcol();
			collideSHIP.x += waybackgroundSHIP.x;
			collideSHIP.y -= 50;
			collisions.addChild(collideSHIP);
			
			if (exiting) {
				waybackgroundSHIP.x = wayBackground.x;
				backgroundSHIP.x = background.x;
				foregroundSHIP.x = foreground.x;
				collideSHIP.x = collisions.x;
				wayBackground.scaleX *= -1;
				background.scaleX *= -1;
				foreground.scaleX *= -1;
				collisions.scaleX *= -1;
				stairs.scaleX *= -1;
				stairsUp.scaleX *= -1;
				stairFall.scaleX *= -1;
				iPoster.alpha = 0;
				iTV.alpha = 0;
				iBushes.alpha = 0;
				iFlowerPot.alpha = 0;
				iWindow.gotoAndStop(SelectionMemory.day * 2);
				nPoster.alpha = 0;
				nTV.alpha = 0;
				nFlowerPot.alpha = 0;
				iWindow.scaleX *= -1;
				nWindow.scaleX *= -1;
				iNeighbor.alpha = 0;
				iNeighborBubble.alpha = 0;
				nNeighbor.alpha = 0;
				nNeighborBubble.alpha = 0;
				iDaughter.alpha = 0;
				iDaughterBubble.alpha = 0;
				iSon.alpha = 0;
				iSonBubble.alpha = 0;
				nDaughter.alpha = 0;
				nDaughterBubble.alpha = 0;
				nSon.alpha = 0;
				nSonBubble.alpha = 0;
				nWife.alpha = 0;
				collideBacking = new collideWall();
				collisions.addChild(collideBacking);
				collideBacking.x += 520;
			}
			
			if (SelectionMemory.day != 5) {
				background.addChild(scenery);
			}
			wayBackground.addChild(negaScenery);
			
			if (hasEyes) {
				background.addChild(iCANNOTbeLIEVEmyEYYYYYYYYYYES);
			}
		}
		public override function cleanUp():void {
			_playerLightLayer.removeChild(fadeToBlack);
			if (SelectionMemory.day != 5) {
				scenery.removeChild(iPoster);
				scenery.removeChild(iBed);
				scenery.removeChild(iTV);
				scenery.removeChild(iWindow);
				scenery.removeChild(iFlowerPot);
				scenery.removeChild(iBushes);
				scenery.removeChild(spaceShip);				
				iPoster = null;
				iBed = null;
				iTV = null;
				iWindow = null;
				iFlowerPot = null;
				iBushes = null;
			} else {
				negaScenery.removeChild(spaceShip);
			}
			negaScenery.removeChild(nPoster);
			negaScenery.removeChild(nBed);
			negaScenery.removeChild(nTV);
			negaScenery.removeChild(nWindow);
			negaScenery.removeChild(nFlowerPot);
			spaceShip = null;
			nPoster = null;
			nBed = null;
			nTV = null;
			nWindow = null;
			nFlowerPot = null;
			if (SelectionMemory.day != 5) {
				scenery.removeChild(iSon);
				scenery.removeChild(iSonBubble);
				scenery.removeChild(iDaughter);
				scenery.removeChild(iDaughterBubble);
				scenery.removeChild(iWife);
				scenery.removeChild(iNeighbor);
				scenery.removeChild(iNeighborBubble);
				scenery.removeChild(iButler);
				scenery.removeChild(iButlerBubble);
				negaScenery.removeChild(nSon);
				negaScenery.removeChild(nSonBubble);
				negaScenery.removeChild(nDaughter);
				negaScenery.removeChild(nDaughterBubble);
				negaScenery.removeChild(nWife);
				negaScenery.removeChild(nNeighbor);
				negaScenery.removeChild(nNeighborBubble);
				negaScenery.removeChild(nButler);
				negaScenery.removeChild(nButlerBubble);
				iSon = null;
				iSonBubble = null;
				iDaughter = null;
				iDaughterBubble = null;
				iWife = null;
				iNeighbor = null;
				iNeighborBubble = null;
				iButler = null;
				iButlerBubble = null;
				nSon = null;
				nSonBubble = null;
				nDaughter = null;
				nDaughterBubble = null;
				nWife = null;
				nNeighbor = null;
				nNeighborBubble = null;
				nButler = null;
				nButlerBubble = null;
				background.removeChild(scenery);
			}
			wayBackground.removeChild(negaScenery);
			scenery = null;
			negaScenery = null;
			_playerLightLayer.removeChild(stairFall);
			_playerLightLayer.removeChild(stairs);
			_playerLightLayer.removeChild(stairsUp);
			stairFall = null;
			stairs = null;
			stairsUp = null;
			if (SelectionMemory.day != 5) {
				wayBackground.removeChild(waybackgroundLEVEL);
				background.removeChild(backgroundLEVEL);
				foreground.removeChild(foregroundLEVEL);
				collisions.removeChild(collideLEVEL);
				background.removeChild(backgroundSHIP);
				foreground.removeChild(foregroundSHIP);
			}
			wayBackground.removeChild(waybackgroundSHIP);
			collisions.removeChild(collideSHIP);
			waybackgroundLEVEL = null;
			waybackgroundSHIP = null;
			backgroundLEVEL = null;
			backgroundSHIP = null;
			foregroundLEVEL = null;
			foregroundSHIP = null;
			collideLEVEL = null;
			collideSHIP = null;
			if (hasEyes) {
				background.removeChild(iCANNOTbeLIEVEmyEYYYYYYYYYYES);
				iCANNOTbeLIEVEmyEYYYYYYYYYYES = null;
			}
			if (SelectionMemory.day != 5) {
				_backgroundLayer.removeChild(background);
				_backgroundLayer.removeChild(pan);
				_darkBackgroundLayer.removeChild(foreground);
			}
			_backgroundLayer.removeChild(wayBackground);
			_backgroundLayer.removeChild(collisions);
			background = null;
			wayBackground = null;
			pan = null;
			foreground = null;
			collisions = null;
			_playerLightLayer.removeChild(player);
			player = null;
			fadeToBlack = null;
		}
		protected override function otherThings(keys:uint, mouseX:int, mouseY:int):int {
			if ((wayBackground.x < 33 && wayBackground.x > 28 && !exitting) || (wayBackground.x < -140 && wayBackground.x > -150 && exitting)) {
				if (SelectionMemory.day != 5) { iWife.play(); }
				
			}
			if (hasEyes) {
				var ix:int = backgroundLEVEL.width;
				var iy:int = backgroundLEVEL.height / 4 - 50;
				var B:Number = Math.atan2(iy - player.y, ix - player.x) * 180 / Math.PI;
				iCANNOTbeLIEVEmyEYYYYYYYYYYES.x = ix - 50 * Math.cos(-B + 90);
				iCANNOTbeLIEVEmyEYYYYYYYYYYES.y = iy - 50 * Math.sin(-B + 90); 
			}
			if (!exitting) {
				if (onStairs) {
					player.alpha = 0;
					if (stairFalling) {
						stairFall.alpha = 1;
						stairsUp.alpha = 0;
						stairs.alpha = 0;
						stairs.gotoAndStop(stairs.currentFrame + 3);
						stairsUp.gotoAndStop(stairs.currentFrame);
						stairFall.gotoAndStop(stairs.currentFrame);
					} else {
						stairFall.alpha = 0;
						if (keys & 4) {
							stairs.alpha = 1;
							stairsUp.alpha = 0;
							stairs.gotoAndStop(stairs.currentFrame + 3);
							stairsUp.gotoAndStop(stairs.currentFrame);
							stairFall.gotoAndStop(stairs.currentFrame);
						} else if (keys & 2) {
							stairsUp.alpha = 1;
							stairs.alpha = 0;
							stairs.gotoAndStop(stairs.currentFrame - 3);
							stairsUp.gotoAndStop(stairs.currentFrame);
							stairFall.gotoAndStop(stairs.currentFrame);
						}
					}
				} else if (stairFalling) {
					stairFall.gotoAndStop(126);
					stairFall.alpha = 1;
					stairsUp.alpha = 0;
					stairs.alpha = 0;
					player.alpha = 0;
				} else {
					stairFall.alpha = 0;
					stairsUp.alpha = 0;
					stairs.alpha = 0;
					player.alpha = 1;
				}
				if (stairs.alpha == 0 && stairsUp.alpha == 0 && stairFall.alpha == 0) {
					player.alpha = 1;
				}
			} else {
				if (onStairs) {
					player.alpha = 0;
					if (stairFalling) {
						stairFall.alpha = 1;
						stairsUp.alpha = 0;
						stairs.alpha = 0;
						stairs.gotoAndStop(stairs.currentFrame + 3);
						stairsUp.gotoAndStop(stairs.currentFrame);
						stairFall.gotoAndStop(stairs.currentFrame);
					} else {
						stairFall.alpha = 0;
						if (keys & 2) {
							stairs.alpha = 1;
							stairsUp.alpha = 0;
							stairs.gotoAndStop(stairs.currentFrame + 3);
							stairsUp.gotoAndStop(stairs.currentFrame);
							stairFall.gotoAndStop(stairs.currentFrame);
						} else if (keys & 4) {
							stairsUp.alpha = 1;
							stairs.alpha = 0;
							stairs.gotoAndStop(stairs.currentFrame - 3);
							stairsUp.gotoAndStop(stairs.currentFrame);
							stairFall.gotoAndStop(stairs.currentFrame);
						}
					}
				} else if (stairFalling) {
					stairFall.gotoAndStop(126);
					stairFall.alpha = 1;
					stairsUp.alpha = 0;
					stairs.alpha = 0;
					player.alpha = 0;
				} else {
					stairFall.alpha = 0;
					stairsUp.alpha = 0;
					stairs.alpha = 0;
					player.alpha = 1;
				}
				if (stairs.alpha == 0 && stairsUp.alpha == 0 && stairFall.alpha == 0) {
					player.alpha = 1;
				}
			}
			if (player.x > 370 && !liftOff) {
				haltControl = true;
				liftOff = true;
				player.alpha = 0;
				spaceShip.play();
				if (SelectionMemory.day != 5) {
					_backgroundLayer.mask = null;
					_playerLightLayer.removeChild(light);
				}
				fadeToBlack = new pureBlack();
				_playerLightLayer.addChild(fadeToBlack);
				fadeToBlack.alpha = 0; 
				fadeToBlack.x = 240;
				fadeToBlack.y = 120;
			}
			if (liftOff) {
				showDark = false;
				spaceShip.y -= 4;
				player.alpha = 0;
				fadeToBlack.alpha += 0.025;
				if (spaceShip.y <= -200) {
					return 1;
				}
			}
			var dX:int = 0;
			if (player.scaleX > -10) {
				if (player.x != 200) {
				//if (player.x != 120) {
					//dX = 120 - player.x;
					dX = 200 - player.x;
					if(SelectionMemory.day != 5) {
						if (((wayBackground.x > -1070 || dX > 0) && (wayBackground.x < 500 || dX < 0) && !exitting) || ((wayBackground.x > -10 || dX > 0) && (wayBackground.x < 500 || dX < 0) && exitting)) {
							player.x += dX;
							wayBackground.x += dX;
							background.x += dX;
							foreground.x += dX;
							collisions.x += dX;
							stairs.x += dX;
							stairsUp.x += dX;
							stairFall.x += dX;
						}
					} else {
						if (((wayBackground.x > -(1070 - 750) || dX > 0) && (wayBackground.x < 500 || dX < 0) && !exitting) || ((wayBackground.x > -10 || dX > 0) && (wayBackground.x < 500 || dX < 0) && exitting)) {
							player.x += dX;
							wayBackground.x += dX;
							collisions.x += dX;
							stairs.x += dX;
							stairsUp.x += dX;
							stairFall.x += dX;
						}
					}
				}
			} else {
				if (player.x != 360) {
					dX = 360 - player.x;
					if(SelectionMemory.day != 5) {
						if (((wayBackground.x > -1070 || dX > 0) && (wayBackground.x < 500 || dX < 0) && !exitting) || ((wayBackground.x > -10 || dX > 0) && (wayBackground.x < 500 || dX < 0) && exitting)) {
							player.x += dX;
							wayBackground.x += dX;
							background.x += dX;
							foreground.x += dX;
							collisions.x += dX;
							stairs.x += dX;
							stairsUp.x += dX;
							stairFall.x += dX;
						}
					} else {
						if (((wayBackground.x > -(1070 - 750) || dX > 0) && (wayBackground.x < 500 || dX < 0) && !exitting) || ((wayBackground.x > -10 || dX > 0) && (wayBackground.x < 500 || dX < 0) && exitting)) {
							player.x += dX;
							wayBackground.x += dX;
							collisions.x += dX;
							stairs.x += dX;
							stairsUp.x += dX;
							stairFall.x += dX;
						}
					}
				}
			}
			if (player.y != 120) {
				var dY:int = 120 - player.y;
				if (wayBackground.y > 2 || dY > 0) {
					player.y += dY;
					wayBackground.y += dY;
					background.y += dY;
					foreground.y += dY;
					collisions.y += dY;
					stairs.y += dY;
					stairsUp.y += dY;
					stairFall.y += dY;
				}
			}
			if (!collisions.hitTestPoint(player.x, player.y + player.height / 2 + 2, true)) {
				jumping = true;
			}
			return 0;
		}
	}
}