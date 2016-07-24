/**
* base handler for the form builder
*/
component{

	// dependencies
	property name="formService"					inject="entityService:fbForm";
	property name="fieldService"				inject="entityService:fbField";
	property name="optionService"				inject="entityService:fbFieldOption";
	property name="TypeService"					inject="TypeService@contentbox-formbuilder";
	property name="FormSubmissionService"		inject="FormSubmissionService@contentbox-formbuilder";
	property name="cb" 							inject="cbHelper@cb";

	// pre handler
	function preHandler( event, action, eventArguments, rc, prc ){
		// get module root
		prc.moduleRoot = getModuleConfig( "contentbox-formbuilder" ).mapping;

		// if data isn't setup, redirect user
		if( !formSubmissionService.isDataSetup() && 
			event.getCurrentEvent() NEQ "contentbox-formbuilder:form.noDataSetup" 
		) {
			cb.setNextModuleEvent( "contentbox-formbuilder", "form.noDataSetup" );
		}

		// exit points
		prc.xehForms 				= "contentbox-formbuilder.form.index";
		prc.xehFormEditor 			= "contentbox-formbuilder.form.editor";
		prc.xehFieldEditor 			= "contentbox-formbuilder.field.editor";
		prc.xehFields 				= "contentbox-formbuilder.field.index";
		prc.xehFieldOptionEditor 	= "contentbox-formbuilder.option.editor";
		prc.xehFieldForm 			= "contentbox-formbuilder.field.form";
		prc.xehSubmissionReport 	= "contentbox-formbuilder.form.submissionReport";
		prc.xehFormSettings 		= "contentbox-formbuilder.settings.index";

		//check login and redirect is needed.
		if( !prc.oAuthor.isLoaded() ){
			getInstance( "MessageBox@cbMessageBox" ).warning( "Please login!" );
			setNextEvent( prc.xehLogin );
		}

	}

}