/**
* FieldOption entity
*/
component persistent="true" table="formbuilder_fieldOption" entityname="fbFieldOption"{
	
	/* *********************************************************************
	**							DI									
	********************************************************************* */

	/* *********************************************************************
	**							PROPERTIES									
	********************************************************************* */
	
	// Primary Key
	property 	name="fieldOptionID" 
				fieldtype="id" 
				generator="uuid" 
				ormtype="string"
				setter="false";

	// Properties
	property 	name="order" 
				notnull="false" 
				ormtype="integer" 
				default="0" 
				dbdefault="0";

	property 	name="displayValue" 
				notnull="true" 
				length="2000" 
				default="";

	property 	name="actualValue" 
				notnull="true" 
				length="2000" 
				default="";

	property 	name="isChecked" 
				notnull="true" 
				ormtype="boolean" 
				default="true" 
				dbdefault="1" 
				index="idx_isChecked";

	/* *********************************************************************
	**							RELATIONSHIPS									
	********************************************************************* */

	// M2O -> Form
	property 	name="field" 
				notnull="true" 
				cfc="Field" 
				fieldtype="many-to-one" 
				fkcolumn="FK_fieldID" 
				lazy="true" 
				fetch="join";

	/* *********************************************************************
	**							CONST								
	********************************************************************* */

	// Validation Constraints
	this.constraints ={
		"displayValue" 			= {	required=true, size="1..2000" },
		"actualValue" 			= {	required=true, size="1..2000" }
	};

	// Constructor
	function init(){
		return this;
	}

	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return ( isNull( variables.fieldOptionID ) OR !len( variables.fieldOptionID ) ? false : true );
	}

}