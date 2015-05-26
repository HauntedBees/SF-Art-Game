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
	public class Chunk {
		private var covers:Array;
		private var chunk:Sprite;
		private var coverSprites:Array;
		private var spaceElements:Array;
		private var spaceElementSprites:Array;
		public function Chunk() {
			covers = [];
			coverSprites = [];
			spaceElements = [];
			spaceElementSprites = [];
			chunk = new Sprite();
			covers.push(new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0), new uint(0));
		}
		public function render(loc:DisplayObjectContainer, dx:int, dy:int):void {
			if (coverSprites.length == 0) {
				chunk.x = dx;
				chunk.y = dy;
				loc.addChild(chunk);
				if (spaceElements.length == 0) {
					var I:int = 2.1 + 11.5 * Math.random();
					for (var ii:int = 0; ii < I; ii++) {
						var doopF:int = Math.ceil(185 * Math.random());
						var J:MovieClip = new spaceparts();
						J.gotoAndStop(doopF);
						var doopX:int = J.width / 2 + 5 + (600 - J.width / 2 - 5) * Math.random();
						var doopY:int = J.height / 2 + 5 + (300 - J.height / 2 - 5) * Math.random();
						var doopR:int = 360 * Math.random();
						spaceElements.push(new SpaceElement(doopF, doopX, doopY, doopR));
						J.x = doopX;
						J.y = doopY;
						J.rotation = doopR;
						chunk.addChild(J);
						spaceElementSprites.push(J);
					}
				} else if (spaceElementSprites.length == 0) {
					for (var q:int = 0; q < spaceElements.length; q++) {
						var K:MovieClip = new spaceparts();
						var B:SpaceElement = spaceElements[q];
						K.x = B.x;
						K.y = B.y;
						K.rotation = B.rot;
						K.gotoAndStop(B.frame);
						chunk.addChild(K);
					}
				}
				for (var i:int = 0; i < covers.length; i++) {
					var k:int = 0;
					for (var j:uint = 1; j < 1048576; j *= 2) {
						if (!(covers[i] & j)) {
							var X:Sprite = new bbox();
							X.x = 30 * k + 15;
							X.y = 30 * i + 15;
							var AX:ChunkBit = new ChunkBit(X, k, i);
							k += 1;
							chunk.addChild(X);
							coverSprites.push(AX);
						}
					}
				}
			}
		}
		public function derender(loc:DisplayObjectContainer):void {
			for each(var e:ChunkBit in coverSprites) {
				var k:int = exp2(e.posX);
				var j:int = e.posY;
				if (!(covers[j] & k) && e.val) {
					covers[j] += k;
				}
				chunk.removeChild(e.spr);
				e.spr = null;
			}
			for each(var f:MovieClip in spaceElementSprites) {
				chunk.removeChild(f);
			}
			coverSprites = [];
			spaceElementSprites = [];
			loc.removeChild(chunk);
		}
		public function getCoords():Point {
			return new Point(chunk.x, chunk.y);
		}
		public function updateBlocks(pX:int, pY:int):void {
			for each(var a:ChunkBit in coverSprites) {
				var c:Point = new Point(a.spr.x, a.spr.y);
				if (((pX - (c.x + chunk.x)) * (pX - (c.x + chunk.x)) + (pY - (c.y + chunk.y)) * (pY - (c.y + chunk.y))) < 15000) {
					a.val = true;
				}
				if (a.val && a.spr.alpha > 0) {
					a.spr.alpha -= 0.1;
				}
			}
		}
		public function getWidth():Number {
			return chunk.width;
		}
		public function getHeight():Number {
			return chunk.height;
		}
		public function shift(dx:int, dy:int):int {
			chunk.x += dx;
			chunk.y += dy;
			var returnvalue:int = 0;
			if (chunk.x < -110) {
				returnvalue = 1;
			} else if (chunk.x > -5) {
				returnvalue = 2;
			}
			if (chunk.y > 0) {
				returnvalue += 4;
			}
			if ( chunk.x > 500 || chunk.x < -700 || chunk.y > 350) {
				returnvalue += 8;
			}
			return returnvalue;
		}
		private function exp2(i:int):uint {
			switch(i) {
				case 0: return 1; break;
				case 1: return 2; break;
				case 2: return 4; break;
				case 3: return 8; break;
				case 4: return 16; break;
				case 5: return 32; break;
				case 6: return 64; break;
				case 7: return 128; break;
				case 8: return 256; break;
				case 9: return 512; break;
				case 10: return 1024; break;
				case 11: return 2048; break;
				case 12: return 4096; break;
				case 13: return 8192; break;
				case 14: return 16384; break;
				case 15: return 32768; break;
				case 16: return 65536; break;
				case 17: return 131072; break;
				case 18: return 262144; break;
				case 19: return 524288; break;
				case 20: return 1048576; break;
			}
			return 0;
		}
	}
}