[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code" type="java.lang.String" --]
[#-- @ftlvariable name="postMethod" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head/]
  [@helpers.body]
    [#if code?? && postMethod]
      <form action="${request.contextPath}/oauth2/passwordless/${code}" method="POST">
        [@helpers.oauthHiddenFields/]
        <input type="hidden" name="code" value="${code}">
        <input type="hidden" name="postMethod" value="true">
      </form>
      <script type="text/javascript">
        document.forms[0].submit();
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
          </fieldset>

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
