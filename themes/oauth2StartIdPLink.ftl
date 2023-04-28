[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="registrationEnabled" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [#-- Custom <head> code goes here --]
  [/@helpers.head]

  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.main title=theme.message('start-idp-link-title')]
      <p class="mb-5">
        [#if pendingIdPLink??]
          ${theme.message('pending-link-info', pendingIdPLink.identityProviderName)}<br><br>
        [/#if]
        [#if devicePendingIdPLink?? && pendingIdPLink??]
          ${theme.message('pending-device-links', devicePendingIdPLink.identityProviderName, pendingIdPLink.identityProviderName)}
        [#elseif devicePendingIdPLink??]
          ${theme.message('pending-device-link', devicePendingIdPLink.identityProviderName)}
        [/#if]
        [#if registrationEnabled]
          ${theme.message('pending-link-next-step')}
        [#else]
          ${theme.message('pending-link-next-step-no-registration')}
        [/#if]
      </p>

      <div class="row">
        <div class="col-xs">
        [@helpers.link url="/oauth2/authorize"]
          <button class="blue button w-100" style="height: 35px;"><i class="fa fa-arrow-right"></i> ${theme.message('link-to-existing-user')} </button>
        [/@helpers.link]
        </div>
      </div>

      [#-- If self service registration is enabled, we can also provide an option to register. --]
      [#if registrationEnabled]
       <div class="row mt-3 mb-3">
         <div class="col-xs">
         [@helpers.link url="/oauth2/register"]
           <button class="blue button w-100" style="height: 35px;"> <i class="fa fa-arrow-right"></i> ${theme.message('link-to-new-user')} </button>
         [/@helpers.link]
         </div>
       </div>
      [/#if]

      [#if pendingIdPLink??]
      <div class="hr-container">
        <hr>
        <div>${theme.message('or')}</div>
      </div>

      <div class="row mt-3 mb-3">
        <div class="col-xs">
        [@helpers.link url="/oauth2/authorize" extraParameters="&cancelPendingIdpLink=true"]
          <button class="blue button w-100" style="height: 35px;"><i class="fa fa-arrow-right"></i> ${theme.message('cancel-link')} </button>
        [/@helpers.link]
        </div>
      </div>
      [/#if]

    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]
