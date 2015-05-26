package {
	import flash.display.DisplayObjectContainer;
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
	public class GameWriting {
		private var stylus:Sprite;
		private var _bg:DisplayObjectContainer;
		private var _pl:DisplayObjectContainer;
		private var pX:int;
		private var pY:int;
		private var inks:Array;
		private var papers:Array;
		private var inksly:Sprite;
		private var writing:Boolean;
		private var canWrite:int;
		private var doneb:Sprite;
		private var quota:int;
		public function GameWriting(bg:DisplayObjectContainer, ms:DisplayObjectContainer, qu:int = 5) {
			_bg = bg;
			_pl = ms;
			pX = 999;
			pY = 999;
			canWrite = 10;
			inks = [];
			quota = qu;
			papers = [];
			stylus = new quelle();
			doneb = new done();
			doneb.x = 480 - doneb.width / 2;
			doneb.y = 240 - doneb.height / 2;
			_pl.addChild(doneb);
			_pl.addChild(stylus);
			papers.push(new Paper(_bg));
		}
		public function update(mouseX:int, mouseY:int, click:Boolean):int {
			stylus.x = mouseX;
			stylus.y = mouseY;
			if (canWrite > 0) {
				canWrite -= 1;
				papers[papers.length - 1].update();
			}
			if (click && canWrite <= 0) {
				if (!writing) {
					inksly = new Sprite();
					_bg.addChild(inksly);
					writing = true;
				}
				inksly.graphics.lineStyle(2, 0x000030, 0.9);
				inksly.graphics.moveTo(pX, pY);
				inksly.graphics.lineTo(mouseX, mouseY);
				if (mouseX > 412 && mouseY > 214) {
					inks.push(inksly);
					writing = false;
					papers.push(new Paper(_bg));
					canWrite = 10;
					quota -= 1;
				}
			}
			if (pX == 9999) {
				pX = mouseX;
				pY = mouseY;
			} else {
				stylus.rotation = Math.atan2(mouseY - 240, mouseX) * (180 / Math.PI) + 180;
				pX = mouseX;
				pY = mouseY;
			}
			if (quota <= 0) {
				return 1;
			}
			return 0;
		}
		public function cleanUp():void {
			_pl.removeChild(doneb);
			for each(var b:Sprite in inks) {
				_bg.removeChild(b);
			}
			inks = [];
			for each(var p:Paper in papers) {
				p.cleanUp();
			}
			papers = [];
			_pl.removeChild(stylus);
			stylus = null;
			doneb = null;
		}
	}
}