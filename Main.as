package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.SharedObject;
	import flash.ui.Mouse;
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
	public class Main extends Sprite {
		private var WON:Boolean;
		private var firstTime:Boolean;
		private var player:MovieClip;
		private var DOWN:Boolean;
		private var UP:Boolean;
		private var LEFT:Boolean;
		private var RIGHT:Boolean;
		private var SHIFT:Boolean;
		private var ALTKEY:uint;
		private var KEY1:Boolean;
		private var KEY2:Boolean;
		private var KEY3:Boolean;
		private var KEYQ:Boolean;
		private var KEYW:Boolean;
		private var KEYE:Boolean;
		private var KEYA:Boolean;
		private var KEYS:Boolean;
		private var KEYD:Boolean;
		private var KEYZ:Boolean;
		private var KEYX:Boolean;
		private var KEYC:Boolean;
		private var KEYB:Boolean;
		private var KEYU:Boolean;
		private var KEY7:Boolean;
		private var KEYP:Boolean;
		private var KEYV:Boolean;
		private var KEYN:Boolean;
		private var KEYM:Boolean;
		private var CLICK:Boolean;
		private var UNCLICK:Boolean;
		private var titleGame:GamePlacard;
		private var shootGame:GameShooting;
		private var plumbGame:GamePlumbing;
		private var bossRush:GamePlumbingPlus;
		private var writeGame:GameWriting;
		private var moveGame:GamePlatformer;
		private var spaceGame:GameSpace;
		private var spaceExit:GameSpaceExit;
		private var crediGame:GameCredits;
		private var newMenu:Menu2;
		private var evenBackyGroundierLayer:Sprite;
		private var backgroundlayer:Sprite;
		private var playerlayer:Sprite;
		private var hudlayer:Sprite;
		private var topLayer:Sprite;
		private var mouseLayer:Sprite;
		private var SHEEP:int;
		private var pauseButton:MovieClip;
		private var paused:Boolean;
		private var loaderIcon:MovieClip;
		private var OK:Boolean;
		public function Main() {
			Mouse.hide();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			OK = false;
			loaderIcon = new loadClip();
			loaderIcon.x = 240;
			loaderIcon.y = 120;
			loaderIcon.gotoAndStop(1);
			addChild(loaderIcon);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, preloader);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, ZP);
			//SelectionMemory.day = 4;
			//initializeHouse();
			//initializeSpaceExit();
			//initializeSpaceship();
			//initializeOfficeEntrance();
			//initializePlumber();
			//initializeShooter();
			//initializeWriter();
			//initializeOfficeExit(1, true, 1);
			//initializeHouseExit();
			//initializeMenu2();
			//SelectionMemory.space = new Space();
		}
		private function ZP(e:KeyboardEvent):void {
			if (e.keyCode == 90 && OK) {
				loaderInfo.removeEventListener(ProgressEvent.PROGRESS, preloader);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, ZP);
				removeChild(loaderIcon);
				setUpActualGame();
			}
		}
		private function preloader(e:ProgressEvent):void {
			var p:int = 100 * (e.bytesLoaded / e.bytesTotal);
			if (p > 98) { OK = true; }
			loaderIcon.gotoAndStop(p);
		}
		private function setUpActualGame():void {
			WON = false;
			firstTime = true;
			SHEEP = -1;
			UNCLICK = false;
			paused = false;
			SelectionMemory.sHandler = new SoundHandler();
			evenBackyGroundierLayer = new Sprite();
			backgroundlayer = new Sprite();
			playerlayer = new Sprite();
			hudlayer = new Sprite();
			addChild(evenBackyGroundierLayer);
			addChild(backgroundlayer);
			addChild(playerlayer);
			addChild(hudlayer);
			mouseLayer = new cursor();
			addChild(mouseLayer);
			topLayer = new sidewinder();
			topLayer.x += 240;
			topLayer.y += 120;
			addChild(topLayer);
			pauseButton = new pauseScreen();
			pauseButton.x += 240;
			pauseButton.y += 120;
			pauseButton.alpha = 0;
			pauseButton.gotoAndStop(1);
			addChild(pauseButton);
			CLICK = false;
			UP = false;
			DOWN = false;
			LEFT = false;
			RIGHT = false;
			SHIFT = false;
			KEY1 = false;
			KEY2 = false;
			KEY3 = false;
			KEYQ = false;
			KEYW = false;
			KEYE = false;
			KEYA = false;
			KEYS = false;
			KEYD = false;
			KEYZ = false;
			KEYX = false;
			KEYC = false;
			KEYB = false;
			KEYU = false;
			KEY7 = false;
			KEYP = false;
			KEYV = false;
			KEYM = false;
			initializeMenu2();
			/*var shared:SharedObject = SharedObject.getLocal("won");
			if (shared.data.won == undefined) {
				initializePlacard(3);
			} else {
				initializeMenu2();
			}
			shared.close();*/
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mousePress);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseRelease);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		private function resetEverything():void {
			CLICK = false;
			UP = false;
			DOWN = false;
			LEFT = false;
			RIGHT = false;
			SHIFT = false;
			KEY1 = false;
			KEY2 = false;
			KEY3 = false;
			KEYQ = false;
			KEYW = false;
			KEYE = false;
			KEYA = false;
			KEYS = false;
			KEYD = false;
			KEYZ = false;
			KEYX = false;
			KEYC = false;
			KEYB = false;
			KEYU = false;
			KEY7 = false;
			KEYP = false;
			KEYV = false;
			KEYN = false;
			KEYM = false;
			SelectionMemory.space = new Space();
			SelectionMemory.day = 1;
			SelectionMemory.poster = 0;
			SelectionMemory.gamesPlayed = [];
			SelectionMemory.ScrollerLevels = [1, 2, 3, 4, 5];
			SelectionMemory.ShooterLevels = [1, 2, 3, 4, 5, 6, 7];
			SelectionMemory.PlumberLevels = [1, 2, 3, 4, 5, 6];
			SelectionMemory.WriterLevels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
		}
		private function realignLayers():void {
			evenBackyGroundierLayer.x = 0;
			backgroundlayer.x = 0;
			playerlayer.x = 0;
			hudlayer.x = 0;
			evenBackyGroundierLayer.y = 0;
			backgroundlayer.y = 0;
			playerlayer.y = 0;
			hudlayer.y = 0;
			
		}
		private function mouseMove(e:MouseEvent):void {
			mouseLayer.x = mouseX;
			mouseLayer.y = mouseY;
		}
		private function mousePress(e:MouseEvent):void {
			CLICK = true;
		}
		private function mouseRelease(e:MouseEvent):void {
			CLICK = false;
			UNCLICK = true;
		}
		private function keyDown(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37:
					LEFT = true;
					break;
				case 38:
					UP = true;
					break;
				case 39:
					RIGHT = true;
					break;
				case 40:
					DOWN = true;
					break;
				case 16:
					SHIFT = true;
					break;
				case 49:
					KEY1 = true;
					break;
				case 50:
					KEY2 = true;
					break;
				case 51:
					KEY3 = true;
					break;
				case 65:
					KEYA = true;
					break;
				case 67:
					KEYC = true;
					break;
				case 68:
					KEYD = true;
					break;
				case 69:
					KEYE = true;
					break;
				case 77:
					KEYM = true;
					break;
				case 78:
					KEYN = true;
					break;
				case 80:
					KEYP = true;
					break;
				case 81:
					KEYQ = true;
					break;
				case 83:
					KEYS = true;
					break;
				case 86:
					KEYV = true;
				case 87:
					KEYW = true;
					break;
				case 88:
					KEYX = true;
					break;
				case 90:
					KEYZ = true;
					break;
				case 55:
					KEY7 = true;
					break;
				case 66:
					KEYB = true;
					break;
				case 85:
					KEYU = true;
					break;
			}
		}
		private function keyUp(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37:
					LEFT = false;
					break;
				case 38:
					UP = false;
					break;
				case 39:
					RIGHT = false;
					break;
				case 40:
					DOWN = false;
					break;
				case 16:
					SHIFT = false;
					break;
				case 49:
					KEY1 = false;
					break;
				case 50:
					KEY2 = false;
					break;
				case 51:
					KEY3 = false;
					break;
				case 65:
					KEYA = false;
					break;
				case 67:
					KEYC = false;
					break;
				case 68:
					KEYD = false;
					break;
				case 69:
					KEYE = false;
					break;
				case 77:
					KEYM = false;
					break;
				case 78:
					KEYN = false;
					break;
				case 80:
					KEYP = false;
					break;
				case 81:
					KEYQ = false;
					break;
				case 83:
					KEYS = false;
					break;
				case 86:
					KEYV = false;
					break;
				case 87:
					KEYW = false;
					break;
				case 88:
					KEYX = false;
					break;
				case 90:
					KEYZ = false;
					break;
				case 55:
					KEY7 = false;
					break;
				case 66:
					KEYB = false;
					break;
				case 85:
					KEYU = false;
					break;
			}
		}
		private function initializePlacard(mode:int = 1):void {
			realignLayers();
			titleGame = new GamePlacard(backgroundlayer, playerlayer, mode);
			addEventListener(Event.ENTER_FRAME, loop_Placard);
			mouseLayer.alpha = 0;
			if (mode == 3 && !SelectionMemory.soundOff) {
				SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.theme.play(0, 99);
			}
		}
		private function loop_Placard(e:Event):void {
			titleGame.update();
			if ((KEYZ && ((titleGame.getTimer() < 50) || (titleGame.getState() == 3))) || SHEEP > 0) {
				KEYZ = false;
				var s:int = titleGame.getState();
				if (titleGame.backing.currentFrame == 327) {
					SHEEP = 0;
				}
				if (s == 3 && SHEEP < 10) {
					if (SHEEP == -1) {
						titleGame.backing.gotoAndStop(327);
					}
					if (SHEEP == 0) {
						titleGame.BLASTSHEEP();
					}
					SHEEP += 1;
				} else {
					SHEEP = 0;
					titleGame.cleanUp();
					SelectionMemory.sHandler.GameMusic.stop();
					removeEventListener(Event.ENTER_FRAME, loop_Placard);
					titleGame = null;
					if (KEY1 && KEY2 && KEY3) {
						s = 5;
					}
					switch(s) {
						case 5:
							initializeMenu2();
							break;
						case 4:
							initializeHouse();
							break;
						case 3:
							initializePlacard(1);
							break;
						case 2:
							SelectionMemory.day += 1;
							initializePlacard(1);
							break;
						default:
							if (firstTime) {
								firstTime = false;
								initializePlacard(4);
							} else {
								initializeHouse();
							}
							break;
					}
				}
			}
		}
		private function initializeHouse():void {
			realignLayers();
			var k:int = Math.floor(SelectionMemory.ScrollerLevels.length * Math.random());
			var i:int = SelectionMemory.ScrollerLevels[k];
			SelectionMemory.ScrollerLevels.splice(k, 1);
			moveGame = new GameHouse(backgroundlayer, playerlayer, hudlayer, false, i);
			addEventListener(Event.ENTER_FRAME, loop_houseEntrance);
			mouseLayer.alpha = 0;
			if (!SelectionMemory.soundOff) {
				switch(SelectionMemory.day) {
					case 1:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse1.play(0, 99);
						break;
					case 2:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse2.play(0, 99);
						break;
					case 3:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse3.play(0, 99);
						break;
					case 4:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse4.play(0, 99);
						break;
				}
			}
		}
		private function loop_houseEntrance(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								switch(SelectionMemory.day) {
									case 1:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse1.play(0, 99);
										break;
									case 2:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse2.play(0, 99);
										break;
									case 3:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse3.play(0, 99);
										break;
									case 4:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse4.play(0, 99);
										break;
								}
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYD);
			}
			var changes:int = 0;
			if (!paused) {
				changes = moveGame.update(keys, mouseX, mouseY, CLICK);
			}
			if (changes == 1) {
				mouseLayer.alpha = 1;
				SelectionMemory.sHandler.GameMusic.stop();
				moveGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_houseEntrance);
				moveGame = null;
				//initializeSpaceship();
				initializeOfficeEntrance();
			}
		}
		private function initializeSpaceship():void {
			realignLayers();
			spaceGame = new GameSpace(backgroundlayer, playerlayer, hudlayer);
			addEventListener(Event.ENTER_FRAME, loop_Spaceship);
			mouseLayer.alpha = 0;
		}
		private function loop_Spaceship(e:Event):void {
			//if you reinstate me, add the pause code!
			var keys:uint = 1 * uint(LEFT) + 2 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYA) + 2 * uint(KEYD);
			}
			var changes:int = spaceGame.update(keys);
			if (changes == 1) {
				mouseLayer.alpha = 1;
				spaceGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_Spaceship);
				spaceGame = null;
				initializeOfficeEntrance();
			}
		}
		private function initializeOfficeEntrance():void {
			realignLayers();
			moveGame = new GameOffice(backgroundlayer, playerlayer, hudlayer);
			addEventListener(Event.ENTER_FRAME, loop_OfficeEntrance);
			mouseLayer.alpha = 0;
			if (!SelectionMemory.soundOff) {
				switch(SelectionMemory.day) {
					case 1:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office1.play(0, 99);
						break;
					case 2:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office2.play(0, 99);
						break;
					case 3:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office3.play(0, 99);
						break;
					case 4:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office4.play(0, 99);
						break;
				}
			}
		}
		private function loop_OfficeEntrance(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								switch(SelectionMemory.day) {
									case 1:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office1.play(0, 99);
										break;
									case 2:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office2.play(0, 99);
										break;
									case 3:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office3.play(0, 99);
										break;
									case 4:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office4.play(0, 99);
										break;
								}
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYD);
			}
			var changes:int = 0;
			if (!paused) {
				changes = moveGame.update(keys, mouseX, mouseY, CLICK);
			}
			if (changes == 1) {
				mouseLayer.alpha = 1;
				if (SelectionMemory.day != 5) {
					SelectionMemory.sHandler.GameMusic.stop();
					var I:InstructionSet = GameOffice(moveGame).downloadInstruction();
					moveGame.cleanUp();
					removeEventListener(Event.ENTER_FRAME, loop_OfficeEntrance);
					moveGame = null;
					switch(I.gGame()) {
						case 1:
							initializeShooter(I.gMode());
							break;
						case 2:
							initializePlumber(I.gMode(), I.gTarget() + 1);
							break;
						case 3:
							initializeWriter();
							break;
						default:
							break;
					}
				} else {
					moveGame.cleanUp();
					removeEventListener(Event.ENTER_FRAME, loop_OfficeEntrance);
					moveGame = null;
					initializeCredits();
				}
			}
		}
		private function initializeWriter():void {
			realignLayers();
			writeGame = new GameWriting(backgroundlayer, playerlayer, Math.ceil(SelectionMemory.WriterLevels.length * Math.random()));
			addEventListener(Event.ENTER_FRAME, loop_Writer);
			mouseLayer.alpha = 0;
			if (!SelectionMemory.soundOff) {
				SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office3.play(0, 99);
			}
		}
		private function loop_Writer(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office3.play(0, 99);
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var changes:uint = 0;
			if (!paused) {
				changes = writeGame.update(mouseX, mouseY, CLICK);
			}
			if (changes == 1) {
				writeGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_Writer);
				writeGame = null;
				mouseLayer.alpha = 1;
				SelectionMemory.sHandler.GameMusic.stop();
				if (!WON) {
					initializeOfficeExit(3);
				} else {
					initializeMenu2();
				}
			}
		}
		private function initializePlumber(boss:int = 1, target:int = 1):void {
			realignLayers();
			plumbGame = new GamePlumbing(playerlayer, backgroundlayer, hudlayer, evenBackyGroundierLayer, 0.5 + 1.5 * Math.random(), 0.2 + 0.4 * Math.random(), boss, target);
			//plumbGame = new GamePlumbing(playerlayer, backgroundlayer, hudlayer, evenBackyGroundierLayer, 5, 0, boss, target);
			addEventListener(Event.ENTER_FRAME, loop_Plumber);
			if (!SelectionMemory.soundOff) {
				SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.sewer.play(0, 99);
			}
		}
		private function loop_Plumber(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.sewer.play(0, 99);
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(DOWN) + 8 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYS) + 8 * uint(KEYD);
			}
			keys += 16 * uint(KEYZ);
			var changes:uint = 0;
			if (!paused) {
				changes = plumbGame.update(keys, mouseX, mouseY, CLICK);
			}
			if (changes >= 1) {
				var boss:int = plumbGame.getBoss();
				plumbGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_Plumber);
				plumbGame = null;
				SelectionMemory.sHandler.GameMusic.stop();
				var won:Boolean = (changes == 2)?true:false;
				if (!WON) {
					initializeOfficeExit(2, won, boss);
				} else {
					initializeMenu2();
				}
			}
		}
		private function initializeShooter(lev:int = 1, switches:Boolean = false):void {
			realignLayers();
			var match:Boolean = false;
			var counter:uint = 0;
			shootGame = new GameShooting(playerlayer, backgroundlayer, hudlayer, 100, lev, switches);
			addEventListener(Event.ENTER_FRAME, loop_Shooter);
			if (!SelectionMemory.soundOff) {
				SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.shooter.play(0, 99);
			}
		}
		private function loop_Shooter(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.shooter.play(0, 99);
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(DOWN) + 8 * uint(RIGHT);
			var altkeys:uint = 1 * uint(KEY1) + 2 * uint(KEY2) + 4 * uint(KEY3) + 8 * uint(KEYQ) + 16 * uint(KEYW) + 32 * uint(KEYE) + 64 * uint(KEYA) + 128 * uint(KEYS) + 256 * uint(KEYD) + 512 * uint(KEYZ) + 1024 * uint(KEYX) + 2048 * uint(KEYC) + 4096 * uint(KEYB) + 8192 * uint(KEYU) + 16384 * uint(KEY7);
			var changes:uint = 0;
			if (!paused) {
				changes = shootGame.update(keys, altkeys, SHIFT);
			}
			if ((changes & 1) != 1) {
				KEY1 = false;
				KEY2 = false;
				KEY3 = false;
				KEYQ = false;
				KEYW = false;
				KEYE = false;
				KEYA = false;
				KEYS = false;
				KEYD = false;
				KEYZ = false;
				KEYX = false;
				KEYC = false;
				KEYB = false;
				KEYU = false;
				KEY7 = false;
			}
			if (changes == 2) {
				shootGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_Shooter);
				shootGame = null;
				SelectionMemory.sHandler.GameMusic.stop();
				if (!WON) {
					initializeOfficeExit(1);
				} else {
					initializeMenu2();
				}
			}
		}
		private function initializeOfficeExit(game:int = 1, won:Boolean = false, mode:int = 1):void {
			realignLayers();
			moveGame = new GameOffice(backgroundlayer, playerlayer, hudlayer, true, game, won, mode);
			addEventListener(Event.ENTER_FRAME, loop_OfficeExit);
			mouseLayer.alpha = 0;
			if (!SelectionMemory.soundOff) {
				switch(SelectionMemory.day) {
					case 1:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office1.play(0, 99);
						break;
					case 2:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office2.play(0, 99);
						break;
					case 3:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office3.play(0, 99);
						break;
					case 4:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office4.play(0, 99);
						break;
				}
			}
		}
		private function loop_OfficeExit(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								switch(SelectionMemory.day) {
									case 1:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office1.play(0, 99);
										break;
									case 2:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office2.play(0, 99);
										break;
									case 3:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office3.play(0, 99);
										break;
									case 4:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.office4.play(0, 99);
										break;
								}
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYD);
			}
			var changes:int = 0;
			if (!paused) {
				changes = moveGame.update(keys, mouseX, mouseY, CLICK);
			}
			if (changes == 1) {
				SelectionMemory.sHandler.GameMusic.stop();
				mouseLayer.alpha = 1;
				moveGame.cleanUp();
				moveGame = null;
				removeEventListener(Event.ENTER_FRAME, loop_OfficeExit);
				initializeSpaceExit();
			}
		}
		private function initializeSpaceExit():void {
			realignLayers();
			spaceExit = new GameSpaceExit(backgroundlayer);
			addEventListener(Event.ENTER_FRAME, loop_SpaceExit);
		}
		private function loop_SpaceExit(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var i:int = 0;
			if (!paused) {
				i = spaceExit.update();
			}
			if (i == 1) {
				spaceExit.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_SpaceExit);
				spaceExit = null;
				initializeHouseExit();
			}
		}
		private function initializeHouseExit():void {
			realignLayers();
			moveGame = new GameHouse(backgroundlayer, playerlayer, hudlayer, true);
			addEventListener(Event.ENTER_FRAME, loop_houseExit);
			mouseLayer.alpha = 0;
			if (!SelectionMemory.soundOff) {
				switch(SelectionMemory.day) {
					case 1:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse1.play(0, 99);
						break;
					case 2:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse2.play(0, 99);
						break;
					case 3:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse3.play(0, 99);
						break;
					case 4:
						SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse4.play(0, 99);
						break;
				}
			}
		}
		private function loop_houseExit(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 0;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								switch(SelectionMemory.day) {
									case 1:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse1.play(0, 99);
										break;
									case 2:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse2.play(0, 99);
										break;
									case 3:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse3.play(0, 99);
										break;
									case 4:
										SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.happyHouse4.play(0, 99);
										break;
								}
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYD);
			}
			var changes:int = 0;
			if (!paused) {
				changes = moveGame.update(keys, mouseX, mouseY, CLICK);
			}
			if (changes == 1) {
				mouseLayer.alpha = 1;
				moveGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_houseExit);
				moveGame = null;
				SelectionMemory.sHandler.GameMusic.stop();
				initializePlacard(2);
			}
		}
		private function initializeCredits():void {
			realignLayers();
			crediGame = new GameCredits(evenBackyGroundierLayer, backgroundlayer, playerlayer);
			addEventListener(Event.ENTER_FRAME, loop_credits);
			if (!SelectionMemory.soundOff) {
				SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.theme.play(0, 99);
			}
		}
		private function loop_credits(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (!SelectionMemory.soundOff) {
								SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.theme.play(0, 99);
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(RIGHT) + 8 * uint(KEYZ);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYD) + 8 * uint(KEYZ);
			}
			var changes:int = 0;
			if (!paused) {
				changes = crediGame.update(keys, mouseX, mouseY, CLICK, UNCLICK);
			}
			CLICK = false;
			UNCLICK = false;
			if (changes == 1) {
				KEYZ = false;
				crediGame.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_credits);
				crediGame = null;
				initializeMenu2();
				SelectionMemory.sHandler.GameMusic.stop();
			}
		}
		private function initializeMenu2():void {
			realignLayers();
			WON = true;
			newMenu = new Menu2(backgroundlayer);
			mouseLayer.alpha = 0;
			KEYZ = false;
			var shared:SharedObject = SharedObject.getLocal("won");
			shared.data.won = true;
			shared.close();
			addEventListener(Event.ENTER_FRAME, loop_Menu2);
		}
		private function loop_Menu2(e:Event):void {
			var keys:uint = 1 * uint(KEYZ) + 2 * uint(KEYX) + 4 * uint(KEYC) + 8 * uint(KEYV) + 16 * uint(KEYB) + 32 * uint(KEYN) + 64 * uint(KEYA) + 128 * uint(KEYS) + 256 * uint(KEYQ) + 512 * uint(KEYM);
			if (!KEYA && !KEYS) {
				keys = 1 * uint(KEYZ) + 2 * uint(KEYX) + 4 * uint(KEYC) + 8 * uint(KEYV) + 16 * uint(KEYB) + 32 * uint(KEYN) + 64 * uint(LEFT) + 128 * uint(RIGHT) + 256 * uint(KEYQ) + 512 * uint(KEYM);;
			}
			KEYZ = false;
			KEYX = false;
			KEYC = false;
			KEYV = false;
			KEYB = false;
			KEYN = false;
			KEYA = false;
			KEYS = false;
			KEYQ = false;
			LEFT = false;
			RIGHT = false;
			var changes:int = newMenu.update(keys);
			if (changes != 0) {
				newMenu.cleanUp();
				mouseLayer.alpha = 1;
				removeEventListener(Event.ENTER_FRAME, loop_Menu2);
				newMenu = null;
				var i:int = Math.floor(SelectionMemory.ShooterLevels.length * Math.random());
				var mode:int = SelectionMemory.ShooterLevels[i];
				SelectionMemory.ShooterLevels.splice(i, 1);
				switch(changes) {
					case 13:
						resetEverything();
						initializeCredits();
						break;
					case 11:
						resetEverything();
						initializeShooter(mode, true);
						break;
					case 10:
						resetEverything();
						initializeShooter(mode);
						break;
					case 9:
						resetEverything();
						initializeWriter();
						break;
					case 8:
						resetEverything();
						initializeBossRush();
						break;
					case 7:
					case 6:
					case 5:
					case 4:
					case 3:
					case 2:
						resetEverything();
						initializeBossRush(changes - 1, 1, true);
						break;
					default:
						WON = false;
						resetEverything();
						initializePlacard(3);
						break;
				}
			}
		}
		private function initializeBossRush(BNUM:int = 1, health:int = 1, termAfter:Boolean = false):void {
			realignLayers();
			bossRush = new GamePlumbingPlus(playerlayer, backgroundlayer, hudlayer, evenBackyGroundierLayer, 5, 0, BNUM, health);
			addEventListener(Event.ENTER_FRAME, loop_BossRush);
			if (!SelectionMemory.soundOff && BNUM == 1) {
				SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.sewer.play(0, 999);
			}
		}
		private function loop_BossRush(e:Event):void {
			if (KEYP) {
				KEYP = false;
				if (paused) {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 0;
					paused = false;
				} else {
					mouseLayer.alpha = 1;
					pauseButton.alpha = 1;
					paused = true;
				}
			}
			if (paused) {
				if (CLICK) {
					if (mouseY > 165 && mouseY < 185) {
						if (mouseX < 240) {
							SelectionMemory.quality = 1;
							stage.quality = "high";
							pauseButton.gotoAndStop(1 + SelectionMemory.soundOff);
						} else if (mouseX > 320) {
							SelectionMemory.quality = 5;
							stage.quality = "low";
							pauseButton.gotoAndStop(5 + SelectionMemory.soundOff);
						} else {
							SelectionMemory.quality = 3;
							stage.quality = "medium";
							pauseButton.gotoAndStop(3 + SelectionMemory.soundOff);
						}
					} else if (mouseY > 190 && mouseY < 210) {
						if (mouseX < 275) {
							if (SelectionMemory.soundOff) {
								SelectionMemory.sHandler.GameMusic = SelectionMemory.sHandler.sewer.play(0, 99);
							}
							SelectionMemory.soundOff = false;
							pauseButton.gotoAndStop(SelectionMemory.quality);
						} else {
							SelectionMemory.soundOff = true;
							SelectionMemory.sHandler.GameMusic.stop();
							pauseButton.gotoAndStop(SelectionMemory.quality + 1);
						}
					}
				}
			}
			var keys:uint = 1 * uint(UP) + 2 * uint(LEFT) + 4 * uint(DOWN) + 8 * uint(RIGHT);
			if (keys == 0) {
				keys = 1 * uint(KEYW) + 2 * uint(KEYA) + 4 * uint(KEYS) + 8 * uint(KEYD);
			}
			keys += 16 * uint(KEYZ);
			var changes:uint = 0;
			if (!paused) {
				changes = bossRush.update(keys, mouseX, mouseY, CLICK);
			}
			if (changes >= 1) {
				var boss:int = bossRush.getBoss() + 1;
				var HP:int = bossRush.getHP();
				var donMovOn:Boolean = bossRush.justOneRound;
				bossRush.cleanUp();
				removeEventListener(Event.ENTER_FRAME, loop_BossRush);
				bossRush = null;
				var won:Boolean = (changes == 2)?true:false;
				if (won && !donMovOn) {
					if (boss < 7) {
						initializeBossRush(boss, HP);
					} else {
						SelectionMemory.sHandler.GameMusic.stop();
						initializeMenu2();
					}
				} else {
					SelectionMemory.sHandler.GameMusic.stop();
					initializeMenu2();
				}
			}
		}
	}
}