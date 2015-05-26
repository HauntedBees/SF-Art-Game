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
	public class SelectionMemory {
		public static var sHandler:SoundHandler;
		public static var ScrollerLevels:Array = [1, 2, 3, 4, 5];
		public static var ShooterLevels:Array = [1, 2, 3, 4, 5, 6, 7, 8];
		public static var PlumberLevels:Array = [1, 2, 3, 4, 5, 6];
		public static var WriterLevels:Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
		public static var gamesPlayed:Array = [];
		public static var poster:int = 0;
		public static var day:int = 1;
		public static var space:Space;
		public static var endShipQuotes:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
		public static var dayPlacardSlogans:Array = [1, 2, 3 , 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
		public static var diaryEntries:Array = [1, 2, 3, 4, 5, 6, 7, 8];
		public static var sound:Boolean = true;
		public static var quality:int = 1;
		public static var soundOff:Boolean = false;
		public function SelectionMemory() { }
	}
}