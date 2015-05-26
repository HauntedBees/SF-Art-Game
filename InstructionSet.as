package  {
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
	public class InstructionSet {
		private var game:int;
		private var target:int;
		private var mode:int;
		public function InstructionSet(gameType:int) {
			game = gameType;
			var i:int = 0;
			switch(game) {
				case 1:
					PeopleParser.addTarget();
					i = Math.floor(SelectionMemory.ShooterLevels.length * Math.random());
					mode = SelectionMemory.ShooterLevels[i];
					SelectionMemory.ShooterLevels.splice(i, 1);
					break;
				case 2:
					target = Math.floor(PeopleParser.game2Names.length * Math.random());
					i = Math.floor(SelectionMemory.PlumberLevels.length * Math.random());
					mode = SelectionMemory.PlumberLevels[i];
					SelectionMemory.PlumberLevels.splice(i, 1);
					break;
				case 3:
					break;
			}
		}
		public function gMode():int {
			return mode;
		}
		public function gTarget():int {
			return target;
		}
		public function gGame():int {
			return game;
		}
	}
}