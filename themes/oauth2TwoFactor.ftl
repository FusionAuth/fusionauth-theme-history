[#ftl/]
[#-- @ftlvariable name="pushEnabled" type="boolean" --]
[#-- @ftlvariable name="pushPreferred" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="trustComputer" type="boolean" --]
[#-- @ftlvariable name="userCanReceivePush" type="boolean" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]

[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [#-- Custom <head> code goes here --]
    <script src="${request.contextPath}/js/oauth2/TwoFactor.js?version=${version}"></script>
    <script>
      Prime.Document.onReady(function() {
        new FusionAuth.OAuth2.TwoFactor();
      });
    </script>
  [/@helpers.head]
  [@helpers.body]

    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.main title=theme.message('two-factor-challenge')]
      [#setting url_escaping_charset='UTF-8']
      <form id="2fa-form" action="two-factor" method="POST" class="full">
        [@helpers.input type="text" name="code" id="code" autocapitalize="none" autocomplete="off" autocorrect="off" autofocus=true leftAddon="lock" placeholder=theme.message('code')/]

        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="twoFactorId"/]
        [@helpers.hidden name="resendCode" value="false"/]
        <div class="form-row">
          <label>
            <input type="checkbox" name="trustComputer" [#if trustComputer]checked[/#if]/>
            [#assign trustInDays = (tenant.externalIdentifierConfiguration.twoFactorTrustIdTimeToLiveInSeconds / (24 * 60 * 60))?string("##0")/]
            ${theme.message('trust-computer', trustInDays)}
            <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}trustComputer')}"></i>[#t/]
          </label>
        </div>
        [@helpers.button text=theme.message('verify')/]
        [#if pushEnabled && userCanReceivePush]
          <a id="resend-2fa" href="#">
            [#if pushPreferred]
              ${theme.message('send-another-code')}
            [#else]
              ${theme.message('send-code-to-phone')}
            [/#if]
          </a>
        [/#if]
      </form>
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]
