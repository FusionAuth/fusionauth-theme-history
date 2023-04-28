[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="hasDomainBasedIdentityProviders" type="boolean" --]
[#-- @ftlvariable name="identityProviders" type="java.util.Map<java.lang.String, java.util.List<io.fusionauth.domain.provider.BaseIdentityProvider<?>>>" --]
[#-- @ftlvariable name="loginId" type="java.lang.String" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordlessEnabled" type="boolean" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="showPasswordField" type="boolean" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    <script src="/js/jstz-min-1.0.6.js"></script>
    <script src="/js/oauth2/Authorize.js?version=${version}"></script>
    <script src="/js/identityProvider/InProgress.js?version=${version}"></script>
    [@helpers.alternativeLoginsScript clientId=client_id identityProviders=identityProviders/]
    <script>
      Prime.Document.onReady(function() {
        [#-- This object handles guessing the timezone and filling in the device id of the user --]
        new FusionAuth.OAuth2.Authorize();
      });
    </script>
  [/@helpers.head]
  [@helpers.body]

    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.main title=theme.message('login')]
      [#-- During a linking work flow, optionally indicate to the user which IdP is being linked. --]
      [#if devicePendingIdPLink??]
        <p class="mt-0">
          ${theme.message('pending-device-link', devicePendingIdPLink.identityProviderName)}
        </p>
      [/#if]
      [#-- During a linking work flow, optionally indicate to the user which IdP is being linked. --]
      [#if pendingIdPLink??]
        <p class="mt-0">
          ${theme.message('pending-link-login-to-complete', pendingIdPLink.identityProviderName)}
          [@helpers.link url="" extraParameters="&cancelPendingIdpLink=true"]${theme.message('login-cancel-link')}[/@helpers.link]
        </p>
      [/#if]
      <form action="${request.contextPath}/oauth2/authorize" method="POST" class="full">
        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="showPasswordField"/]
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.hidden name="loginId"/]
        [/#if]

        <fieldset>
          [@helpers.input type="text" name="loginId" id="loginId" autocomplete="username" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=(!loginId?has_content) placeholder=theme.message('loginId') leftAddon="user" disabled=(showPasswordField && hasDomainBasedIdentityProviders)/]
          [#if showPasswordField]
            [@helpers.input type="password" name="password" id="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message('password') leftAddon="lock"/]
          [/#if]
        </fieldset>

        <div class="form-row">
          [#if showPasswordField]
            [@helpers.button icon="key" text=theme.message('submit')/]
            [@helpers.link url="${request.contextPath}/password/forgot"]${theme.message('forgot-your-password')}[/@helpers.link]
          [#else]
            [@helpers.button icon="arrow-right" text=theme.message('next')/]
          [/#if]
        </div>
      </form>
      <div>
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message('sign-in-as-different-user')}[/@helpers.link]
        [/#if]
      </div>
      [#if application.registrationConfiguration.enabled]
        <div class="form-row push-top">
          ${theme.message('dont-have-an-account')}
          [@helpers.link url="${request.contextPath}/oauth2/register"]${theme.message('create-an-account')}[/@helpers.link]
        </div>
      [/#if]
      [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=passwordlessEnabled/]
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]
