[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code" type="java.lang.String" --]
[#-- @ftlvariable name="postMethod" type="boolean" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
  [/@helpers.head]
  [@helpers.body]
    [#if code?? && postMethod]
      <form action="${request.contextPath}/oauth2/passwordless/${code}" method="POST">
        [@helpers.oauthHiddenFields/]
        <input type="hidden" name="code" value="${code}">
        <input type="hidden" name="postMethod" value="true">
        [@helpers.hidden name="userVerifyingPlatformAuthenticatorAvailable"/]
      </form>
      <script type="text/javascript">
        if (PublicKeyCredential && PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable) {
          PublicKeyCredential
            .isUserVerifyingPlatformAuthenticatorAvailable()
            .then(result => {
              document.querySelector('input[name="userVerifyingPlatformAuthenticatorAvailable"]').value = result;
              document.forms[0].submit();
            });
        } else {
          document.forms[0].submit();
        }
      </script>
    [#else]
      [@helpers.header]
        [#-- Custom header code goes here --]
      [/@helpers.header]

      [@helpers.main title=theme.message('passwordless-login')]
        [#setting url_escaping_charset='UTF-8']
        <form action="${request.contextPath}/oauth2/passwordless" method="POST" class="full">
          [@helpers.oauthHiddenFields/]

          <fieldset>
            [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('loginId') leftAddon="user" required=true/]
            [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
          </fieldset>

          [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message('remember-device') value="true" uncheckedValue="false"]
            <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
          [/@helpers.input]

          <div class="form-row">
            [@helpers.button icon="send" text=theme.message('send')/]
            <p class="mt-2">[@helpers.link url="/oauth2/authorize"]${theme.message('return-to-login')}[/@helpers.link]</p>
          </div>
        </form>
      [/@helpers.main]

      [@helpers.footer]
        [#-- Custom footer code goes here --]
      [/@helpers.footer]
    [/#if]
  [/@helpers.body]
[/@helpers.html]
