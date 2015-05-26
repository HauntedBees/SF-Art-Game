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
	public class GameOffice extends GamePlatformer {
		private var secretary:MovieClip;
		private var instructions:MovieClip;
		private var hateStructions:MovieClip;
		private var nextgame:InstructionSet;
		private var storedText:String;
		private var counter:Number;
		private var behindDoor:int;
		private var jumpCount:int;
		private var fadeToBlack:Boolean;
		private var black:Sprite;
		private var blood:Sprite;
		private var cop1:MovieClip;
		private var cop2:MovieClip;
		private var timer:int;
		public function GameOffice(bg:DisplayObjectContainer, np:DisplayObjectContainer, pl:DisplayObjectContainer, exiting:Boolean = false, game:int = 1, won:Boolean = true, mode:int = 1) {
			super(bg, np, pl);
			wayBackground = new officeX();
			wayBackground.x += wayBackground.width / 2;
			wayBackground.y += wayBackground.height / 2;
			background = new office();
			background.x += background.width / 2;
			background.y += background.height / 2;
			foreground = new officeD();
			foreground.x += foreground.width / 2;
			foreground.y += foreground.height / 2;
			player.y = 175;
			player.x = 15;
			timer = 0;
			if (SelectionMemory.day != 5) {
				_backgroundLayer.addChild(background);
				_backgroundLayer.addChild(pan);
				_backgroundLayer.addChild(wayBackground);
				wayBackground.mask = pan;
				wayBackground.gotoAndStop(1);
				_darkBackgroundLayer.addChild(foreground);
				secretary = new stry();
				secretary.y += 175;
				fadeToBlack = false;
				behindDoor = -1;
				counter = 1;
				jumpCount = 0;
				_backgroundLayer.addChild(secretary);
				instructions = new officewords();
				background.addChild(instructions);
				instructions.y = -30;
				instructions.dialogue.text = "\n \n Kill yourself.";
				hateStructions = new officewords();
				wayBackground.addChild(hateStructions);
				hateStructions.y = -30;
				hateStructions.dialogue.text = "\n \n I'm not sure if I should kill HIM or just kill MYSELF...";
			} else {
				_backgroundLayer.addChild(wayBackground);
				blood = new bloodsplatter();
				wayBackground.gotoAndStop(2);
				blood.y += 175 - blood.height / 2 + 15;
				blood.x = 240;
				_backgroundLayer.addChild(blood);
				secretary = new desk();
				secretary.y += 175;
				secretary.x = 310;
				_backgroundLayer.addChild(secretary);
				cop1 = new cLook();
				cop1.y += 178;
				cop1.x = 230;
				cop1.gotoAndStop(1);
				_backgroundLayer.addChild(cop1);
				cop2 = new cClean();
				cop2.y += 175;
				cop2.x = 180;
				cop2.gotoAndStop(1);
				_backgroundLayer.addChild(cop2);
			}
			collisions = new collide3();
			collisions.x += wayBackground.width / 2;
			collisions.y += wayBackground.height / 2;
			_backgroundLayer.addChild(collisions);
			collisions.alpha = 0;
			if (exiting) {
				collisions.scaleX = -1;
				background.scaleX = -1;
				wayBackground.scaleX = -1;
				foreground.scaleX = -1;
				secretary.scaleX = -1;
				secretary.x = 172 + secretary.width / 2;
				instructions.x = background.width / 2 - 282;
				instructions.scaleX = -1;
				hateStructions.x = wayBackground.width / 2 - 282;
				hateStructions.scaleX = -1;
				hateStructions.dialogue.text = "\n \n Good riddance, you bastard.";
				switch(game) {
					case 1:
						storedText = "\n Great work today. Its a shame our clients never come back after we do business with them.";
						break;
					case 2:
						if (won) {
							storedText = "\n Good job today. You always were a good problem solver.";
						} else {
							storedText = "\n Whatever, we can't win them all. I'm not going to get mad at you - the boss is already mad enough for 3 people.";
						}
						break;
					case 3:
						storedText = "\n Fun day, huh? I'm sure we'll have something more interesting to do tomorrow.";
						break;
				}
			} else {
				if (SelectionMemory.day != 5) {
					instructions.x = -42;
					hateStructions.x = -42;
					secretary.x += 287;
					decideNextGame();
				}
			}
		}
		protected override function otherThings(keys:uint, mouseX:int, mouseY:int):int {
			if (SelectionMemory.day != 5) {
				if (counter < storedText.length + 1) {
					var s:String = storedText.slice(0, Math.ceil(counter));
					counter += 0.5;
					instructions.dialogue.text = s;
					if (counter % 4 == 0) {
						if (!SelectionMemory.soundOff) {
							SelectionMemory.sHandler.typewriter.play();
						}
					}
				} else {
					if (jumping) {
						jumpCount += 1;
					}
					if (jumpCount > 150) {
						storedText = "\n \n Stop fucking jumping around like an idiot.";
						counter = 0;
						jumpCount = 0;
					}
					if (player.x > 40) {
						behindDoor = 0;
					} else {
						if (behindDoor >= 0) {
							behindDoor += 1;
						}
						if (behindDoor > 150) {
							storedText = "\n \n You're going the wrong way.";
							counter = 0;
							behindDoor = -1;
						}
					}
				}
			} else {
				if (player.x > 230) {
					cop2.gotoAndStop(3);
					cop1.gotoAndStop(3);
				} else if (player.x > 100) {
					cop2.gotoAndStop(2);
					cop1.gotoAndStop(2);
				}
			}
			if (player.x > 460) {
				if (!fadeToBlack) {
					haltControl = true;
					fadeToBlack = true;
					black = new starryeyes();
					black.y = 120;
					black.x = 480 + black.width / 2;
					_playerLightLayer.addChild(black);
				}
			}
			if (fadeToBlack) {
				player.x += 2;
				if (black.x > -100) {
					black.x -= 10;
				} else {
					return 1;
				}
			}
			return 0;
		}
		public override function cleanUp():void {
			if (SelectionMemory.day != 5) {
				background.removeChild(instructions);
				wayBackground.removeChild(hateStructions);
				_darkBackgroundLayer.removeChild(foreground);
				_backgroundLayer.removeChild(background);
				_backgroundLayer.removeChild(pan);
				_backgroundLayer.mask = null;
				_backgroundLayer.removeChild(secretary);
				_playerLightLayer.removeChild(light);
				_playerLightLayer.removeChild(eye);
			} else {
				_backgroundLayer.removeChild(secretary);
				_backgroundLayer.removeChild(blood);
				_backgroundLayer.removeChild(cop1);
				_backgroundLayer.removeChild(cop2);
			}
			_backgroundLayer.removeChild(wayBackground);
			_backgroundLayer.removeChild(collisions);
			_playerLightLayer.removeChild(player);
			eye = null;
			player = null;
			light = null;
			pan = null;
			wayBackground = null;
			foreground = null;
			collisions = null;
			background = null;
			secretary = null;
			instructions = null;
			hateStructions = null;
			nextgame = null;
			storedText = "";
			_playerLightLayer.removeChild(black);
			black = null;
		}
		public function downloadInstruction():InstructionSet {
			return nextgame;
		}
		private function decideNextGame():void {
			if (SelectionMemory.gamesPlayed.length == 0) {
				var i:Number = Math.random();
				if (i < 0.5) {
					nextgame = new InstructionSet(1);
					SelectionMemory.gamesPlayed.push(1);
				} else {
					nextgame = new InstructionSet(2);
					SelectionMemory.gamesPlayed.push(2);
				}
			} else {
				var j:int = Math.ceil(Math.random() * 3);
				if (SelectionMemory.gamesPlayed[SelectionMemory.gamesPlayed.length - 1] == j) {
					j -= 1;
					if (j == 0) { j = 3; }
				}
				nextgame = new InstructionSet(j);
				SelectionMemory.gamesPlayed.push(j);
			}
			if (nextgame.gGame() == 2) {
				switch(nextgame.gMode()) {
					case 1:
						storedText = PeopleParser.game2Names[nextgame.gTarget()] + " is starting to feel emotions. Get rid of that nonsense before the other employees start thinking they're allowed to feel.";
						break;
					case 2:
						storedText = PeopleParser.game2Names[nextgame.gTarget()] + " is asking foolish questions like \"What's the point of working here?\" and \"Why should I waste my time with paperwork?\" Fix that.";
						break;
					case 3:
						storedText = "I'm sensing a lot of pent-up anger coming from " + PeopleParser.game2Names[nextgame.gTarget()] + "'s cubicle. It'd probably be best to fix that before it leads to problems.";
						break;
					case 4:
						storedText = PeopleParser.game2Names[nextgame.gTarget()] + " recently entered a relationship. We don't want things like love interfering with the job, do we? Why don't you two talk it over?";
						break;
					case 5:
						storedText = "It looks like " + PeopleParser.game2Names[nextgame.gTarget()] + " found God. This job is the only god anyone around here should be worshipping. An exorcism is necessary.";
						break;
					case 6:
						storedText = "\n \n Kill yourself.";
						break;
					default:
						storedText = "\n \n I don't know WHAT'S going on in there. The error number is B00" + nextgame.gMode() + ".";
						break;
				}
			} else if (nextgame.gGame() == 1) {
				storedText = "\n \n Your client today is " + PeopleParser.target + ". Take care.";
			} else {
				storedText = "\n \n Just paperwork today, sir.";
			}
		}
	}
}