[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="postMethod" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="verificationId" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [#-- Custom <head> code goes here --]
  [/@helpers.head]
  [@helpers.body]
    [#if verificationId?? && postMethod]
      <form action="${request.contextPath}/email/verify" method="POST">
        <input type="hidden" name="client_id" value="${client_id!''}">
        <input type="hidden" name="postMethod" value="true">
        <input type="hidden" name="tenantId" value="${tenantId!''}">
        <input type="hidden" name="verificationId" value="${verificationId}">
      </form>
      <script type="text/javascript">
        document.forms[0].submit();
      </script>
    [#else]
      [@helpers.header]
        [#-- Custom header code goes here --]
      [/@helpers.header]

      [@helpers.main title=theme.message('email-verification-form-title')]
        [#-- FusionAuth automatically handles errors that occur during email verification and outputs them in the HTML --]
        <form action="${request.contextPath}/email/verify" method="POST" class="full">
          [@helpers.hidden name="client_id"/]
          [@helpers.hidden name="tenantId"/]
          <p>
            ${theme.message('email-verification-form')}
          </p>
          <fieldset class="push-less-top">
            [@helpers.input type="text" name="email" id="email" autocapitalize="none" autofocus=true autocomplete="on" autocorrect="off" placeholder="${theme.message('email')}" leftAddon="user"/]
          </fieldset>
          <div class="form-row">
            [@helpers.button text=theme.message('submit')/]
          </div>
        </form>
      [/@helpers.main]

      [@helpers.footer]
        [#-- Custom footer code goes here --]
      [/@helpers.footer]
    [/#if]
  [/@helpers.body]
[/@helpers.html]
