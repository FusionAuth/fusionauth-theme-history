[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="fields" type="java.util.List<io.fusionauth.domain.form.FormField>" --]
[#-- @ftlvariable name="step" type="int" --]
[#-- @ftlvariable name="totalSteps" type="int" --]

[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [#-- Custom <head> code goes here --]
    <script>
    Prime.Document.onReady(function() {
      var firstInput = Prime.Document.queryFirst('form[action=complete-registration]').queryFirst('input:not([type=hidden])');
      if (firstInput !== null) {
          firstInput.focus();
      }
    });
    </script>
  [/@helpers.head]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.main title=theme.message('complete-registration')]
      <form action="complete-registration" method="POST" class="full">
        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="step"/]
        [@helpers.hidden name="registrationState"/]

        [#-- Begin Self Service Custom Registration Form Steps --]
        [#if fields?has_content]
          <fieldset>
            [#list fields as field]
              [@helpers.customField field field.key field?is_first?then(true, false) field.key /]
              [#if field.confirm]
                [@helpers.customField field "confirm.${field.key}" false "[confirm]${field.key}" /]
              [/#if]
            [/#list]
          </fieldset>

          <div class="form-row">
          [#if step == totalSteps]
            [@helpers.button icon="key" text=theme.message('register')/]
          [#else]
            [@helpers.button icon="arrow-right" text="Next"/]
          [/#if]
          </div>
        [#-- End Custom Self Service Registration Form Steps --]
        [#else]
        [#-- Begin Basic Self Service Registration Form --]
        <fieldset>
          [#if application.registrationConfiguration.firstName.enabled]
            [@helpers.input type="text" name="user.firstName" id="firstName" placeholder=theme.message('firstName') leftAddon="user" required=application.registrationConfiguration.firstName.required/]
          [/#if]
          [#if application.registrationConfiguration.fullName.enabled]
            [@helpers.input type="text" name="user.fullName" id="fullName" placeholder=theme.message('fullName') leftAddon="user" required=application.registrationConfiguration.fullName.required/]
          [/#if]
          [#if application.registrationConfiguration.middleName.enabled]
            [@helpers.input type="text" name="user.middleName" id="middleName" placeholder=theme.message('middleName') leftAddon="user" required=application.registrationConfiguration.middleName.required/]
          [/#if]
          [#if application.registrationConfiguration.lastName.enabled]
            [@helpers.input type="text" name="user.lastName" id="lastName" placeholder=theme.message('lastName') leftAddon="user" required=application.registrationConfiguration.lastName.required/]
          [/#if]
          [#if application.registrationConfiguration.birthDate.enabled]
            [@helpers.input type="text" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') leftAddon="calendar" class="date-picker" dateTimeFormat="yyyy-MM-dd" required=application.registrationConfiguration.birthDate.required/]
          [/#if]
          [#if application.registrationConfiguration.mobilePhone.enabled]
            [@helpers.input type="text" name="user.mobilePhone" id="mobilePhone" placeholder=theme.message('mobilePhone') leftAddon="phone" required=application.registrationConfiguration.mobilePhone.required/]
          [/#if]
        </fieldset>

        <div class="form-row">
          [@helpers.button icon="key" text=theme.message('submit')/]
        </div>
        [/#if]
        [#-- End Basic Self Service Registration Form --]

        [#-- Begin Self Service Custom Registration Form Step Counter --]
        [#if step > 0]
          <div class="w-100 mt-3" style="display: inline-flex; flex-direction: row; justify-content: space-evenly;">
            <div class="text-right" style="flex-grow: 1;"> ${theme.message('register-step', step, totalSteps)} </div>
          </div>
        [/#if]
        [#-- End Self Service Custom Registration Form Step Counter --]

      </form>
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]
