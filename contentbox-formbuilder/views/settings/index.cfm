<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<cfinclude template="../sidebar/actions.cfm" >
	<cfinclude template="../sidebar/about.cfm" >
</div>

<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			Settings
		</div>
		<!--- Body --->
		<div class="body" id="mainBody">

			#getPlugin("MessageBox").renderit()#

			#html.startForm(action="cbadmin.module.cbFormBuilder.settings.saveSettings",name="settingsForm")#
				<fieldset>
					<legend><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="modifiers"/> <strong>Field Containers/Style Hooks</strong></legend>

					<p>Setup your form field containers and style hooks here.</p>

					<div class="contentBar" style="background-color: ##fff; line-height: 1em;">
						<b>EXAMPLE:</b><br /><br />
						<small>
							<cfset indentation = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;">

							&lt;<b>GROUPWRAPPERCLASS</b> class="<b>GROUPWRAPPERCLASS</b>"&gt;<br />
								#indentation#&lt;<b>LABELWRAPPER</b> class=&quot;<b>LABELWRAPPERCLASS</b>"&gt;<br />
								#indentation##indentation#&lt;<b>LABEL</b> class="<b>LABELCLASS</b>"&gt;[LABEL]&lt;/<b>LABEL</b>&gt;<br />
								#indentation#&lt;/<b>LABELWRAPPER</b>&gt;<br />
								#indentation#&lt;<b>WRAPPER</b> class=&quot;<b>WRAPPERCLASS</b>"&gt;<br />
									#indentation##indentation#&lt;[INPUT FIELD]&gt;<br />
									#indentation##indentation#&lt;<b>HELPWRAPPER</b> class="<b>HELPWRAPPERCLASS</b>"&gt;[HELP TEXT]&lt;/<b>HELPWRAPPER</b>&gt;<br />
								#indentation#&lt;/<b>WRAPPER</b>&gt;<br />
							&lt;/<b>GROUPWRAPPER</b>&gt;
						</small>
					</div>

					#html.textField(name="groupWrapper", label="Group Wrapper:", value="#prc.settings.htmlHelper.groupWrapper#", class="textfield large")#

					#html.textField(name="groupWrapperClass", label="Group Wrapper Class:", value="#prc.settings.htmlHelper.groupWrapperClass#", class="textfield large")#

					#html.textField(name="labelWrapper", label="Label Wrapper:", value="#prc.settings.htmlHelper.labelWrapper#", class="textfield large")#

					#html.textField(name="labelWrapperClass", label="Label Wrapper Class:", value="#prc.settings.htmlHelper.labelWrapperClass#", class="textfield large")#

					#html.textField(name="label", label="Label:", value="#prc.settings.htmlHelper.label#", class="textfield large")#

					#html.textField(name="labelClass", label="Label  Class:", value="#prc.settings.htmlHelper.labelClass#", class="textfield large")#

					#html.textField(name="wrapper", label="Wrapper:", value="#prc.settings.htmlHelper.wrapper#", class="textfield large")#

					#html.textField(name="wrapperClass", label="Wrapper Class:", value="#prc.settings.htmlHelper.wrapperClass#", class="textfield large")#

					#html.textField(name="helpWrapper", label="Help Wrapper:", value="#prc.settings.htmlHelper.helpWrapper#", class="textfield large")#

					#html.textField(name="helpWrapperClass", label="Help Wrapper Class:", value="#prc.settings.htmlHelper.helpWrapperClass#", class="textfield large")#
				</fieldset>

				<fieldset>
					<legend><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="modifiers"/> <strong>CAPTCHA</strong></legend>

					<p>From here you can control global form CAPTCHA settings.</p>

					<label for="CAPTCHAType">CAPTCHA Type:</label>
					<small>Select the type of CAPTCHA you would like to use.</small><br>
					#html.radioButton(name="CAPTCHAType",checked=(prc.settings.CAPTCHAType eq 'CF'),value="CF")# ColdFusion
					#html.radioButton(name="CAPTCHAType",checked=(prc.settings.CAPTCHAType eq 'reCAPTCHA'),value="reCAPTCHA")# reCAPTCHA

					<label for="CAPTCHAType">reCAPTCHA Keys:</label>
					<small>Setup your account and get your keys <a href="https://www.google.com/recaptcha/admin/create" target="_blank">here</a></small><br>
					#html.textField(name="publicKey", label="Public Key:", value="#prc.settings.recaptcha.publicKey#", class="textfield large")#

					#html.textField(name="privateKey", label="Private Key:", value="#prc.settings.recaptcha.privateKey#", class="textfield large")#
				</fieldset>

				<div class="actionBar center">
					#html.submitButton(value="Save Settings",class="buttonred",title="Save the Form Builder settings")#
				</div>
			#html.endForm()#
		</div>
	</div>
</div>
</cfoutput>