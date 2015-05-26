package {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
	public class SoundHandler {
		public var pistol:Sound;
		public var shotgun:Sound;
		public var tommygun:Sound;
		public var reload:Sound;
		public var hurt:Sound;
		public var death:Sound;
		public var KO:Sound;
		public var kelp:Sound;
		public var fish:Sound;
		public var mine:Sound;
		public var harpoon:Sound;
		public var uterus:Sound;
		public var blood:Sound;
		public var baby:Array;
		public var query:Array;
		public var qHurt:Array;
		public var queries:SoundChannel;
		public var MusicPlay:SoundChannel;
		public var GameMusic:SoundChannel;
		public var MPL:int;
		public var dark:Sound;
		public var timer:Sound;
		public var anger:Array;
		public var aHurt:Array;
		public var angel:Array;
		public var anHurt:Array;
		public var step:Sound;
		public var jump:Sound;
		public var typewriter:Sound;
		public var coin:Sound;
		public var dunDun:Sound;
		public var happyHouse1:Sound;
		public var happyHouse2:Sound;
		public var happyHouse3:Sound;
		public var happyHouse4:Sound;
		public var office1:Sound;
		public var office2:Sound;
		public var office3:Sound;
		public var office4:Sound;
		public var sewer:Sound;
		public var shooter:Sound;
		public var theme:Sound;
		public var entirety:Array;
		public var entiretyTEXT:Array;
		public function SoundHandler() {
			GameMusic = new SoundChannel();
			happyHouse1 = new sHH1();
			happyHouse2 = new sHH2();
			happyHouse3 = new sHH3();
			happyHouse4 = new sHH4();
			office1 = new sO1();
			office2 = new sO2();
			office3 = new sO3();
			office4 = new sO4();
			sewer = new sSewer();
			shooter = new sShooterS();
			theme = new sTheme();
			dunDun = new sDunDun();
			coin = new sCoin();
			typewriter = new sWalkD();
			step = new sWalkc();
			jump = new sWalkB();
			pistol = new sPistol();
			shotgun = new sShotgun();
			tommygun = new sTommy();
			reload = new sReload();
			hurt = new sHurt();
			death = new sDeath();
			KO = new sKO();
			kelp = new sKelp();
			fish = new sFish();
			mine = new sMine();
			harpoon = new sHarpoon();
			uterus = new sUterus();
			blood = new sBlood();
			dark = new sDark();
			timer = new sTimer();
			baby = [];
			query = [];
			qHurt = [];
			aHurt = [];
			anger = [];
			angel = [];
			anHurt = [];
			MusicPlay = new SoundChannel();
			MPL = 0;
			baby.push(new sBaby1(), new sBaby2(), new sBaby3(), new sBaby4(), new sBaby5());
			queries = new SoundChannel();
			query.push(new sQ1(), new sQ2(), new sQ3(), new sQ4(), new sQ5(), new sQ6(), new sQ7());
			qHurt.push(new sQh1(), new sQh2(), new sQh3());
			anger.push(new sAngry1(),  new sAngry2(),  new sAngry3(),  new sAngry4(),  new sAngry5(),  new sAngry6(),  new sAngry7(),  new sAngry8());
			aHurt.push(new saHurt1(), new saHurt2(), new saHurt3(), new saHurt4());
			angel.push(new sAngel1(),  new sAngel2(),  new sAngel3(),  new sAngel4(),  new sAngel5(),  new sAngel6(),  new sAngel7());
			anHurt.push(new sAngelH1(), new sAngelH2(), new sAngelH3(), new sAngelH4(), new sAngelH5());
			entirety = [];
			entirety.push(dunDun, sewer, shooter, happyHouse1, happyHouse2, happyHouse3, happyHouse4, office1, office2, office3, office4, theme);
			entirety.push(angel[0], angel[1], angel[2], angel[3], angel[4], angel[5], angel[6], anHurt[0], anHurt[1], anHurt[2], anHurt[3], anHurt[4]);
			entirety.push(anger[0], anger[1], anger[2], anger[3], anger[4], anger[5], anger[6], anger[7], aHurt[0], aHurt[1], aHurt[2], aHurt[3]);
			entirety.push(baby[0], baby[1], baby[2], baby[3], baby[4]);
			entirety.push(blood, dark, death, coin, fish, harpoon, hurt, uterus, kelp, KO, mine, pistol);
			entirety.push(query[0], query[1], query[2], query[3], query[4], query[5], query[6], qHurt[0], qHurt[1], qHurt[2]);
			entirety.push(reload, shotgun, timer, tommygun, step, jump, typewriter);
			entiretyTEXT = [];
			var m:String = "Macho";
			var s:String = "!bksFCWEVEQ";
			entiretyTEXT.push(new MusicArray(m, "Thematic Opening"), new MusicArray(m, "Sewers Skewers"), new MusicArray(m, "Something Intense (for killing)"), new MusicArray(m, "Happy House Music 1"), new MusicArray(m, "Happy House Music 2"), new MusicArray(m, "Happy House Music 3"), new MusicArray(m, "Happy House Music 4"), new MusicArray(m, "Office is Balls 1"), new MusicArray(m, "Office is Balls 2"), new MusicArray(m, "Office is Balls 3"), new MusicArray(m, "Office is Balls 4"), new MusicArray(m, "So Deep It's China"));
			entiretyTEXT.push(new MusicArray(s, "Deceptus - \"Have some of this!\""), new MusicArray(s, "Deceptus - \"The power...\""), new MusicArray(s, "Deceptus - \"Eat shit and die!\""), new MusicArray(s, "Deceptus - \"I'll rip your head off...\""), new MusicArray(s, "Deceptus - \"Take that!\""), new MusicArray(s, "Deceptus - \"Here we go!\""), new MusicArray(s, "Deceptus - Battle Cry"), new MusicArray(s, "Deceptus - Hurt 1"), new MusicArray(s, "Deceptus - Hurt 2"), new MusicArray(s, "Deceptus - Hurt 3"), new MusicArray(s, "Deceptus - Hurt 4"), new MusicArray(s, "Deceptus - Hurt 5")); 
			entiretyTEXT.push(new MusicArray(s, "Chairs - \"Eat shit and die!\""), new MusicArray(s, "Chairs - \"Blow it out your ass!\""), new MusicArray(s, "Chairs - \"Die, you son of a bitch!\""), new MusicArray(s, "Chairs - \"I'll rip your head off...\""), new MusicArray(s, "Chairs - \"See you in Hell!\""), new MusicArray(s, "Chairs - \"Suck it down!\""), new MusicArray(s, "Chairs - \"This is gonna leave...\""), new MusicArray(s, "Chairs - \"Rest in pieces!\""), new MusicArray(s, "Chairs - Hurt 1"), new MusicArray(s, "Chairs - Hurt 2"), new MusicArray(s, "Chairs - Hurt 3"), new MusicArray(s, "Chairs - Hurt 4"));     
			entiretyTEXT.push(new MusicArray(s, "Baby Dearest - Hurt 1"), new MusicArray(s, "Baby Dearest - Hurt 2"), new MusicArray(s, "Baby Dearest - Hurt 3"), new MusicArray(s, "Baby Dearest - Hurt 4"), new MusicArray(s, "Baby Dearest - Hurt 5"));
			entiretyTEXT.push(new MusicArray(s, "Blood"), new MusicArray(s, "Dark Shot"), new MusicArray(s, "Assassination"), new MusicArray(s, "Dling! A coin!"), new MusicArray(s, "Fish is the Wish"), new MusicArray(s, "Man the Harpoons"), new MusicArray(s, "Hurt"), new MusicArray(s, "Gynecology"), new MusicArray(s, "Kelp Whelp"), new MusicArray("Capcom", "KNOCK OUT"), new MusicArray(s, "Boom goes the Dynamite"), new MusicArray(s, "Pistol"));
			entiretyTEXT.push(new MusicArray(s, "Inquisitor - \"What's the point?\""), new MusicArray(s, "Inquisitor - \"Does any of it matter?\""), new MusicArray(s, "Inquisitor - \"Why am I doing this?\""), new MusicArray(s, "Inquisitor - \"Is this all there is...?\""), new MusicArray(s, "Inquisitor - \"Why am I here?\""), new MusicArray(s, "Inquisitor - \"Why do I even bother?\""), new MusicArray(s, "Inquisitor - \"Who cares?\"") , new MusicArray(s, "Inquisitor - Hurt 1"), new MusicArray(s, "Inquisitor - Hurt 2"), new MusicArray(s, "Inquisitor - Hurt 3"));
			entiretyTEXT.push(new MusicArray(s, "Reloading"), new MusicArray(s, "Shotgun"), new MusicArray(s, "Brick go Beep Beep!"), new MusicArray(s, "Gat Gat Gat! Where my bitches at?"), new MusicArray(s, "Walking"), new MusicArray(s, "Jumping"), new MusicArray(s, "Typewriter"));    
		}
	}
}