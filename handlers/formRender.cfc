/**
* I handle the form rendering events
*/
component{

	// Dependencies
	property name="formService"					inject="entityService:Form";
	property name="formSubmissionService"		inject="FormSubmissionService@contentbox-formbuilder";
	property name="HTMLHelper"					inject="HTMLHelper@coldbox";
	property name="loginTrackerService"			inject="LoginTrackerService@cb";

	/**
	* Render the form out
	* @slug The unique slug id
	* @return HTML
	*/
	function renderForm( event, rc, prc, slug="" ){
		// locate form
		prc.form = formService.findWhere( { slug = arguments.slug } );
		if( !isNull( prc.form ) ){
			prc.xehformsubmit 	= "contentbox-formbuilder:formRender.submitForm";
			prc.html 			= HTMLHelper;
			// render view out
			return renderView( view="viewlets/render", module="contentbox-formbuilder" );
		} else {
			return "Form '" & arguments.slug & "' not found.";
		}
	}

	/**
	* Submit a form
	*/
	function submitForm( event, rc, prc ){
		// Defaults
		event.setParam( "formID", "" )
			.setParam( "_returnTo", "" );
		// Check for errors
		var errors = formSubmissionService.validateSubmission( event, rc, prc );

		if ( arrayLen( errors ) ){
			getInstance( "MessageBox@cbMessageBox" ).warning( "There was a problem submitting your form!" );
		} else {
			// Get form object
			var oForm = formService.get( rc.formID );

			// Populate Submission
			var oSubmission = formSubmissionService.new();
			oSubmission.setSubmissionIP( LoginTrackerService.getRealIP() );
			oSubmission.setFormData( serializeJSON( rc ) );
			oSubmission.setForm( oForm );
			oSubmission.setSubmissionDate( now() );

			// Save it
			formSubmissionService.save( oSubmission );
			getInstance( "MessageBox@cbMessageBox" ).info( oForm.getSubmitMessage() );
			prc.formData = rc;
			
			//set any emails if there are any
			oSubmission.sendSubmissionEmails();
		}

		// relocate
		setNextEvent( url=rc._returnTo );
	}

}