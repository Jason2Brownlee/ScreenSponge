/**
 * setups the quick request visual module
 */
function initQuickRequest(domid) {
	YAHOO.namespace("quickrequest.container");
	YAHOO.util.Event
			.onDOMReady( function() {
				YAHOO.quickrequest.container.requestAddModule = new YAHOO.widget.Module(
						'request-module-' + domid, {
							visible :false,
							effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.25}
						});
				YAHOO.quickrequest.container.requestAddModule.render();

				var toogle = false;
				function onToggleRequestButtonClick(event, obj) {
					if (toogle) {
						obj.hide();
						toogle = false;
					} else {
						obj.show();
						toogle = true;
						//obj.cfg.setProperty("visibility","visible")
						document.getElementById("request_message-"+domid).focus();
					}
				}
				YAHOO.util.Event.addListener('toggleRequestButton-' + domid,
						"click", onToggleRequestButtonClick,
						YAHOO.quickrequest.container.requestAddModule);
				YAHOO.util.Event.addListener('cancel-' + domid, "click",
						onToggleRequestButtonClick,
						YAHOO.quickrequest.container.requestAddModule);
			});
}