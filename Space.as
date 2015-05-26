package {
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
	public class Space {
		private var chunks:Array;
		public function Space() {
			chunks = [];
			for (var i:int = 0; i < 30; i++) {
				chunks.push(new Chunk());
			}
		}
		public function getChunk(x:int, y:int):Chunk {
			return chunks[y * 3 + x];
		}
		public function findChunk(c:Chunk):int {
			return chunks.indexOf(c);
		}
	}
}