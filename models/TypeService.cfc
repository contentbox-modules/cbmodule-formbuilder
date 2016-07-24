/**
* Defines and returns field types
*/
component accessors=true singleton{

	property name="types" type="array";

	/**
	* Constructor
	*/
	TypeService function init(){
		variables.types = [
			{ 
				id = 1, typeName = "Text", showOptions = false, view = "text" 
			},
			{ 
				id = 2, typeName = "Text Area", showOptions = false, view = "textarea" 
			},
			{ 
				id = 3, typeName = "Select", showOptions = true, view = "select" 
			},
			{ 
				id = 4, typeName = "CheckBox", showOptions = false, view = "checkbox" 
			},
			{ 
				id = 5, typeName = "Radio", showOptions = true, view = "radio" 
			},
			{ 
				id = 6, typeName = "CheckBox Group", showOptions = true, view = "checkboxgroup" 
			}
		];
		return this;
	}

	function getNameByTypeID( required numeric typeID ) {
		for( var thisType in variables.types ){
			if( thisType.id == arguments.typeID ){
				return thisType.typename;
			}
		}
		return "";
	}

	function getViewByTypeID(required numeric typeID) {
		for( var thisType in variables.types ){
			if( thisType.id == arguments.typeID ){
				return thisType.view;
			}
		}
		return "";
	}

	function getShowOptionByTypeID(required numeric typeID) {
		for( var thisType in variables.types ){
			if( thisType.id == arguments.typeID ){
				return thisType.showOptions;
			}
		}
		return "";
	}

}