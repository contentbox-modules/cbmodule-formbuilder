/**
* Form entity
*/
component persistent="true" table="formbuilder_form" entityname="fbForm"{

	/* *********************************************************************
	**							DI									
	********************************************************************* */

	/* *********************************************************************
	**							PROPERTIES									
	********************************************************************* */

	// Primary Key
	property 	name="formID" 
				fieldtype="id" 
				generator="uuid" 
				ormtype="string"
				setter="false";

	// Properties
	property 	name="slug" 
				notnull="true" 
				length="200" 
				default="" 
				unique="true" 
				index="idx_slug";

	property 	name="name" 
				notnull="true" 
				length="200" 
				default="" 
				index="idx_name";

	property 	name="directions" 
				notnull="false" 
				length="2000" 
				default="";

	property 	name="submitMessage" 
				notnull="true" 
				length="2000" 
				default="";

	property 	name="emailTo" 
				notnull="false" 
				length="500" 
				default="";

	property 	name="cssID" 
				notnull="false" 
				length="250" 
				default="";

	property 	name="cssClass" 
				notnull="false" 
				length="250" 
				default="";

	property 	name="useCaptcha" 
				notnull="true" 
				ormtype="boolean" 
				default="true" 
				dbdefault="1" 
				index="idx_usecaptcha";

	property 	name="createdDate" 	
				type="date"
				ormtype="timestamp"
				notnull="true"
				update="false"
				index="idx_createDate";

	property 	name="modifiedDate"	
				type="date"
				ormtype="timestamp"
				notnull="true"
				index="idx_modifiedDate";

	/* *********************************************************************
	**							RELATIONSHIPS									
	********************************************************************* */

	// O2M -> Fields
	property 	name="fields" 
				singularName="field" 
				fieldtype="one-to-many" 
				type="array" 
				lazy="extra" 
				batchsize="25" 
				orderby="fieldOrder"
			  	cfc="Field"
			  	fkcolumn="FK_formID" 
			  	inverse="true" 
			  	cascade="all-delete-orphan";

	// O2M -> Submissions
	property 	name="submissions" 
				singularName="submission" 
				fieldtype="one-to-many" 
				type="array" 
				lazy="extra" 
				batchsize="25" 
				orderby="submissionDate DESC"
			  	cfc="FormSubmission"
			  	fkcolumn="FK_formID"
			  	inverse="true" 
			  	cascade="all-delete-orphan";

	/* *********************************************************************
	**							CALCULATED FIELDS									
	********************************************************************* */

	property 	name="numberOfSubmissions" 
				formula="select count(*) from formbuilder_submission fs where fs.FK_formID=formID" 
				default="0";

	/* *********************************************************************
	**							CONSTRAINTS							
	********************************************************************* */

	// Validation Constraints
	this.constraints ={
		"name" 				= {	required=true, size="1..200" },
		"slug" 				= {	required=true, size="1..200" },
		"submitMessage" 	= {	required=true, size="1..2000" },
		"directions" 		= {	required=false, size="1..2000" },
		"emailTo" 			= {	required=false, size="1..500" },
		"cssID" 			= {	required=false, size="1..250" },
		"cssClass" 			= {	required=false, size="1..250" }
	};

	// Constructor
	function init(){
		return this;
	}

	/*
	* pre insertion procedures
	*/
	void function preInsert(){
		var now = now();
		setCreatedDate( now );
		setModifiedDate( now );	
	}
	
	/*
	* pre update procedures
	*/
	void function preUpdate( struct oldData ){
		setModifiedDate( now() );
	}

	/**
	* is loaded?
	*/
	boolean function isLoaded(){
		return ( isNull( variables.formID ) OR !len( variables.formID ) ? false : true );
	}

}