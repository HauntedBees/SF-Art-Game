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
	public class GameSpaceExit {
		private var layer:DisplayObjectContainer;
		private var bg:Sprite;
		private var ship:MovieClip;
		private var textes:MovieClip;
		private var blackfade:Sprite;
		public function GameSpaceExit(l:DisplayObjectContainer) {
			layer = l;
			bg = new shipreturn();
			bg.x += bg.width / 2;
			bg.y += bg.height / 2 - 25 + 0.5;
			layer.addChild(bg);
			ship = new shiptiny();
			ship.x = bg.x + 90.5;
			ship.y = bg.y - 94.6;
			layer.addChild(ship);
			textes = new wordle();
			textes.x = 134.85;
			textes.y = 67;
			layer.addChild(textes);
			var wordbank:String = "";
			var i:int = Math.floor(SelectionMemory.endShipQuotes.length * Math.random());
			var R:int = SelectionMemory.endShipQuotes.indexOf(i);
			SelectionMemory.endShipQuotes.splice(R, 1);
			switch(i) {
				case 0:
					wordbank = "“Those who cannot remember the past are condemned to repeat it.” \n - Michelangelo";
					break;
				case 1:
					wordbank = "“The only reason for time is so that everything doesn't happen at once.” \n - Stephen Hawking";
					break;
				case 2:
					wordbank = "“Time is the justice that examines all offenders.” \n - Proverbs 8:11";
					break;
				case 3:
					wordbank = "“Lost time is never found again.” \n - Paul Revere";
					break;
				case 4:
					wordbank = "“It is easier for a camel to pass through the eye of a needle than for a rich man to enter the Kingdom of Heaven.” \n - Anonymous";
					break;
				case 5:	
					wordbank = "“Choose a job you love, and you will never have to work a day in your life.” \n - Buddha";
					break;
				case 6:
					wordbank = "“The harder you work, the harder it is to surrender.” \n - Saint Nicholas";
					break;
				case 7:
					wordbank = "“A man's face is his autobiography. A woman's face is her work of fiction.” \n - Joan of Arc";
					break;
				case 8:
					wordbank = "“Work is a necessary evil to be avoided.” \n - Bill Gates";
					break;
				case 9:
					wordbank = "“By working faithfully eight hours a day you may eventually get to be boss and work twelve hours a day.” \n - Steve Jobs";
					break;
				case 10:
					wordbank = "“I never did a day's work in my life. It was all fun.” \n - George Bush";
					break;
				case 11:
					wordbank = "“Work is a necessity for man. Man invented the alarm clock.” \n - Vincent Van Gogh";
					break;
				case 12:
					wordbank = "“To know thyself is the beginning of wisdom.” - Aristotle";
					break;
				case 13:
					wordbank = "“If you hate a person, you hate something in him that is a part of yourself. What isn't part of ourselves doesn't disturb us.” - Stephen Colbert";
					break;
				case 14:
					wordbank = "“I would rather die a meaningful death than to live a meaningless life.” - Sergio Mendez";
					break;
				case 15:
					wordbank = "“Deprived of meaningful work, men and women lose their reason for existence; they go stark, raving mad.” - Vodka Drunkenski";
					break;
			}
			textes.dialogue.text = wordbank;
			blackfade = new pureBlack();
			blackfade.x = blackfade.width / 2;
			blackfade.y = blackfade.height / 2;
			blackfade.alpha = 0;
			layer.addChild(blackfade);
		}
		public function cleanUp():void {
			layer.removeChild(bg);
			layer.removeChild(ship);
			layer.removeChild(blackfade);
			layer.removeChild(textes);
			textes = null;
			bg = null;
			ship = null;
			blackfade = null;
		}
		public function update():int {
			ship.y += 0.5;
			if (ship.y > 200) {
				blackfade.alpha += 0.025;
				if (blackfade.alpha > 0.99) {
					return 1;
				}
			}
			return 0;
		}
	}
}