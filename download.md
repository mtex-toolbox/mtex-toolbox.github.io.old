---
title: Download
layout: main
---

### Installation ###

1. download and extract the zip file to an arbitrary folder
2. start Matlab
3. change the current folder in Matlab to the folder where MTEX is installed
4. type `startup_mtex` into the command window

In case you experience any problems have a look at our [trouble shooting page]()

### Downloads ###

File Name  |||  Release Date||| Comments ||| Downloads
:-|-|-|:-|-|-|:-|-|-|-
[**mtex-4.0.17.zip**](https://github.com/mtex-toolbox/mtex/releases/download/mtex-4.0.17/mtex-4.0.17.zip) ||| April 2015    ||| major release with many new features and syntax changes, [changelog](files/doc/changelog.html) ||| no idea
[**mtex-3.5.0.zip**](http://mtex.googlecode.com/files/mtex-3.5.0.zip) ||| December 2013   ||| minor release, [changelog]()||| 2090
[**mtex-3.4.2.zip**](http://mtex.googlecode.com/files/mtex-3.4.2.zip) ||| June 2013       ||| minor release, [changelog]()||| 1514

A full list of previous releases and downloads can be found [here](http://code.google.com/p/mtex/downloads/list).

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.timeago.js"></script>
<script src="js/jquery.fancybox.pack.js?v=2.1.5"></script>

<script type="text/javascript">
    $(document).ready(function () {
        GetLatestReleaseInfo();
    });

    function GetLatestReleaseInfo() {
        $.getJSON("https://api.github.com/repos/ShareX/ShareX/releases").done(function (json) {
            var release = json[0];
            var asset = release.assets[0];
            var downloadURL = "https://github.com/ShareX/ShareX/releases/download/" + release.tag_name + "/" + asset.name;
            var downloadCount = 0;
            for (var i = 0; i < release.assets.length; i++) {
                downloadCount += release.assets[i].download_count;
            }
            var releaseInfo = release.name + " was updated " + $.timeago(asset.updated_at) + " and downloaded " + downloadCount + " times.";
            $(".sharex-download").attr("href", downloadURL);
            $(".release-info").text(releaseInfo);
            $(".release-info").fadeIn("slow");
        });
    }
</script>
