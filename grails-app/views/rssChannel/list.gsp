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
							feed_html += '<h4 class="rss_feed_title">' + result.feed.title + '</h4>';  
						}
						for (var i = 0; i < result.feed.entries.length; i++) {
						  var entry = result.feed.entries[i];
						  if ( entry.publishedDate ) {
							  var pdate = new Date(entry.publishedDate);
							  var h = pdate.getHours();
							  var m = pdate.getMinutes();
							  var dp = "AM";
							  
							  if ( h > 12 ) { h = h-12; dp = "PM";}
							  if ( h == 0 ) { h = 12; }

							  if ( m < 10 ) { m = "0"+m; }
							  
							  entry.localPublishedDate = pdate.toLocaleDateString() + ' ' 
							  + h + ':' + m + ' ' + dp;
						  }
						  //container.innerHTML += tmpl("item_tmpl",entry);
						  var entry_html;

						  // add the resultEven and resultOdd classes:
						  if ( i%2 == 0 ) {
							  feed_html += '<div class="rss_entry resultEven">';
						  }
						  else {
							  feed_html += '<div class="rss_entry resultOdd">';
						  }	
						  					  
						  feed_html += '<h4 class="rss_entry_title"><a href="'+entry.link+'">'+entry.title+'</a></h4>';		

						  if ( display_date == 1 ) {
							  feed_html += '<div class="rss_entry_pubdate">'+entry.localPublishedDate+'</div>';		
						  }
						  if ( display_desc == 1 ) {
							  feed_html += '<div class="rss_entry_content">'+entry.content+'</div>';		
						  }
						  
						  
						  
						  feed_html += '</div>';
							 
						 }
						 feed_html += "</div>";
						 container.innerHTML += feed_html;

					  }
					});                
				});
			}
        				
    		google.setOnLoadCallback(initialize);
    		]]>
    	</script>
    </head>
    <body>
    	<style>
			.rss_feed_title{
				font-family: Arial, sans-serif;
				//line-height: 29px;
				font-size: 2em;
				display:inline-block;
				font-weight: normal; 
				/* width: 100%;
				border: solid 1px #d2d2d2;*/
			}
			
			.rss_entry_title a{
				color: #8e0f22;
				padding-bottom: 5px;
			}
			
			.rss_entry_title a:hover{
				text-decoration:none;
			}
			
			.rss_entry_pubdate{
				display:inline-block;
				font-size: 0.8em;
				color: #5d5d5d;
				padding: 5px 0 10px;
			}
			
			h4.rss_entry_title {margin-bottom:0px;}
			
			.rss_entry{
				padding: 0px 0 10px 20px;
			}
			.resultOdd{
				background-color:#fff;
			}
			
			.resultEven{
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
