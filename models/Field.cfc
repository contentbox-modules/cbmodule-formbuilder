/**
* Field entity
*/
component persistent="true" table="formbuilder_field" entityname="fbField"{

	/* *********************************************************************
	**							DI									
	********************************************************************* */

	property 	name="typeService"		
				inject="TypeService@contentbox-formbuilder"
				persistent=false;

	/* *********************************************************************
	**							PROPERTIES									
	********************************************************************* */

	// Primary Key
	property 	name="fieldID" 
				fieldtype="id" 
				generator="uuid" 
				ormtype="string"
				setter="false";

	// Properties
	property 	name="fieldOrder" 
				notnull="false"
				ormtype="integer" 
				default="0" 
				dbdefault="0";

	property 	name="name" 
				notnull="true" 
				length="200" 
				default=""
				index="idx_name";

	property 	name="label" 
				notnull="true" 
				length="200" 
				default="" 
				index="idx_label";

	property 	name="typeID" 
				notnull="false" 
				ormtype="integer" 
				default="0" 
				dbdefault="0";

	property 	name="isRequired" 
				notnull="true" 
				ormtype="boolean" 
				default="true" 
				dbdefault="1" 
				index="idx_isRequired";

	property 	name="maxLength" 
				notnull="false" 
				ormtype="integer" 
				default="50" 
				dbdefault="50";

	property 	name="helpText" 
				notnull="false" 
				length="2000" 
				default="";

	property 	name="cssID" 
				notnull="false" 
				length="250" 
				default="";

	property 	name="cssClass" 
				notnull="false" 
				length="250" 
				default="";

	property 	name="defaultValue" 
				notnull="true" 
				length="2000" 
				default="";


	/* *********************************************************************
	**							RELATIONSHIPS									
	********************************************************************* */

	// M2O -> Form
	property 	name="form" 
				notnull="true" 
				cfc="Form" 
				fieldtype="many-to-one" 
				fkcolumn="FK_formID" 
				lazy="true" 
				fetch="join";

	// O2M -> FieldOptions
	property 	name="fieldOptions" 
				singularName="fieldOption" 
				fieldtype="one-to-many" 
				type="array" 
				lazy="extra" 
				batchsize="25" 
				orderby="order"
			  	cfc="FieldOption" 
			  	fkcolumn="FK_fieldID" 
			  	inverse="true" 
			  	cascade="all-delete-orphan";

	/* *********************************************************************
	**							CONSTRAINTS							
	********************************************************************* */

	// Validation Constraints
	this.constraints ={
		"name" 				= {	required=true, size="1..200" },
		"label" 			= {	required=true, size="1..200" },
		"helpText" 			= {	required=false, size="1..2000" },
		"cssID" 			= {	required=false, size="1..250" },
		"cssClass" 			= {	required=false, size="1..250" }
	};

	// Constructor
	function init(){
		return this;
	}

	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return ( isNull( variables.fieldID ) OR !len( variables.fieldID ) ? false : true );
	}

	/**
	* get the type name
	*/
	function getTypeName(){
		return typeService.getNameByTypeID( variables.typeID );
	}

	/**
	* get the type view
	*/
	function getTypeView(){
		return typeService.getViewByTypeID( variables.typeID );
	}

}