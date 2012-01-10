<%@ page import="edu.harvard.rssreader.RssChannel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <script type="text/javascript" src="https://www.google.com/jsapi?key=ABQIAAAAI0NvLcZ6AIGrsXWrV_Jg-BR-ItZtfys1-SV2ohcoJiTTIODY5BTzpB-20zoANEkxvOSGQhczVckEIA"></script>
    	<script type="text/javascript">
    		// <![CDATA[  
    		google.load("feeds", "1");
			function initialize() {
				var channels = ${channelList};
				var display_title = ${readerTopic.displayTitle};
				var display_date = ${readerTopic.displayDate};
				var display_desc = ${readerTopic.displayDescription};
				var display_count = ${readerTopic.displayNumberOfItems};
				if ( display_count == 'all' ) {
					display_count = 100;
				}
				if ( display_count == '' || display_count == null) {
					display_count = 4;
				}
								
				var outercontainer = document.getElementById('rss-reader-content-${pageContentId}');
				//for (var channel in channels) {
				var i = 0;
				$(channels).each(function(){
					var feed = new google.feeds.Feed(this.source);
					var container = $(outercontainer).children()[i];
					i++;
					
					feed.setNumEntries(display_count);
					feed.load(function(result) {
					  if (!result.error) {
						var feed_html = '';
						feed_html += '<div class="rss_feed">';
						if ( display_title == 1 ) {
							feed_html += '<h3 class="rss_feed_title">' + result.feed.title + '</h3>';  
						}
						for (var i = 0; i < result.feed.entries.length; i++) {
						  var entry = result.feed.entries[i];
						  if ( entry.publishedDate ) {
							  var pdate = new Date(entry.publishedDate);
							  entry.localPublishedDate = pdate.toLocaleDateString() + ' ' + pdate.toLocaleTimeString();
						  }
						  //container.innerHTML += tmpl("item_tmpl",entry);
						  var entry_html;
						  feed_html += '<div class="rss_entry">';
						  
						  feed_html += '<h4 class="rss_entry_title"><a href="'+entry.link+'">'+entry.title+'</a></h4>';		

						  if ( display_date == 1 ) {
							  feed_html += '<p class="rss_entry_pubdate">'+entry.localPublishedDate+'</p>';		
						  }
						  if ( display_desc == 1 ) {
							  feed_html += '<p class="rss_entry_content">'+entry.content+'</p>';		
						  }
						  
						  
						  
						  feed_html += '</div>';
							 
						 }
						 feed_html += "</div>";
						 container.innerHTML += feed_html;

					  }
					});                
				});
			}
        	

			function styleRssFeeds() {
				$('.gfc-result:even').addClass('gfc-resultEven');
				$('.gfc-result:odd').addClass('gfc-resultOdd');
			}
			
    		google.setOnLoadCallback(initialize);
    		]]>
    	</script>
    </head>
    <body>
		<style>
			.rss_entry {
				clear: both;
			}
			.rss_entry_pubdate {
				margin-top: 0em;
				font-style: oblique;
			}
			.rss_entry_title {
				padding-top: 1.5em;
				margin-bottom: 0em;
			}
			.rss_entry_content {
				margin-left: 2em;
				margin-bottom: 1em;
			}
			.rss_hide {
				display: none;
			}
		</style>    	
    	<style>
    		.rss-reader-content{
				margin: 0;
				padding: 0;
			}
			.gfc-resultsHeader{
			    border: none;
			}
			.gfc-title{
				font-family: Arial, sans-serif;
				font-size: 19pt;
				line-height: 29px;
				padding: 20px 0px 20px 0px;
				display:inline-block;/*
				width: 100%;
				border: solid 1px #d2d2d2;*/
			}
			.gf-title {
				height: auto;
			}
			.gf-title a{
				color: #8e0f22;
				padding-bottom: 5px;
			}
			.gf-title a:hover{
				text-decoration:none;
			}
			.gf-author
			, .gf-spacer
			, .gf-relativePublishedDate{
				display:inline-block;
				font-size: 0.8em;
				color: #5d5d5d;
				padding-bottom: 10px;
			}
			.gfc-result{
				padding: 20px 0 20px 20px;
			}
			.gfc-resultOdd{
				background-color:#fff;
			}
			.gfc-resultEven{
				background-color:#f6f6f6;
				border-top: 1px solid #dddddd;
				border-bottom: 1px solid #dddddd;	
			}
    	</style>
    	<div class="rss-reader-content">
   			<div id="rss-reader-content-${pageContentId}">
   				<g:each in="${channels}" var="c">
   				<div> </div>
   				</g:each>
   			</div>
	   	</div>
    </body>
</html>
