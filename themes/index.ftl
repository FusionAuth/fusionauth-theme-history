[#ftl/]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head title="FusionAuth"/]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

     [#--
      Example landing page. You can use a meta refresh (or via JS) to redirect users who land here to your primary site,
       or add some links here to help direct them to different applications.

       For additional details on performing a redirect.
       https://developer.mozilla.org/en-US/docs/Web/HTTP/Redirections#alternative_way_of_specifying_redirections
      --]
      [@helpers.main title="" rowClass="row center-xs" colClass="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xl-9"]
          <div class="p-3 pb-5">
            <div style="width: 180px;">
              <img src="/images/logo-gray.svg">
            </div>
            <p style="font-size: 1.15em;">Welcome!</p>
            <p>
              If you are looking for the FusionAuth admin login, you'll find a lock icon in the top right hand side which will take you there. If you don't have an admin account to FusionAuth, no need to click there you won't get very far. You'll want to theme this page to either redirect to your site, or provide links for your end users to find their applications.
            </p>
            <p>Here are some links to help you get started! Welcome to the FusionAuth community, we're glad to have you!</p>
            <ul style="list-style: none; padding-left: 20px; margin-top: 20px;">
              <li class="pt-2"><i class="fa fa-arrow-right blue-text">&nbsp; <a href="https://fusionauth.io/docs/get-started/">Getting started</a></i></li>
              <li class="pt-2"><i class="fa fa-arrow-right blue-text">&nbsp; <a href="https://fusionauth.io/docs/customize/look-and-feel/">Themes</a></i></li>
              <li class="pt-2"><i class="fa fa-arrow-right blue-text">&nbsp; <a href="https://fusionauth.io/docs/">Documentation</a></i></li>
              <li class="pt-2"><i class="fa fa-arrow-right blue-text">&nbsp; <a href="https://fusionauth.io/community/">Community & Support</a></i></li>
            </ul>
          </div>
      [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]

      [#-- Using an HTML comment so this is visible in the rendered HTML. We don't want to freak anyone out. --]
      <!-- Feel free to remove this, it is just a stupid easter egg. Enjoy. -->
      <!--   "Escape is impossible when you're caught in the net" https://www.imdb.com/title/tt0113957/  -->
      <div style="position:fixed; left:0; bottom: 0; margin-bottom: 7px; margin-left: 10px;"><a style="color: inherit;" href="https://the-praetorians.net" title="Escape is impossible when you're caught in the net.">��</a></div>
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]
