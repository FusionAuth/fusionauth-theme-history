[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- Below are the main blocks for all of the themeable pages --]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="bypassTheme" type="boolean" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="consents" type="java.util.Map<java.util.UUID, java.util.List<java.lang.String>>" --]
[#-- @ftlvariable name="editPasswordOption" type="java.lang.String" --]
[#-- @ftlvariable name="locale" type="java.util.Locale" --]
[#-- @ftlvariable name="loginTheme" type="io.fusionauth.domain.Theme.Templates" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="response_mode" type="java.lang.String" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="theme" type="io.fusionauth.domain.Theme" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]

[#macro html]
<!DOCTYPE html>
<html lang="en">
  [#nested/]
</html>
[/#macro]

[#macro head title="Login | FusionAuth" author="FusionAuth" description="User Management Redefined. A Single Sign-On solution for your entire enterprise."]
<head>
  <title>${title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="application-name" content="FusionAuth">
  <meta name="author" content="FusionAuth">
  <meta name="description" content="${description}">
  <meta name="robots" content="index, follow">

  [#-- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy --]
  <meta name="referrer" content="strict-origin">

  [#--  Browser Address bar color --]
  <meta name="theme-color" content="#ffffff">

  [#-- Begin Favicon Madness
       You can check if this is working using this site https://realfavicongenerator.net/
       Questions about icon names and sizes? https://realfavicongenerator.net/faq#.XrBnPJNKg3g --]

  [#-- Apple & iOS --]
  <link rel="apple-touch-icon" sizes="57x57" href="/images/apple-icon-57x57.png">
  <link rel="apple-touch-icon" sizes="60x60" href="/images/apple-icon-60x60.png">
  <link rel="apple-touch-icon" sizes="72x72" href="/images/apple-icon-72x72.png">
  <link rel="apple-touch-icon" sizes="76x76" href="/images/apple-icon-76x76.png">
  <link rel="apple-touch-icon" sizes="114x114" href="/images/apple-icon-114x114.png">
  <link rel="apple-touch-icon" sizes="120x120" href="/images/apple-icon-120x120.png">
  <link rel="apple-touch-icon" sizes="144x144" href="/images/apple-icon-144x144.png">
  <link rel="apple-touch-icon" sizes="152x152" href="/images/apple-icon-152x152.png">
  <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-icon-180x180.png">

  [#--  Android Icons --]
  <link rel="manifest" href="/images/manifest.json">

  [#-- IE 11+ configuration --]
  <meta name="msapplication-config" content="/images/browserconfig.xml" />

  [#-- Windows 8 Compatible --]
  <meta name="msapplication-TileColor" content="#ffffff">
  <meta name="msapplication-TileImage" content="/images/ms-icon-144x144.png">

  [#--  Standard Favicon Fare --]
  <link rel="icon" type="image/png" sizes="16x16" href="/images/favicon-16x16.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/images/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="96x96" href="/images/favicon-96x96.png">
  <link rel="icon" type="image/png" sizes="128" href="/images/favicon-128.png">

  [#-- End Favicon Madness --]

  <link rel="stylesheet" href="/css/font-awesome-4.7.0.min.css"/>
  <link rel="stylesheet" href="/css/fusionauth-style.css?version=${version}"/>

  [#-- Theme Stylesheet, only Authorize defines this boolean.
       Using the ?no_esc on the stylesheet to allow selectors that contain a > symbols.
       Once insde of a style tag we are safe and the stylesheet is validated not to contain an end style tag --]
  [#if !(bypassTheme!false)]
    <style>
    ${theme.stylesheet()?no_esc}
    </style>
  [/#if]

  <script src="${request.contextPath}/js/prime-min-1.5.3.js?version=${version}"></script>
  <script src="/js/oauth2/LocaleSelect.js?version=${version}"></script>
  <script>
    "use strict";
    Prime.Document.onReady(function() {
      Prime.Document.query('.alert').each(function(e) {
        var dismissButton = e.queryFirst('a.dismiss-button');
        if (dismissButton !== null) {
          new Prime.Widgets.Dismissable(e, dismissButton).initialize();
        }
      });
      Prime.Document.query('[data-tooltip]').each(function(e) {
        new Prime.Widgets.Tooltip(e).withClassName('tooltip').initialize();
      });
      Prime.Document.query('.date-picker').each(function(e) {
        new Prime.Widgets.DateTimePicker(e).withDateOnly().initialize();
      });
      [#-- You may optionally remove the Locale Selector, or it may not be on every page. --]
      var localeSelect = Prime.Document.queryById('locale-select');
      if (localeSelect !== null) {
        new FusionAuth.OAuth2.LocaleSelect(localeSelect);
      }
    });
    FusionAuth.Version = "${version}";
  </script>

  [#-- The nested, page-specific head HTML goes here --]
  [#nested/]

</head>
[/#macro]

[#macro body]
<body class="app-sidebar-closed">
<main>
  [#nested/]
</main>
</body>
[/#macro]

[#macro header]
  <header class="app-header">
    <div class="right-menu" [#if request.requestURI == "/"]style="display: block !important;" [/#if]>
      <nav>
        <ul>
          [#if request.requestURI == "/"]
            <li><a href="${request.contextPath}/admin/" title="Administrative login"><i class="fa fa-lock" style="font-size: 18px;"></i></a></li>
          [#elseif request.requestURI?starts_with("/account")]
            <li><a href="${request.contextPath}/account/logout?client_id=${client_id!''}" title="Logout"><i class="fa fa-sign-out"></i></a></li>
          [#else]
            <li class="help"><a target="_blank" href="https://fusionauth.io/docs"><i class="fa fa-question-circle-o"></i> ${theme.message("help")}</a></li>
          [/#if]
        </ul>
      </nav>
    </div>
  </header>

  [#nested/]
[/#macro]

[#macro alternativeLoginsScript clientId identityProviders]
  [#if identityProviders["Apple"]?has_content]
    <script src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>
    <script src="/js/identityProvider/Apple.js?version=${version}"></script>
  [/#if]
  [#if identityProviders["Facebook"]?has_content]
    <script src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script src="/js/identityProvider/Facebook.js?version=${version}" data-app-id="${identityProviders["Facebook"][0].lookupAppId(clientId)}"></script>
  [/#if]
  [#if identityProviders["Google"]?has_content]
    <script src="https://apis.google.com/js/api:client.js"></script>
    <script src="/js/identityProvider/Google.js?version=${version}" data-client-id="${identityProviders["Google"][0].lookupClientId(clientId)}"></script>
  [/#if]
  [#if identityProviders["Twitter"]?has_content]
    [#-- This is the FusionAuth clientId --]
    <script src="/js/identityProvider/Twitter.js?version=${version}" data-client-id="${clientId}"></script>
  [/#if]
  [#if identityProviders["OpenIDConnect"]?has_content || identityProviders["SAMLv2"]?has_content || identityProviders["LinkedIn"]?has_content]
    <script src="/js/identityProvider/Redirect.js?version=${version}"></script>
  [/#if]
[/#macro]

[#macro main title="Login" rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4"]
<main class="page-body container">
  [@printErrorAlerts rowClass colClass/]
  [@printInfoAlerts rowClass colClass/]
  <div class="${rowClass}">
    <div class="${colClass}">
      <div class="panel">
        [#if title?has_content]
          <h2>${title}</h2>
        [/#if]
        <main>
          [#nested/]
        </main>
      </div>
    </div>
  </div>
  <div class="${rowClass}">
    <div class="${colClass}">
      [@localSelector/]
    </div>
  </div>
</main>
[/#macro]

[#macro accountMain rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4" actionURL="" actionText="Go back" actionDirection="back"]
<main class="page-body container">
  [@printErrorAlerts rowClass colClass/]
  [@printInfoAlerts rowClass colClass/]
  <div class="${rowClass}">
    <div class="${colClass}">
      [#nested/]
    </div>
  </div>
  [@accountFooter rowClass "col-xs-6 col-sm-6 col-md-5 col-lg-4" actionURL actionText actionDirection/]
</main>
[/#macro]

[#macro localSelector]
<label class="select">
  <select id="locale-select" name="locale" class="select">
    <option value="en" [#if locale == 'en']selected[/#if]>English</option>
      [#list theme.additionalLocales() as l]
        <option value="${l}" [#if locale == l]selected[/#if]>${l.getDisplayLanguage(locale)}</option>
      [/#list]
  </select>
</label>
[/#macro]

[#macro accountFooter rowClass colClass actionURL actionText actionDirection]
<div class="${rowClass}">
  <div class="${colClass}">
    [@localSelector/]
  </div>
  <div class="${colClass}" style="text-align: right;">
  [#if actionURL?has_content]
    [#if !actionURL?contains("client_id")]
      [#if actionURL?contains("?")]
       [#local actionURL = actionURL + "&client_id=${client_id}"/]
      [#else]
       [#local actionURL = actionURL + "?client_id=${client_id}"/]
      [/#if]
    [/#if]
    [#if actionDirection == "back"]
      <a href="${actionURL}"> <i class="fa fa-arrow-left"></i> ${actionText}</a>
    [#else]
      <a href="${actionURL}">${actionText} <i class="fa fa-arrow-right"></i></a>
    [/#if]
  [/#if]
  </div>
</div>
[/#macro]

[#macro accountPanelFull title=""]
<div class="panel">
  [#if title?has_content]
    <h2>${title}</h2>
  [/#if]
  <main>
    [#nested/]
  </main>
</div>
[/#macro]

[#macro accountPanel title tenant user action showEdit]
<div class="panel">
  [#if title?has_content]
    <h2>${title}</h2>
  [/#if]
  <main>
   <div class="row mb-5 user-details">
      [#-- Column 1 --]
      <div class="col-xs-12 col-md-4 col-lg-4 tight-left" style="padding-bottom: 0;">
        <div class="avatar pr-2">
          <div>
            [#if user.imageUrl??]
              <img src="${user.imageUrl}" class="profile w-100" alt="profile image"/>
            [#elseif user.lookupEmail()??]
              <img src="${function.gravatar(user.lookupEmail(), 200)}" class="profile w-100" alt="profile image"/>
            [#else]
              <img src="${request.contextPath}/images/missing-user-image.svg" class="profile w-100" alt="profile image"/>
            [/#if]
          </div>
          <div>${display(user, "name")}</div>
       </div>
      </div>
      [#-- Column 2 --]
      <div class="col-xs-12 col-md-8 col-lg-8 tight-left">
        [#nested/]
      </div>
      [#if action == "view"]
        <div class="panel-actions">
         <div class="status">
           [#if showEdit]
            <a id="edit-profile" class="blue icon" href="/account/edit?client_id=${client_id}">
              <span style="font-size: 0.9rem;">
              <i class="fa fa-pencil blue-text" data-tooltip="${theme.message("edit-profile")}"></i>
              </span>
            </a>
           [/#if]
         </div>
       </div>
      [/#if]
  </div>
  </main>
</div>
[/#macro]

[#macro footer]
  [#nested/]

  [#-- Powered by FusionAuth branding. This backlink helps FusionAuth web ranking so more
       people can find us! However, we always want to give the developer choice, remove this if you like. --]
  <div style="position: fixed; bottom: 5px; right: 0; padding-bottom: 5px; padding-right: 10px;">
    <span style="padding-right: 5px;">Powered by </span>
    <a href="https://fusionauth.io" title="The best developer IAM in the universe!">
      <img src="/images/logo-gray.svg" alt="FusionAuth" height="24" style="margin-bottom: -7px;">
    </a>
  </div>
[/#macro]

[#-- Below are the social login buttons and helpers --]
[#macro appleButton identityProvider clientId]
 [#-- https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/ --]
 <button id="apple-login-button" class="apple login-button" data-scope="${identityProvider.lookupScope(clientId)!''}" data-services-id="${identityProvider.lookupServicesId(clientId)}">
   <div>
     <div class="icon">
      <svg version="1.1" viewBox="4 6 30 30" xmlns="http://www.w3.org/2000/svg">
        <g id="Left-Black-Logo-Large" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
          <path class="cls-1" d="M19.8196726,13.1384615 C20.902953,13.1384615 22.2608678,12.406103 23.0695137,11.4296249 C23.8018722,10.5446917 24.3358837,9.30883662 24.3358837,8.07298156 C24.3358837,7.9051494 24.3206262,7.73731723 24.2901113,7.6 C23.0847711,7.64577241 21.6353115,8.4086459 20.7656357,9.43089638 C20.0790496,10.2090273 19.4534933,11.4296249 19.4534933,12.6807374 C19.4534933,12.8638271 19.4840083,13.0469167 19.4992657,13.1079466 C19.5755531,13.1232041 19.6976128,13.1384615 19.8196726,13.1384615 Z M16.0053051,31.6 C17.4852797,31.6 18.1413509,30.6082645 19.9875048,30.6082645 C21.8641736,30.6082645 22.2761252,31.5694851 23.923932,31.5694851 C25.5412238,31.5694851 26.6245041,30.074253 27.6467546,28.6095359 C28.7910648,26.9312142 29.2640464,25.2834075 29.2945613,25.2071202 C29.1877591,25.1766052 26.0904927,23.9102352 26.0904927,20.3552448 C26.0904927,17.2732359 28.5316879,15.8848061 28.6690051,15.7780038 C27.0517133,13.4588684 24.5952606,13.3978385 23.923932,13.3978385 C22.1082931,13.3978385 20.6283185,14.4963764 19.6976128,14.4963764 C18.6906198,14.4963764 17.36322,13.4588684 15.7917006,13.4588684 C12.8012365,13.4588684 9.765,15.9305785 9.765,20.5993643 C9.765,23.4982835 10.8940528,26.565035 12.2824825,28.548506 C13.4725652,30.2268277 14.5100731,31.6 16.0053051,31.6 Z" id="���"  fill-rule="nonzero"></path>
        </g>
      </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro facebookButton identityProvider clientId]
 <button id="facebook-login-button" class="facebook login-button" data-permissions="${identityProvider.lookupPermissions(clientId)!''}">
   <div>
     <div class="icon">
       <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 216 216">
         <path class="cls-1" d="M204.1 0H11.9C5.3 0 0 5.3 0 11.9v192.2c0 6.6 5.3 11.9 11.9 11.9h103.5v-83.6H87.2V99.8h28.1v-24c0-27.9 17-43.1 41.9-43.1 11.9 0 22.2.9 25.2 1.3v29.2h-17.3c-13.5 0-16.2 6.4-16.2 15.9v20.8h32.3l-4.2 32.6h-28V216h55c6.6 0 11.9-5.3 11.9-11.9V11.9C216 5.3 210.7 0 204.1 0z"></path>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro googleButton identityProvider clientId]
 <button id="google-login-button" class="google login-button" data-scope="${identityProvider.lookupScope(clientId)!''}">
   <div>
     <div class="icon">
       <svg version="1.1" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
         <g>
           <path class="cls-1" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
           <path class="cls-2" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
           <path class="cls-3" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
           <path class="cls-4" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
           <path class="cls-5" d="M0 0h48v48H0z"></path>
         </g>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro linkedInBottom identityProvider clientId]
 <button id="linkedin-login-button" class="linkedin login-button" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon">
       <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
            viewBox="0 0 382 382" style="enable-background:new 0 0 382 382;" xml:space="preserve">
       <path style="fill:#0077B7;" d="M347.445,0H34.555C15.471,0,0,15.471,0,34.555v312.889C0,366.529,15.471,382,34.555,382h312.889
        C366.529,382,382,366.529,382,347.444V34.555C382,15.471,366.529,0,347.445,0z M118.207,329.844c0,5.554-4.502,10.056-10.056,10.056
        H65.345c-5.554,0-10.056-4.502-10.056-10.056V150.403c0-5.554,4.502-10.056,10.056-10.056h42.806
        c5.554,0,10.056,4.502,10.056,10.056V329.844z M86.748,123.432c-22.459,0-40.666-18.207-40.666-40.666S64.289,42.1,86.748,42.1
        s40.666,18.207,40.666,40.666S109.208,123.432,86.748,123.432z M341.91,330.654c0,5.106-4.14,9.246-9.246,9.246H286.73
        c-5.106,0-9.246-4.14-9.246-9.246v-84.168c0-12.556,3.683-55.021-32.813-55.021c-28.309,0-34.051,29.066-35.204,42.11v97.079
        c0,5.106-4.139,9.246-9.246,9.246h-44.426c-5.106,0-9.246-4.14-9.246-9.246V149.593c0-5.106,4.14-9.246,9.246-9.246h44.426
        c5.106,0,9.246,4.14,9.246,9.246v15.655c10.497-15.753,26.097-27.912,59.312-27.912c73.552,0,73.131,68.716,73.131,106.472
        L341.91,330.654L341.91,330.654z"/>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro twitterButton identityProvider clientId]
 <button id="twitter-login-button" class="twitter login-button">
   <div>
     <div class="icon">
       <svg version="1.1" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
         <g>
           <rect class="cls-1" width="400" height="400"></rect>
         </g>
         <g>
           <path class="cls-2" d="M153.62,301.59c94.34,0,145.94-78.16,145.94-145.94,0-2.22,0-4.43-.15-6.63A104.36,104.36,0,0,0,325,122.47a102.38,102.38,0,0,1-29.46,8.07,51.47,51.47,0,0,0,22.55-28.37,102.79,102.79,0,0,1-32.57,12.45,51.34,51.34,0,0,0-87.41,46.78A145.62,145.62,0,0,1,92.4,107.81a51.33,51.33,0,0,0,15.88,68.47A50.91,50.91,0,0,1,85,169.86c0,.21,0,.43,0,.65a51.31,51.31,0,0,0,41.15,50.28,51.21,51.21,0,0,1-23.16.88,51.35,51.35,0,0,0,47.92,35.62,102.92,102.92,0,0,1-63.7,22A104.41,104.41,0,0,1,75,278.55a145.21,145.21,0,0,0,78.62,23"></path>
           <rect class="cls-3" width="400" height="400"></rect>
         </g>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro openIDConnectButton identityProvider clientId]
 <button class="openid login-button" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon">
       [#if identityProvider.lookupButtonImageURL(clientId)?has_content]
         <img src="${identityProvider.lookupButtonImageURL(clientId)}" title="OpenID Connect Logo" alt="OpenID Connect Logo"/>
       [#else]
         <svg version="1.1" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
           <g id="g2189">
             <g id="g2202">
               <path class="cls-1" d="M87.57,39.57c-8.9-5.55-21.38-9-34.95-9C25.18,30.59,3,44.31,3,61.17,3,76.64,21.46,89.34,45.46,91.52v-8.9c-16.12-2-28.24-10.87-28.24-21.45,0-12,15.84-21.9,35.4-21.9,9.78,0,18.6,2.41,24.95,6.43l-9,5.62H96.84V33.8Z"></path>
               <path class="cls-2" d="M45.46,15.41v76l14.23-8.9V6.22Z"></path>
             </g>
           </g>
         </svg>
       [/#if]
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro samlv2Button identityProvider clientId]
 <button class="samlv2 login-button" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon">
       [#if identityProvider.lookupButtonImageURL(clientId)?has_content]
         <img src="${identityProvider.lookupButtonImageURL(clientId)}" title="SAML Login" alt="SAML Login"/>
       [#else]
         <img src="/images/identityProviders/samlv2.svg" title="SAML 2 Logo" alt="SAML 2 Logo"/>
       [/#if]
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro alternativeLogins clientId identityProviders passwordlessEnabled]
  [#if identityProviders?has_content || passwordlessEnabled]
    <div class="login-button-container">
      <div class="hr-container">
        <hr>
        <div>${theme.message('or')}</div>
      </div>

      [#if passwordlessEnabled]
      <div class="form-row push-less-top">
        [@link url = "/oauth2/passwordless"]
          <div class="magic login-button">
            <div>
              <div class="icon">
                <i class="fa fa-link"></i>
              </div>
              <div class="text">${theme.message('passwordless-button-text')}</div>
            </div>
          </div>
        [/@link]
      </div>
      [/#if]

      [#if identityProviders["Apple"]?has_content]
      <div class="form-row push-less-top">
        [@appleButton identityProvider=identityProviders["Apple"][0] clientId=clientId /]
      </div>
      [/#if]

      [#if identityProviders["Facebook"]?has_content]
      <div class="form-row push-less-top">
        [@facebookButton identityProvider=identityProviders["Facebook"][0] clientId=clientId /]
      </div>
      [/#if]

      [#if identityProviders["Google"]?has_content]
      <div class="form-row push-less-top">
        [@googleButton identityProvider=identityProviders["Google"][0] clientId=clientId/]
      </div>
      [/#if]

      [#if identityProviders["LinkedIn"]?has_content]
      <div class="form-row push-less-top">
        [@linkedInBottom identityProvider=identityProviders["LinkedIn"][0] clientId=clientId/]
      </div>
      [/#if]

      [#if identityProviders["Twitter"]?has_content]
      <div class="form-row push-less-top">
        [@twitterButton identityProvider=identityProviders["Twitter"][0] clientId=clientId/]
      </div>
      [/#if]

      [#if identityProviders["OpenIDConnect"]?has_content]
        [#list identityProviders["OpenIDConnect"] as identityProvider]
          <div class="form-row push-less-top">
            [@openIDConnectButton identityProvider=identityProvider clientId=clientId/]
          </div>
        [/#list]
      [/#if]

      [#if identityProviders["SAMLv2"]?has_content]
        [#list identityProviders["SAMLv2"] as identityProvider]
          <div class="form-row push-less-top">
            [@samlv2Button identityProvider=identityProvider clientId=clientId/]
          </div>
        [/#list]
      [/#if]
    </div>
  [/#if]
[/#macro]

[#-- Below are the helpers for errors and alerts --]

[#macro printErrorAlerts rowClass colClass]
  [#if errorMessages?size > 0]
    [#list errorMessages as m]
      [@alert message=m type="error" icon="exclamation-circle" rowClass=rowClass colClass=colClass/]
    [/#list]
  [/#if]
[/#macro]

[#macro printInfoAlerts rowClass colClass]
  [#if infoMessages?size > 0]
    [#list infoMessages as m]
      [@alert message=m type="info" icon="info-circle" rowClass=rowClass colClass=colClass/]
    [/#list]
  [/#if]
[/#macro]

[#macro alert message type icon includeDismissButton=true rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4"]
<div class="${rowClass}">
  <div class="${colClass}">
    <div class="alert ${type}">
      <i class="fa fa-${icon}"></i>
      <p>
        ${message}
      </p>
      [#if includeDismissButton]
        <a href="#" class="dismiss-button"><i class="fa fa-times-circle"></i></a>
      [/#if]
    </div>
  </div>
</div>
[/#macro]

[#-- Below are the input helpers for hidden, text, buttons, labels and form errors.
     These fields are general purpose and can be used on any form you like. --]

[#-- Hidden Input --]
[#macro hidden name value="" dateTimeFormat=""]
  [#if !value?has_content]
    [#local value=("((" + name + ")!'')")?eval?string/]
  [/#if]
  <input type="hidden" name="${name}" [#if value == ""]value="${value}" [#else]value="${value?string}"[/#if]/>
  [#if dateTimeFormat != ""]
  <input type="hidden" name="${name}@dateTimeFormat" value="${dateTimeFormat}"/>
  [/#if]
[/#macro]

[#-- Input field of optional type: [number | password | text --]
[#macro input type name id autocapitalize="none" autocomplete="on" autocorrect="off" autofocus=false spellcheck="false" label="" placeholder="" leftAddon="" required=false tooltip="" disabled=false class="" dateTimeFormat=""]
<div class="form-row">
  [#if label?has_content]
  [#compress]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
    </label>
  [/#compress]
  [/#if]
  [#if leftAddon?has_content]
  <div class="input-addon-group">
    <span class="icon"><i class="fa fa-${leftAddon}"></i></span>
  [/#if]
  [#local value=("((" + name + ")!'')")?eval/]
      <input id="${id}" type="${type}" name="${name}" [#if type != "password"]value="${value}"[/#if] class="${class}" autocapitalize="${autocapitalize}" autocomplete="${autocomplete}" autocorrect="${autocorrect}" spellcheck="${spellcheck}" [#if autofocus]autofocus="autofocus"[/#if] placeholder="${placeholder}" [#if disabled]disabled="disabled"[/#if]/>
  [#if dateTimeFormat != ""]
      <input type="hidden" name="${name}@dateTimeFormat" value="${dateTimeFormat}"/>
  [/#if]
  [#if leftAddon?has_content]
  </div>
  [/#if]
  [@errors field=name/]
</div>
[/#macro]

[#-- Select --]
[#macro select name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="select" options=[]]
<div class="form-row">
  [#if label?has_content]
  [#compress]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
    </label>
  [/#compress]
  [/#if]
  <label class="select">
    [#local value=("((" + name + ")!'')")?eval/]
    [#if name == "user.timezone" || name == "registration.timezone"]
      <select id="${id}" class="${class}" name="${name}">
        [#list timezones as option]
          [#local selected = value == option/]
          <option value="${option}" [#if selected]selected="selected"[/#if] >${option}</option>
        [/#list]]
      </select>
    [#else]
    <select id="${id}" class="${class}" name="${name}">
      [#list options as option]
        [#local selected = value == option/]
        <option value="${option}" [#if selected]selected="selected"[/#if] >${theme.optionalMessage(option)}</option>
      [/#list]
    </select>
    [/#if]
  </label>
  [@errors field=name/]
</div>
[/#macro]

[#-- Text Area --]
[#macro textarea name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="textarea" placeholder=""]
<div class="form-row">
  <textarea id="${id}" name="${name}" class="${class}">${(name?eval!'')}</textarea>
  [@errors field=name/]
</div>
[/#macro]

[#-- Begin : Used for Advanced Registration.
     The following form controls require a 'field' argument which is only available during registration. --]

[#-- Radio List --]
[#macro radio_list field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="radio-list" options=[]]
<div class="form-row">
  [#if label?has_content]
  [#compress]
  <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
  </label>
  [/#compress]
  [/#if]
  [#local value=("((" + name + ")!'')")?eval/]
  <div id="${id}" class="${class}">
    [#list options as option]
      [#local checked = value == option/]
      [#if field.type == "consent"]
        [#local checked = consents(field.consentId)?? && consents(field.consentId)?contains(option)]
      [/#if]
      <label class="radio"><input type="radio" name="${name}" value="${option}" [#if checked]checked="checked"[/#if]><span class="box"></span><span class="label">${theme.optionalMessage(option)}</span></label>
    [/#list]
  </div>
  [@errors field=name/]
</div>
[/#macro]

[#macro checkbox field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox"]
<div class="form-row">
   <label class="${class}">
     [#local value=("((" + name + ")!'')")?eval/]
     [#local checked = value?has_content]
     [#if field.type == "consent"]
       [#local checked = consents(field.consentId)??]
     [/#if]
     <input id="${id}" type="checkbox" name="${name}" value="${value}" [#if checked]checked="checked"[/#if]>
       <span class="box"></span>
       <span class="label">${theme.optionalMessage(name)}</span>
   </label>
  [@errors field=name/]
</div>
[/#macro]

[#macro checkbox_list field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox-list" options=[]]
<div class="form-row">
  [#if label?has_content][#t/]
  <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if][#t/]
    [#if tooltip?has_content][#t/]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>[#t/]
    [/#if][#t/]
  </label>[#t/]
  [/#if]
  <div id="${id}" class="${class}">
    [#list options as option]
      [#local value=("((" + name + ")!'')")?eval/]
      [#local checked = value?is_sequence && value?seq_contains(option)/]
      [#if field.type == "consent"]
        [#local checked = consents(field.consentId)?? && consents(field.consentId)?contains(option)]
      [/#if]
      <label class="checkbox"><input type="checkbox" name="${name}" value="${option}" [#if checked]checked="checked"[/#if]><span class="box"></span><span class="label">${theme.optionalMessage(option)}</span></label>
    [/#list]
  </div>
  [@errors field=name/]
</div>
[/#macro]

[#macro locale_select field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox-list" options=[]]
  [#local value=("((" + name + ")!'')")?eval/]
  <div class="form-row">
    <div id="${id}" class="${class}">
      [#list fusionAuth.locales() as l, n]
        [#local checked = value?is_sequence && value?seq_contains(l)/]
         <label class="checkbox">
           <input type="checkbox" name="${name}" value="${l}" [#if checked]checked="checked"[/#if]>
           <span class="box"></span>
           <span class="label">${l.getDisplayName()}</span>
         </label>
      [/#list]
    </div>
  </div>
[/#macro]

[#-- End : Used for Advanced Registration. --]

[#macro oauthHiddenFields]
  [@hidden name="client_id"/]
  [@hidden name="code_challenge"/]
  [@hidden name="code_challenge_method"/]
  [@hidden name="metaData.device.name"/]
  [@hidden name="metaData.device.type"/]
  [@hidden name="nonce"/]
  [@hidden name="redirect_uri"/]
  [@hidden name="response_mode"/]
  [@hidden name="response_type"/]
  [@hidden name="scope"/]
  [@hidden name="state"/]
  [@hidden name="tenantId"/]
  [@hidden name="timezone"/]
  [@hidden name="user_code"/]
[/#macro]

[#macro errors field]
[#if fieldMessages[field]?has_content]
<span class="error">[#list fieldMessages[field] as message]${message?no_esc}[#if message_has_next], [/#if][/#list]</span>
[/#if]
[/#macro]

[#macro button text icon="arrow-right" color="blue" disabled=false name="" value=""]
<button class="${color} button${disabled?then(' disabled', '')}"[#if disabled] disabled="disabled"[/#if][#if name !=""]name="${name}"[/#if][#if value !=""]value="${value}"[/#if]><i class="fa fa-${icon}"></i> ${text}</button>
[/#macro]

[#macro link url extraParameters=""]
<a href="${url}?tenantId=${(tenantId)!''}&client_id=${(client_id?url)!''}&nonce=${(nonce?url)!''}&redirect_uri=${(redirect_uri?url)!''}&response_mode=${(response_mode?url)!''}&response_type=${(response_type?url)!''}&scope=${(scope?url)!''}&state=${(state?url)!''}&timezone=${(timezone?url)!''}&metaData.device.name=${(metaData.device.name?url)!''}&metaData.device.type=${(metaData.device.type?url)!''}${extraParameters!''}&code_challenge=${(code_challenge?url)!''}&code_challenge_method=${(code_challenge_method?url)!''}&user_code=${(user_code?url)!''}">
[#nested/]
</a>
[/#macro]

[#macro defaultIfNull text default]
  ${text!default}
[/#macro]

[#macro passwordRules passwordValidationRules]
<div class="font-italic">
  <span>
    ${theme.message('password-constraints-intro')}
  </span>
  <ul>
    <li>${theme.message('password-length-constraint', passwordValidationRules.minLength, passwordValidationRules.maxLength)}</li>
    [#if passwordValidationRules.requireMixedCase]
      <li>${theme.message('password-case-constraint')}</li>
    [/#if]
    [#if passwordValidationRules.requireNonAlpha]
      <li>${theme.message('password-alpha-constraint')}</li>
    [/#if]
    [#if passwordValidationRules.requireNumber]
      <li>${theme.message('password-number-constraint')}</li>
    [/#if]
    [#if passwordValidationRules.rememberPreviousPasswords.enabled]
      <li>${theme.message('password-previous-constraint', passwordValidationRules.rememberPreviousPasswords.count)}</li>
    [/#if]
  </ul>
</div>
[/#macro]

[#macro customField field key autofocus=false placeholder="" label="" leftAddon="true"]
  [#assign fieldId = field.key?replace(".", "_") /]
  [#local leftAddon = (leftAddon == "true")?then(field.data.leftAddon!'info', "") /]

  [#if field.key == "user.preferredLanguages" || field.key == "registration.preferredLanguages"]
    [@locale_select field=field id=fieldId name=field.key required=field.required autofocus=autofocus label=label /]
  [#elseif field.control == "checkbox"]
    [#if field.options?has_content]
      [@checkbox_list field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
    [#else]
      [@checkbox field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label /]
    [/#if]
  [#elseif field.control == "number"]
    [@input id="${fieldId}" type="number" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
  [#elseif field.control == "password"]
    [@input id="${fieldId}" type="password" name="${key}" leftAddon="lock" autocomplete="new-password" autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder)/]
  [#elseif field.control == "radio"]
    [@radio_list field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
  [#elseif field.control == "select"]
    [@select id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
  [#elseif field.control == "textarea"]
    [@textarea id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
  [#elseif field.control == "text"]
    [#if field.type == "date"]
      [@input id="${fieldId}" type="text" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) class="date-picker" dateTimeFormat="yyyy-MM-dd" /]
    [#else]
      [@input id="${fieldId}" type="text" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder)/]
    [/#if]
  [/#if]
[/#macro]

[#function display object propertyName default="\x2013" ]
  [#assign value=("((object." + propertyName + ")!'')")?eval/]
  [#-- ?has_content is false for boolean types, check it first --]
  [#if value?has_content]
    [#if value?is_number]
      [#return value?string('#,###')]
    [#else]
      [#return (value == default?is_markup_output?then(default?markup_string, default))?then(value, value?string)]
    [/#if]
  [#else]
    [#return default]
  [/#if]
[/#function]

[#macro passwordField field]
  [#-- Render checkbox used to determine whether the form submit should update password--]
  <div class="form-row">
    <label for="editPasswordOption"> ${theme.optionalMessage("change-password")} </label>
    <input type="hidden" name="__cb_editPasswordOption" value="useExisting">
    <label class="toggle">
      <input id="editPasswordOption" type="checkbox" name="editPasswordOption" value="update" data-slide-open="password-fields" [#if editPasswordOption == "update"]checked[/#if]>
      <span class="rail"></span>
      <span class="pin"></span>
    </label>
  </div>
  <div id="password-fields" class="slide-open ${(editPasswordOption == "update")?then('open', '')}">
    [#-- Show the Password Validation Rules if there is a field error for 'user.password' --]
    [#if (fieldMessages?keys?seq_contains("user.password")!false) && passwordValidationRules??]
      [@passwordRules passwordValidationRules/]
    [/#if]

    [#-- Render password field--]
    [@customField field=field key=field.key autofocus=false placeholder=field.key label=theme.optionalMessage(field.key) leftAddon="false"/]

    [#-- Render confirm if set to true on the field     --]
    [#if field.confirm]
      [@customField field "confirm.${field.key}" false "[confirm]${field.key}" /]
    [/#if]
  </div>
[/#macro]