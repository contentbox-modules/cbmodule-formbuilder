/**
* Form Submission entity
*/
component persistent="true" table="formbuilder_submission"{

	/* *********************************************************************
	**							DI									
	********************************************************************* */

	property 	name="mailService"		
				inject="MailService@cbMailServices" 
				persistent="false";

	property 	name="settingService"	
				inject="id:settingService@cb" 
				persistent="false";

	property 	name="renderer"		
				inject="provider:ColdBoxRenderer" 
				persistent="false";

	/* *********************************************************************
	**							PROPERTIES									
	********************************************************************* */

	// Primary Key
	property 	name="formSubmissionID" 
				fieldtype="id" 
				generator="uuid" 
				ormtype="string"
				setter="false";

	// Properties
	property 	name="formData" 
				notnull="false" 
				length="8000" 
				default="";

	property 	name="submissionIP" 
				notnull="true" 
				length="20" 
				update="false" 
				index="idx_submissionIP";

	property 	name="submissionDate" 
				notnull="true" 
				ormtype="timestamp" 
				update="false" 
				index="idx_submissionDate";

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

	// M2O -> Form
	property 	name="form" 
				notnull="true" 
				cfc="Form" 
				fieldtype="many-to-one" 
				fkcolumn="FK_formID" 
				lazy="true" 
				fetch="join";


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
	* Send a submission email for the form
	*/
	struct function sendSubmissionEmails(){
		//if they was an email to set for the form then we need to send it
		if( hasForm() && !isNull( getForm().getEmailTo() ) ){
			//set some settings
			var outEmails 	= getForm().getEmailTo();
			var subject 	= "New submission from the" & getForm().getName() & " form.";
			var settings 	= settingService.getAllSettings( asStruct=true );

			//build the body
			var body = getFormData();
			// Send it baby!
			var oMail = mailservice.newMail(
				to  		= outEmails,
				from  		= settings.cb_site_outgoingEmail,
				subject  	= subject,
				body  		= body,
				type  		= "html",
				server  	= settings.cb_site_mail_server,
				username  	= settings.cb_site_mail_username,
				password  	= settings.cb_site_mail_password,
				port  		= settings.cb_site_mail_smtp,
				useTLS  	= settings.cb_site_mail_tls,
				useSSL  	= settings.cb_site_mail_ssl);
			
			// generate content for email from template
			oMail.setBody( 
				renderer.renderView( view="viewlets/renderSubmission", module="contentbox-formbuilder" ) 
			);

			// send it out
			return mailService.send( oMail );
		}
	}
}
