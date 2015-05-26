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
	public class GameCredits {
		private const censored:Boolean = false;
		private var _xgLayer:DisplayObjectContainer;
		private var _bgLayer:DisplayObjectContainer;
		private var _plLayer:DisplayObjectContainer;
		private var shaftback:Sprite;
		private var shaftfront:Sprite;
		private var letters:Array;
		private var row:int;
		private var rowTimer:int;
		private var player:CreditsPlayer;
		private var velSpeed:Number;
		private var cops:Array;
		private var ended:Boolean;
		private var pressZ:Sprite;
		private var gameOver:MovieClip;
		private var dead:Boolean;
		public function GameCredits(bbg:DisplayObjectContainer, bg:DisplayObjectContainer, pl:DisplayObjectContainer) {
			_xgLayer = bbg;
			_bgLayer = bg;
			_plLayer = pl;
			letters = [];
			cops = [];
			row = 0;
			rowTimer = 0;
			velSpeed = 1;
			shaftback = new shaftB();
			shaftback.x = 240;
			shaftback.y = 560;
			_xgLayer.addChild(shaftback);
			shaftfront = new shaftA();
			shaftfront.x = 240;
			shaftfront.y = 600;
			_xgLayer.addChild(shaftfront);
			ended = false;
			player = new CreditsPlayer(_plLayer, _bgLayer, 240, 30);
			pressZ = new zbutton();
			pressZ.x = 480 + pressZ.width / 2;
			pressZ.y = 240 - pressZ.height / 2;
			_plLayer.addChild(pressZ);
			gameOver = new gameover();
			gameOver.gotoAndStop(1);
			gameOver.x = -gameOver.width;
			gameOver.y = gameOver.height / 2;
			_plLayer.addChild(gameOver);
			dead = false;
		}
		public function cleanUp():void {
			for each(var c:CreditsCop in cops) {
				c.cleanUp();
			}
			for each(var a:MovieClip in letters) {
				removeLayers(a);
			}
			cops = [];
			letters = [];
			_plLayer.removeChild(gameOver);
			gameOver = null;
			_plLayer.removeChild(pressZ);
			pressZ = null;
			player.cleanUp();
			player = null;
			_xgLayer.removeChild(shaftback);
			_xgLayer.removeChild(shaftfront);
			shaftfront = null;
			shaftback = null;
		}
		public function update(keys:uint, mouseX:int, mouseY:int, clicked:Boolean, unclicked:Boolean):int {
			if (!dead && row < 95) {
				player.getKeys(keys);
				if (player.icon.y < -100) {
					gameOver.gotoAndStop(2);
					gameOver.x = -gameOver.width;
					dead = true;
				} else if (player.icon.y > 500) {
					gameOver.gotoAndStop(1);
					gameOver.x = -gameOver.width;
					dead = true;
				} else if (player.arrested) {
					gameOver.gotoAndStop(3);
					gameOver.x = -gameOver.width;
					dead = true;
				}
			} else if (dead && gameOver.x  < gameOver.width / 2) {
				gameOver.x += 4;
			} else if (dead && gameOver.alpha > 0) {
				gameOver.alpha -= 0.015;
			} else if (row > 95) {
				player.icon.alpha = 0;
			}
			if (player.arrested) {
				player.icon.x += player.icon.scaleX * 4;
			}
			shaftfront.y -= 0.24;
			shaftback.y -= 0.2;
			if (ended && pressZ.x > (480 - pressZ.width / 2)) {
				pressZ.x -= 4;
			} else if (ended && (keys & 8)) {
				return 1;
			} else if (dead && row < 92 && (keys & 8)) {
				row = 92;
				addNewRow();
			}
			for each(var c:CreditsCop in cops) {
				var b:int = c.processCommands(player, mouseX, mouseY);
				if (b == 1 || c.icon.y < -500) {
					var R:int = cops.indexOf(c);
					cops.splice(R, 1);
					c.cleanUp();
				}
			}
			if (rowTimer <= 0 && !ended) {
				rowTimer = 40;
				addNewRow();
			}
			rowTimer -= 1;
			for each(var a:MovieClip in letters) {
				a.y -= velSpeed;
				if (clicked && a.hitTestPoint(mouseX, mouseY, true)) {
					swapLayers(a);
					var f:int = (a.currentFrame == 2)?1:2;
					a.gotoAndStop(f);
				}
				if (a.y < -500) {
					removeLayers(a);
					var A:int = letters.indexOf(a);
					letters.splice(A, 1);
				}
			}
			if (Math.random() > 0.985 && !ended && row < 90) {
				var C:CreditsCop;
				var cS:int = Math.ceil(4 * Math.random());
				switch(cS) {
					case 3:
						C = new CreditsCop(_plLayer, _bgLayer, 10, 120 * Math.random());
						break;
					case 2:
						C = new CreditsCop(_plLayer, _bgLayer, 470, 120 * Math.random());
						break;
					default:
						C = new CreditsCop(_plLayer, _bgLayer, 480 * Math.random(), 10);
						break;
				}
				C.icon.gotoAndStop(3);
				cops.push(C);
			}
			return 0;
		}
		private function removeLayers(a:MovieClip):void {
			if (a.currentFrame == 1) {
				_bgLayer.removeChild(a);
			} else {
				_xgLayer.removeChild(a);
			}
		}
		private function swapLayers(a:MovieClip):void {
			if (a.currentFrame == 1) {
				_bgLayer.removeChild(a);
				_xgLayer.addChild(a);
			} else {
				_xgLayer.removeChild(a);
				_bgLayer.addChild(a);
			}
		}
		private function addNewRow():void {
			row += 1;
			switch(row) {
				case 1:
					if (censored) {
						addChildren([word("hello", 152.45), word("my", 224.45), word("name", 288.45), word("is", 353.45)]);
					} else {
						addChildren([word("shitty", 104.45), word("fucking", 224.45), word("art", 320.45), word("game", 392.45)]);
					}
					break;
				case 2:
					if (censored) {
						addChildren([word("pseudo", 240.45)]);
					} else {
						addChildren([word("meaningful", 88.45), word("subtitle", 248.45), word("goes", 360.45), word("here", 440.45)]);
					}
					break;
				case 3:
					addChildren([word("credits", 240.45)]);
					break;
				case 4:
					addChildren([word("--", 240.45)]);
					break;
				case 5:
					addChildren([word("programming", 168.45)]);
					break;
				case 6:
					commonUse(1);
					break;
				case 7:
					addChildren([word("game", 112.45), word("design", 209.45)]);
					break;
				case 8:
					commonUse(1);
					break;
				case 9:
					addChildren([word("artwork", 136.45), word("and", 232.45), word("animation", 345.45)]);
					break;
				case 10:
					commonUse(1);
					break;
				case 11:
					addChildren([word("ld", 80.45), word("worldflippy", 264.45)]);
					break;
				case 12:
					addChildren([word("turnaroundy", 88.45), word("engine", 240.45), word("development", 392.45)]);
					break;
				case 13:
					commonUse(1);
					break;
				case 14:
					commonUse(2);
					break;
				case 15:
					addChildren([word("emanuele", 144.45), word("feronato", 288.45)]);
					break;
				case 16:
					addChildren([word("math", 168.45), word("help", 304.45)]);
					break;
				case 17:
					commonUse(3);
					break;
				case 18:
					addChildren([word("jakob", 120.45), word("bernoulli", 247.45)]);
					break;
				case 19:
					addChildren([word("camille", 224.45), word("gerono", 432.45)]);
					break;
				case 20:
					addChildren([word("voices", 128.45)]);
					break;
				case 21:
					commonUse(1);
					break;
				case 22:
					addChildren([word("street", 128.45), word("fighter", 248.45), word("3", 328.45)]);
					break;
				case 23:
					addChildren([word("sound", 120.45), word("effects", 232.45)]);
					break;
				case 24:
					commonUse(1);
					break;
				case 25:
					addChildren([word("music", 120.45)]);
					break;
				case 26:
					commonUse(3);
					break;
				case 27:
					addChildren([word("the", 91.45), word("reading", 187.45), word("books", 299.45), word("club", 386.45)]);
					break;
				case 28:
					commonUse(4);
					break;
				case 29:
					commonUse(5);
					break;
				case 30:
					commonUse(6);
					break;
				case 31:
					commonUse(7);
					break;
				case 32:
					commonUse(8);
					break;
				case 33:
					commonUse(9);
					break;
				case 34:
					addChildren([word("misc", 112.45), word("assistance", 240.45)]);
					break;
				case 35:
					commonUse(2);
					break;
				case 36:
					commonUse(3);
					break;
				case 37:
					commonUse(10);
					break;
				case 38:
					commonUse(11);
					break;
				case 39:
					addChildren([word("quotes", 240)]);
					break;
				case 40:
					addChildren([word("e", 43.45), word("m", 91.45), word("cioran", 173.45)]);
					break;
				case 41:
					addChildren([word("simone", 220.45), word("de", 300.45), word("beauvoir", 396.45)]);
					break;
				case 42:
					addChildren([word("james", 48.45), word("f", 119.45), word("t", 167.45), word("bugental", 264.45)]);
					break;
				case 43:
					addChildren([word("franz", 339.45), word("kafka", 434.45)]);
					break;
				case 44:
					addChildren([word("friedrich", 118.45), word("niezsche", 270.45)]);
					break;
				case 45:
					addChildren([word("robert", 52.45), word("frost", 156.45)]);
					break;
				case 46:
					addChildren([word("the", 316.45), word("killers", 412.45)]);
					break;
				case 47:
					addChildren([word("tyler", 114.45), word("durden", 219.45)]);
					break;
				case 48:
					addChildren([word("bob", 290.45), word("marley", 378.45)]);
					break;
				case 49:
					addChildren([word("john", 191.45), word("lennon", 287.45)]);
					break;
				case 50:
					addChildren([word("siddhartha", 86.45), word("gautama", 238.45), word("buddha", 358.45)]);
					break;
				case 51:
					addChildren([word("mohandas", 298.45), word("gandhi", 425.45)]);
					break;
				case 52:
					addChildren([word("bob", 44.45), word("dylan", 125.45)]);
					break;
				case 53:
					addChildren([word("led", 268.45), word("zeppelin", 373.45)]);
					break;
				case 54:
					addChildren([word("unknown", 233.45)]);
					break;
				case 55:
					addChildren([word("jimi", 93.45), word("hendrix", 198.45)]);
					break;
				case 56:
					addChildren([word("joni", 265.45), word("mitchell", 378.45)]);
					break;
				case 57:
					addChildren([word("m", 109.45), word("c", 157.45), word("escher", 238.45)]);
					break;
				case 58:
					addChildren([word("pablo", 44.45), word("picasso", 156.45)]);
					break;
				case 59:
					addChildren([word("michelangelo", 380.45)]);
					break;
				case 60:
					addChildren([word("kesha", 170.45), word("sebert", 274.45)]);
					break;
				case 61:
					addChildren([word("jules", 82.45), word("winnfried", 210.45)]);
					break;
				case 62:
					addChildren([word("fyodor", 60.45), word("dostoevsky", 204.45)]);
					break;
				case 63:
					addChildren([word("james", 243.45), word("j", 313.45), word("gibson", 395.45)]);
					break;
				case 64:
					addChildren([word("corazon", 91.45), word("aquino", 210.45)]);
					break;
				case 65:
					addChildren([word("albert", 190.45), word("einstein", 319.45)]);
					break;
				case 66:
					addChildren([word("william", 59.45), word("shakespeare", 218.45)]);
					break;
				case 67:
					addChildren([word("benjamin", 257.45), word("franklin", 401.45)]);
					break;
				case 68:
					addChildren([word("confucious", 332.45)]);
					break;
				case 69:
					addChildren([word("vince", 52.45), word("lombardi", 171.45)]);
					break;
				case 70:
					addChildren([word("oscar", 302.45), word("wilde", 398.45)]);
					break;
				case 71:
					addChildren([word("mark", 56.45), word("twain", 145.45)]);
					break;
				case 72:
					addChildren([word("thomas", 302.45), word("edison", 415.45)]);
					break;
				case 73:
					addChildren([word("publius", 130.45), word("syrus", 242.45)]);
					break;
				case 74:
					addChildren([word("socrates", 318.45)]);
					break;
				case 75:
					addChildren([word("robert", 57.45), word("ingersoll", 193.45)]);
					break;
				case 76:
					addChildren([word("hermann", 311.45), word("hesse", 422.45)]);
					break;
				case 77:
					addChildren([word("grace", 190.45), word("hansen", 295.45)]);
					break;
				case 78:
					addChildren([word("anaias", 166.45), word("nin", 255.45)]);
					break;
				case 79:
					addChildren([word("duke", 276.45), word("nukem", 365.45)]);
					break;
				case 80:
					addChildren([word("jesus", 110.45), word("christ", 214.45), word("of", 294.45), word("nazareth", 390.45)]);
					break;
				case 81:
					addChildren([word("reese", 82.45), word("roper", 178.45)]);
					break;
				case 82:
					addChildren([word("george", 260.45), word("santayana", 396.45)]);
					break;
				case 83:
					addChildren([word("beta", 239.45)]);
					break;
				case 84:
					commonUse(1);
					break;
				case 85:
					commonUse(2);
					break;
				case 86:
					commonUse(10);
					break;
				case 87:
					addChildren([word("programs", 153.45), word("used", 265.45)]);
					break;
				case 88:
					addChildren([word("microsoft", 181.45), word("paint", 309.45)]);
					break;
				case 89:
					addChildren([word("flashdevelop", 192.45)]);
					break;
				case 90:
					addChildren([word("adobe", 189.45), word("flash", 285.45), word("cs5", 365.45)]);
					break;
				case 91:
					addChildren([word("sfxr", 201.45)]);
					break;
				case 94:
					allDoseHamboigahs();
					break;
				case 98:
					addChildren([word("coincidence", 239.45, 310)]);
					break;
				case 105:
					addChildren([word("end", 240, 500)]);
					break;
			}
			if (row >= 100 && row <= 108) {
				velSpeed -= 0.05;
			} else if (row == 139) {
				velSpeed = 0;
				ended = true;
			}
		}
		private function allDoseHamboigahs():void {
			var allDose:MovieClip = new allDosePeople();
			_bgLayer.addChild(allDose);
			allDose.x = 240;
			allDose.y = 300;
			allDose.words.text = "ALL THE PEOPLE YOU KILLED \n \n Sean Finch";
			for each(var S:String in PeopleParser.victims) {
				allDose.words.text += ", " + S;
			}
			letters.push(allDose);
		}
		/**
		 * Commonly used word combinations, like names. Actually, it's probably just going to be names.
		 */
		private function commonUse(s:int):void {
			switch(s) {
				case 11:
					addChildren([word("sandy", 120.45)]);
					break;
				case 10:
					addChildren([word("ben", 137.45)]);
					break;
				case 9:
					addChildren([word("mary", 387.45)]);
					break;
				case 8:
					addChildren([word("ekli", 99.45)]);
					break;
				case 7:
					addChildren([word("ed", 402.45)]);
					break;
				case 6:
					addChildren([word("dagg", 99.45)]);
					break;
				case 5:
					addChildren([word("spawtaw", 362.45)]);
					break;
				case 4:
					addChildren([word("brad", 99.45)]);
					break;
				case 3:
					addChildren([word("macho", 120.45)]);
					break;
				case 2:
					addChildren([word("mary", 112.45)]);
					break;
				default:
					addChildren([word("sean", 113.45), word("finch", 200.45)]);
					break;
			}
		}
		private function addChildren(boots:Array):void {
			for each(var e:MovieClip in boots) {
				var f:int = (Math.random() < 0.85)?1:2;
				if (row <= 2) {
					f = 1;
				}
				e.gotoAndStop(f);
				if(f==1){
					_bgLayer.addChild(e);
				} else {
					_xgLayer.addChild(e);
				}
			}
		}
		private function word(s:String, dX:int, dY:int = 300):MovieClip {
			var m:MovieClip;
			switch (s) {
				case "hello":
					m = new c_hello();
					break;
				case "my":
					m = new c_my();
					break;
				case "name":
					m = new c_name();
					break;
				case "is":
					m = new c_is();
					break;
				case "pseudo":
					m = new c_pseudo();
					break;
				case "shitty":
					m = new c_shitty();
					break;
				case "fucking":
					m = new c_fucking();
					break;
				case "art":
					m = new c_art();
					break;
				case "game":
					m = new c_game();
					break;
				case "meaningful":
					m = new c_meaningful();
					break;
				case "subtitle":
					m = new c_subtitle();
					break;
				case "goes":
					m = new c_goes();
					break;
				case "here":
					m = new c_here();
					break;
				case "credits":
					m = new c_credits();
					break;
				case "--":
					m = new c_bar1();
					break;
				case "programming":
					m = new c_programming();
					break;
				case "sean":
					m = new c_sean();
					break;
				case "finch":
					m = new c_finch();
					break;
				case "design":
					m = new c_design();
					break;
				case "and":
					m = new c_and();
					break;
				case "animation":
					m = new c_animation();
					break;
				case "artwork":
					m = new c_artwork();
					break;
				case "ld":
					m = new c_ld();
					break;
				case "worldflippy":
					m = new c_worldflippy();
					break;
				case "turnaroundy":
					m = new c_turnaroundy();
					break;
				case "development":
					m = new c_development();
					break;
				case "engine":
					m = new c_engine();
					break;
				case "mary":
					m = new c_mary();
					break;
				case "emanuele":
					m = new c_emanuele();
					break;
				case "feronato":
					m = new c_feronato();
					break;
				case "music":
					m = new c_music();
					break;
				case "effects":
					m = new c_effects();
					break;
				case "sound":
					m = new c_sound();
					break;
				case "3":
					m = new c_3();
					break;
				case "fighter":
					m = new c_fighter();
					break;
				case "street":
					m = new c_street();
					break;
				case "math":
					m = new c_math();
					break;
				case "help":
					m = new c_help();
					break;
				case "macho":
					m = new c_macho();
					break;
				case "jakob":
					m = new c_jakob();
					break;
				case "bernoulli":
					m = new c_bernoulli();
					break;
				case "camille":
					m = new c_camille();
					break;
				case "gerono":
					m = new c_gerono();
					break;
				case "voices":
					m = new c_voices();
					break;
				case "the":
					m = new c_the();
					break;
				case "reading":
					m = new c_reading();
					break;
				case "books":
					m = new c_books();
					break;
				case "club":
					m = new c_club();
					break;
				case "brad":
					m = new c_brad();
					break;
				case "spawtaw":
					m = new c_spawtaw();
					break;
				case "dagg":
					m = new c_dagg();
					break;
				case "ed":
					m = new c_ed();
					break;
				case "ekli":
					m = new c_ekli();
					break;
				case "misc":
					m = new c_misc();
					break;
				case "assistance":
					m = new c_assistance();
					break;
				case "ben":
					m = new c_ben();
					break;
				case "sandy":
					m = new c_sandy();
					break;
				case "quotes":
					m = new c_quotes();
					break;
				case "e":
					m = new c_e();
					break;
				case "m":
					m = new c_m();
					break;
				case "cioran":
					m = new c_cioran();
					break;
				case "simone":
					m = new c_simone();
					break;
				case "de":
					m = new c_de();
					break;
				case "beauvoir":
					m = new c_beauvoir();
					break;
				case "james":
					m = new c_james();
					break;
				case "f":
					m = new c_f();
					break;
				case "t":
					m = new c_t();
					break;
				case "bugental":
					m = new c_bugental();
					break;
				case "franz":
					m = new c_franz();
					break;
				case "kafka":
					m = new c_kafka();
					break;
				case "friedrich":
					m = new c_friedrich();
					break;
				case "niezsche":
					m = new c_nietzche();
					break;
				case "robert":
					m = new c_robert();
					break;
				case "frost":
					m = new c_frost();
					break;
				case "killers":
					m = new c_killers();
					break;
				case "tyler":
					m = new c_tyler();
					break;
				case "durden":
					m = new c_durden();
					break;
				case "bob":
					m = new c_bob();
					break;
				case "marley":
					m = new c_marley();
					break;
				case "john":
					m = new c_john();
					break;
				case "lennon":
					m = new c_lennon();
					break;
				case "siddhartha":
					m = new c_siddhartha();
					break;
				case "gautama":
					m = new c_gautama();
					break;
				case "buddha":
					m = new c_buddha();
					break;
				case "mohandas":
					m = new c_mohandas();
					break;
				case "gandhi":
					m = new c_gandhi();
					break;
				case "dylan":
					m = new c_dylan();
					break;
				case "led":
					m = new c_led();
					break;
				case "zeppelin":
					m = new c_zeppelin();
					break;
				case "unknown":
					m = new c_unknown();
					break;
				case "jimi":
					m = new c_jimi();
					break;
				case "hendrix":
					m = new c_hendrix();
					break;
				case "joni":
					m = new c_joni();
					break;
				case "mitchell":
					m = new c_mitchell();
					break;
				case "c":
					m = new c_c();
					break;
				case "escher":
					m = new c_escher();
					break;
				case "pablo":
					m = new c_pablo();
					break;
				case "picasso":
					m = new c_picasso();
					break;
				case "michelangelo":
					m = new c_michelangelo();
					break;
				case "kesha":
					m = new c_kesha();
					break;
				case "sebert":
					m = new c_sebert();
					break;
				case "jules":
					m = new c_jules();
					break;
				case "winnfried":
					m = new c_winnfried();
					break;
				case "fyodor":
					m = new c_fyodor();
					break;
				case "dostoevsky":
					m = new c_dostoevsky();
					break;
				case "j":
					m = new c_j();
					break;
				case "gibson":
					m = new c_gibson();
					break;
				case "corazon":
					m = new c_corazon();
					break;
				case "aquino":
					m = new c_aquino();
					break;
				case "albert":
					m = new c_albert();
					break;
				case "einstein":
					m = new c_einstein();
					break;
				case "william":
					m = new c_william();
					break;
				case "shakespeare":
					m = new c_shakespeare();
					break;
				case "benjamin":
					m = new c_benjamin();
					break;
				case "franklin":
					m = new c_franklin();
					break;
				case "confucious":
					m = new c_confucious();
					break;
				case "vince":
					m = new c_vince();
					break;
				case "lombardi":
					m = new c_lombardi();
					break;
				case "oscar":
					m = new c_oscar();
					break;
				case "wilde":
					m = new c_wilde();
					break;
				case "mark":
					m = new c_mark();
					break;
				case "twain":
					m = new c_twain();
					break;
				case "thomas":
					m = new c_thomas();
					break;
				case "edison":
					m = new c_edison();
					break;
				case "publius":
					m = new c_publius();
					break;
				case "syrus":
					m = new c_syrus();
					break;
				case "socrates":
					m = new c_socrates();
					break;
				case "ingersoll":
					m = new c_ingersoll();
					break;
				case "hermann":
					m = new c_hermann();
					break;
				case "hesse":
					m = new c_hesse();
					break;
				case "grace":
					m = new c_grace();
					break;
				case "hansen":
					m = new c_hansen();
					break;
				case "anaias":
					m = new c_anaias();
					break;
				case "nin":
					m = new c_nin();
					break;
				case "duke":
					m = new c_duke();
					break;
				case "nukem":
					m = new c_nukem();
					break;
				case "jesus":
					m = new c_jesus();
					break;
				case "christ":
					m = new c_christ();
					break;
				case "of":
					m = new c_of();
					break;
				case "nazareth":
					m = new c_nazareth();
					break;
				case "reese":
					m = new c_reese();
					break;
				case "roper":
					m = new c_roper();
					break;
				case "george":
					m = new c_george();
					break;
				case "santayana":
					m = new c_santayana();
					break;
				case "beta":
					m = new c_beta();
					break;
				case "programs":
					m = new c_programs();
					break;
				case "used":
					m = new c_used();
					break;
				case "microsoft":
					m = new c_microsoft();
					break;
				case "paint":
					m = new c_paint();
					break;
				case "flashdevelop":
					m = new c_flashdevelop();
					break;
				case "adobe":
					m = new c_adobe();
					break;
				case "flash":
					m = new c_flash();
					break;
				case "cs5":
					m = new c_cs5();
					break;
				case "sfxr":
					m = new c_sfxr();
					break;
				case "coincidence":
					m = new c_coincidence();
					break;
				case "end":
					m = new c_end();
					break;
				default:
					m = new c_hello();
					break;
			}
			m.x = dX;
			m.y = dY;
			letters.push(m);
			return m;
		}
	}
}