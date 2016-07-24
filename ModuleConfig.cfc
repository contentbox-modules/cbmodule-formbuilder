/**
* A Module that will help you generate forms for ContentBox, used in combination with the
* FormBuilder Widget it will allow you to create forms and display them on your ContentBox
* pages
*/
component {

	// Module Properties
	this.title 				= "ContentBox Form Builder";
	this.author 			= "Ortus Solutions, Corp";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "A cool form builder for ContentBox";
	this.version			= "2.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "contentbox-formbuilder";

	function configure(){

		// module settings - stored in modules.name.settings
		settings = {
			// default containers and classes for the html helper form elements
			htmlHelper = { 
				groupWrapper = "", 
				groupWrapperClass = "", 
				labelWrapper = "", 
				labelWrapperClass = "", 
				label = "", 
				labelClass = "", 
				helpWrapper = "", 
				helpWrapperClass = "", 
				wrapper = "" , 
				wrapperClass = "" },
			// get your keys at https://www.google.com/recaptcha/admin/create
			CAPTCHAType = "",
			reCAPTCHA = { 
				publicKey = "", 
				privateKey = "" 
			}
		};

		// SES Routes
		routes = [
			{ pattern="/", handler="form", action="index" },
			// Convention Route
			{ pattern="/:handler/:action?" }
		];

		// Interceptors
		interceptors = [
		];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Let's add ourselves to the main menu in the Modules section
		var menuService = wirebox.getInstance( "AdminMenuService@cb" );
		// Add Menu Contribution
		menuService.addSubMenu(
			topMenu = menuService.CONTENT,
			name 	= "contentbox-formbuilder",
			label 	= "Form Builder",
			href 	= "#menuService.buildModuleLink( 'contentbox-formbuilder', 'form.index' )#"
		);
	}

	/**
	* Fired when the module is activated
	*/
	function onActivate(){
		var settingService = wirebox.getInstance( "SettingService@cb" );
		// store default settings
		var setting = settingService.findWhere( criteria={ name="form_builder" } );
		if( isNull( setting ) ){
			var args = { name="form_builder", value=serializeJSON( variables.settings ) };
			var formBuilderSettings = settingService.new( properties=args );
			settingService.save( formBuilderSettings );
		}
		// Flush the settings cache so our new settings are reflected
		settingService.flushSettingsCache();
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = wirebox.getInstance( "AdminMenuService@cb" );
		// Remove Menu Contribution
		menuService.removeSubMenu(
			topMenu=menuService.CONTENT,
			name="contentbox-formbuilder"
		);
	}

	/**
	* Fired when the module is deactivated by ContentBox Only
	*/
	function onDeactivate(){
		var settingService = wirebox.getInstance( "SettingService@cb" );
		var setting = settingService.findWhere( criteria={ name="form_builder" } );
		if( !isNull( setting ) ){
			settingService.delete( setting );
		}
	}

}