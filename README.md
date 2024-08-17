# FusionAuth Theme History

Here you can compare different versions of the default, stock FusionAuth theme.

This can be useful when there is a new release and you have customized the FusionAuth theme. FusionAuth provides default values for new theme pages, but reviewing this repository can help you prepare and also notice smaller changes, such as new sections or parameters.

To use:

* Go to https://github.com/FusionAuth/fusionauth-theme-history/compare/
* Click the `base` button. 
* Click the `tags` tab.
* Choose the earlier version you are interested in comparing.
* Click the `compare` button.
* Click the `tags` tab.
* Choose the later version you are interested in comparing.

## Differences

With this history, you can review the differences between the versions, which can help you determine what changes need to be made to our custom themes.

An example of seeing differences using GitHub's UX: https://github.com/FusionAuth/fusionauth-theme-history/compare/1.23.3...1.26.0

How to get a set of patches, assuming you've cloned these: `git format-patch tag1..tag2`

How to apply patches to an existing downloaded theme: TBD, but here's the [git apply documentation](https://git-scm.com/docs/git-apply).

## Gaps

If you look at the [FusionAuth release notes](https://fusionauth.io/docs/release-notes/) and compare them to the tags in this repository, you may note some gaps.

These are typically due to docker images that were yanked because of a bug or other issue and are not recommended as versions to use.

## Simple Themes

If you are using FusionAuth simple theming, introduced into 1.51 release (Theming Toucan), this history is not useful, because it only applies to the FusionAuth advanced themes.

## Learn More

Learn more about FusionAuth themes: https://fusionauth.io/docs/customize/look-and-feel/
