package com.flashdynamix.utils {

	public class ObjectPool {

		public var size : int = 0;
		public var Create : Class;
		public var length : int = 0;

		private var list : Array = [];
		private var disposed : Boolean = false;

		public function ObjectPool(Create : Class) {
			this.Create = Create;
		}

		public function add() : void {
			list[length++] = new Create();
			size++;
		}

		public function checkOut() : * {
			if(length == 0) {
				size++;
				return new Create();
			}
			
			return list[--length];
		}

		public function checkIn(item : *) : void {
			list[length++] = item;
		}

		public function empty() : void {
			size = length = list.length = 0;
		}

		public function dispose() : void {
			if(disposed) return;
			
			disposed = true;
			
			Create = null;
			list = null;
		}
	}
}
