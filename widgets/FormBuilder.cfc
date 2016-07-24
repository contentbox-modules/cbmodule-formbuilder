/**
* A widget that renders form based on slug from a form built in the FormBuilder Module
*/
component extends="contentbox.model.ui.BaseWidget" singleton{

	/**
	* Constructor
	*/
	FormBuilder function init(){
		// Widget Properties
		setName( "FormBuilder" );
		setVersion( "2.0.0" );
		setDescription( "A widget that renders a form built in the FormBuilder Module" );
		setAuthor( "Ortus Solutions" );
		setAuthorURL( "https://www.ortussolutions.com" );
		setForgeBoxSlug( "contentbox-formbuilder" );
		setIcon( 'table' );
		setCategory( 'Content' );

		return this;
	}

	/**
	* Renders a form built with the form builder module.
	* @slug The form unique slug id to render
	* @defaultValue The string to show if the form identifier does not exist
	*/
	any function renderIt( required string slug, string defaultValue ){
		// run viewlet
		var content = runEvent( event='contentbox-formbuilder:formRender.renderForm', eventArguments=arguments);
		if( !isNull( content ) ){
			return content;
		}

		// default value
		if( structKeyExists( arguments, "defaultValue") ){
			return arguments.defaultValue;
		}

		throw( message="The content slug '#arguments.slug#' does not exist", type="FormBuilderWidget.InvalidFormBuilderSlug" );
	}

}
