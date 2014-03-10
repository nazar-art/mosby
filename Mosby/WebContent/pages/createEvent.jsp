<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8">
    <title>Create event - Mosby - event management</title>
    <link rel="shortcut icon" href="media/images/favicon.ico">
    <link rel="icon" type="image/png" href="media/images/favicon.png" />
    <meta name="description" content="Mosby - make it simple. New event management system" />

    <meta name="viewport" content="width=1000, initial-scale=1.0, maximum-scale=1.0">

    <!-- Loading Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="css/flat-ui.css" rel="stylesheet">
    <link href="css/pro-features.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">

    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true&libraries=places"></script>
    <script>
        var map, autocomplete, geocoder;

        function initialize() {
            var mapProp = {
                zoom: 15,
                mapTypeControl: true,
                mapTypeControlOptions: {
                    mapTypeIds: [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE],
                    style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
                },
            };

            map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

            // Try HTML5 geolocation
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var pos = new google.maps.LatLng(position.coords.latitude,
                            position.coords.longitude);
                    map.setCenter(pos);
                }, function() {
                    handleNoGeolocation(true);
                });
            } else {
                // Browser doesn't support Geolocation
                handleNoGeolocation(false);
            }

            var input = /** @type {HTMLInputElement} */ (
                    document.getElementById('event-location'));
            autocomplete = new google.maps.places.Autocomplete(input);
            autocomplete.bindTo('bounds', map);

            var infowindow = new google.maps.InfoWindow();
            var marker = new google.maps.Marker({
                map: map
            });

            google.maps.event.addListener(autocomplete, 'place_changed', function() {
                infowindow.close();
                marker.setVisible(false);
                var place = autocomplete.getPlace();
                if (!place.geometry) {
                    return;
                }

                // If the place has a geometry, then present it on a map.
                if (place.geometry.viewport) {
                    map.fitBounds(place.geometry.viewport);
                } else {
                    map.setCenter(place.geometry.location);
                    map.setZoom(17); // Why 17? Because it looks good.
                }
                marker.setPosition(place.geometry.location);
                marker.setVisible(true);

                var address = '';
                if (place.address_components) {
                    address = [
                        (place.address_components[0] && place.address_components[0].short_name || ''), (place.address_components[1] && place.address_components[1].short_name || ''), (place.address_components[2] && place.address_components[2].short_name || '')
                    ].join(' ');
                }

                infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
                infowindow.open(map, marker);
            });
        }

        function handleNoGeolocation(errorFlag) {
            if (errorFlag) {
                var content = 'Error: The Geolocation service failed.';
            } else {
                var content = 'Error: Your browser doesn\'t support geolocation.';
            }

            var options = {
                map: map,
                position: new google.maps.LatLng(60, 105),
                content: content
            };

            var infowindow = new google.maps.InfoWindow(options);
            map.setCenter(options.position);
        }

        function geolocate() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var geolocation = new google.maps.LatLng(
                            position.coords.latitude, position.coords.longitude);
                    autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
                            geolocation));
                });
            }
        }

        google.maps.event.addDomListener(window, 'load', initialize);
    </script>


    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body onload="initialize()">
<div class="container-fluid">
<div class="row">
    <nav class="navbar navbar-default navbar-fixed-top nav-transparent-shrink" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-01">
                <span class="sr-only">Toggle navigation</span>
            </button>
            <a class="navbar-brand" href="#"></a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-collapse-01">
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        Categories
                        <b class="caret"></b>
                    </a>
                    <span class="dropdown-arrow"></span>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#">Business</a>
                        </li>
                        <li>
                            <a href="#">Music</a>
                        </li>
                        <li>
                            <a href="#">Food &amp; Drink</a>
                        </li>
                        <li>
                            <a href="#">Film &amp; Media</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">All</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#">Login</a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="signUp.html">Sign up</a>
                </li>
            </ul>
        </div>
    </nav>
</div>

<div class="row" style="background: #000">
    <div id="background-block" class="flow-img" style="background-image: url(../media/images/bg_mask.png), url(media/images/events/default/concert-smoke.jpg)"></div>
</div>

<div class="row">
<div class="on-background-block-header col-md-10 col-md-offset-1">
    <h4>Create event for free</h4>
</div>
<div class="on-background-block col-md-10 col-md-offset-1">
<div class="hidden-lg hidden-md">
    <h4>Create event for free</h4>
</div>
<form action="createEvent" method="post" id="create-event-form">
<h5>Event Detail</h5>
<div class="form-group">
    <label for="event-name">Event Name</label>
    <input type="text" class="form-control" placeholder="Choose Event Name" name="event_name" id="event-name" required />
</div>
<div class="form-group">
    <label for="event-background">Event Logo</label>
    <div class="input-group">
							<span class="input-group-btn">
								<span class="btn btn-primary btn-file">
									Open
									<input type="file" name="event_logo" id="event-logo" accept="image/*" />
								</span>
							</span>
        <input type="text" class="form-control" readonly="" disabled="disabled">
    </div>
</div>
<div class="form-group">
    <label for="datepicker-start">Start Date &amp; Time</label>
    <div class="input-prepend input-datepicker">
        <button type="button" class="btn">
            <span class="fui-calendar"></span>
        </button>
        <input type="text" placeholder="Start date" name="start_date" id="datepicker-start" readonly="" required>
    </div>
    <input type="time" class="form-control time" value="00:00" name="start_time" required>
</div>
<div class="form-group">
    <label for="datepicker-end">End Date &amp; Time</label>
    <div class="input-prepend input-datepicker">
        <button type="button" class="btn">
            <span class="fui-calendar"></span>
        </button>
        <input type="text" placeholder="End date" name="end_date" id="datepicker-end" readonly="" required>
    </div>
    <input type="time" class="form-control time" value="00:00" name="end_time" required>
</div>


<div class="form-group">
    <label for="event-category">Category</label>
    <select name="event_category" class="select-block" id="event-category" form="create-event-form">
        <option value="select_category">
            Select categoty...
        </option>
        <option value="business">
            Business
        </option>
        <option value="music">
            Music
        </option>
        <option value="food_and_drink">
            Food &amp; Drink
        </option>
        <option value="film_and_media">
            Film &amp; Media
        </option>
        <option value="other">
            Other
        </option>
    </select>
</div>
<div class="form-group">
    <label for="event-type">Type</label>
    <select name="event_type" class="select-block" id="event-type" form="create-event-form">
        <option value="select_type">
            Select type...
        </option>
        <option value="conference">
            Conference
        </option>
        <option value="party">
            Party
        </option>
        <option value="concert">
            Concert
        </option>
        <option value="other">
            Other
        </option>
    </select>
</div>

<div class="form-group">
    <label for="event-background">Event Background</label>
    <div class="input-group">
							<span class="input-group-btn">
								<span class="btn btn-primary btn-file">
									Open
									<input type="file" name="event_background" id="event-background" accept="image/*" />
								</span>
							</span>
        <input type="text" class="form-control" readonly="" disabled="disabled">
    </div>
    <span class="additional-input-info">Select image with big resolution for better result</span>
</div>
<div class="form-group">
    <label for="event-details">Event Description</label>
    <textarea rows="4" placeholder="Tell users about your event" class="form-control" id="event-details" form="create-event-form"></textarea>
</div>
<div class="form-group">
    <label for="event-location">Address</label>
    <input type="text" class="form-control" placeholder="Enter Address for your event" name="event_location" id="event-location" onFocus="geolocate()" />
</div>
<div class="form-group" id="googleMap" style="height:380px;"></div>

<h5>Create Tickets</h5>
<div class="form-group">
    <div id="tickets">
        <div class="row create-tickets-header hidden-xs">
            <div class="col-md-6 col-sm-6">Ticket name</div>
            <div class="col-md-2 col-sm-2">Quantity available</div>
            <div class="col-md-2 col-sm-2">Price</div>
            <div class="col-md-2 col-sm-2 text-center">Actions</div>
        </div>
        <div id="tickets-body">
            <!--
                                            <div id="0" class="row">
                                                <div class="col-md-6 col-sm-6">
                                                    <label class="visible-xs" for="event-ticket-name-0">Ticket name</label>
                                                    <input type="text" class="form-control" placeholder="Examples: Early Bird, VIP, Press" name="event_ticket_name_0" id="event-ticket-name-0" />
                                                </div>
                                                <div class="col-md-2 col-sm-2">
                                                    <label class="visible-xs" for="event-ticket-quantity-0">Quantity available</label>
                                                    <input type="number" class="form-control" placeholder="100" name="event_ticket_quantity_0" id="event-ticket-quantity-0" min="1" />
                                                </div>
                                                <div class="col-md-2 col-sm-2">
                                                    <label class="visible-xs" for="event-ticket-price-0">Price</label>
                                                    <input type="number" class="form-control" placeholder="0" name="event_ticket_price_0" id="event-ticket-price-0" min="0" />
                                                </div>
                                                <div class="col-md-2 col-sm-2 actions text-center">
                                                    <label class="visible-xs text-left">Ticket name</label>
                                                    <a href="#" data-toggle="modal" data-target="#my-modal-0">
                                                        <span class="fui-gear"></span>
                                                    </a>
                                                    <a class="delete-row" href="#">
                                                        <span class="fui-trash"></span>
                                                    </a>
                                                </div>
                                                <div class="modal fade" id="my-modal-0" tabindex="-1" role="dialog" aria-labelledby="my-modal-label-0" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
													<h4 class="modal-title" id="my-modal-label-0">Ticket Settings</h4>
												</div>
												<div class="modal-body">
													<div class="form-group">
														<label for="ticket-description-0">Ticket Description</label>
														<textarea rows="3" placeholder="Additional info about ticket" class="form-control" id="ticket-description-0" form="create-event-form"></textarea>
													</div>
													<div class="form-group">
														<span>Tickets Allowed Per Order</span>
														<label class="additional" for="ticket-min-per-order-0">Min</label>
														<input type="number" class="form-control" placeholder="1" value="1" name="ticket_min_per_order_0" id="ticket-min-per-order-0" min="1" />
														<label class="additional" for="ticket-max-per-order-0">Max</label>
														<input type="number" class="form-control" placeholder="1" name="ticket_max_per_order_0" id="ticket-max-per-order-0" min="1" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
-->
        </div>
    </div>
    <!--END TICKETS-->
</div>
<div class="col-md-3 col-sm-4 add-ticket">
    <a id="free-ticket" href="#fakelink" class="btn btn-block btn-lg btn-primary">
        <span class="fui-plus"></span>Free ticket</a>
</div>
<div class="col-md-3 col-sm-4 add-ticket">
    <a id="paid-ticket" href="#fakelink" class="btn btn-block btn-lg btn-primary">
        <span class="fui-plus"></span>Paid ticket</a>
</div>
<div class="col-md-3 col-sm-4 add-ticket">
    <a id="donation-ticket" href="#fakelink" class="btn btn-block btn-lg btn-default">
        <span class="fui-plus"></span>Donation</a>
</div>

<h5>Additional Settings</h5>
<div class="form-group">
    <span class="as-label">Listing privacy</span>
    <label class="radio checked">
							<span class="icons">
								<span class="first-icon fui-radio-unchecked"></span>
								<span class="second-icon fui-radio-checked"></span>
							</span>
        <input type="radio" name="privacy_event" id="public-event" value="public" data-toggle="radio">
        Public event
        <span class="additional">list this event on Eventbrite and search engines</span>
    </label>
    <label class="radio">
							<span class="icons">
								<span class="first-icon fui-radio-unchecked"></span>
								<span class="second-icon fui-radio-checked"></span>
							</span>
        <input type="radio" name="privacy_event" id="private-event" value="private" data-toggle="radio">
        Private event
        <span class="additional">do not list this event publicly</span>
    </label>
</div>

<div class="col-md-4 col-md-offset-4">
    <button class="btn btn-primary btn-lg btn-block" name="submit" type="submit" value="Submit">
        Create event
    </button>
</div>
</form>
</div>
</div>

<div class="row">
    <div class="bottom-menu">
        <div class="col-md-2 col-sm-2 col-xs-12 col-md-offset-1 col-sm-offset-1 brand">
            <a class="navbar-brand" href="#"></a>
        </div>

        <div class="col-md-7 col-sm-6">
            <ul class="bottom-links">
                <li>
                    <a href="#fakelink">About Us</a>
                </li>
                <li>
                    <a href="#fakelink">Store</a>
                </li>
                <li>
                    <a href="#fakelink">Privacy</a>
                </li>
                <li>
                    <a href="#fakelink">Follow Us</a>
                </li>
                <li>
                    <a href="#fakelink">Support</a>
                </li>
            </ul>
        </div>

        <div class="col-md-2 col-sm-3">
            <ul class="bottom-icons">
                <li>
                    <a href="#fakelink" class="fui-googleplus"></a>
                </li>
                <li>
                    <a href="#fakelink" class="fui-facebook"></a>
                </li>
                <li>
                    <a href="#fakelink" class="fui-twitter"></a>
                </li>
            </ul>
        </div>
    </div>
    <!-- /bottom-menu-inverse -->
</div>
</div>

<!-- Load JS here for greater good =============================-->
<script src="js/classie.js"></script>
<script src="js/cbpAnimatedHeader.min.js"></script>

<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="js/jquery.ui.touch-punch.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-select.js"></script>
<script src="js/bootstrap-switch.js"></script>
<script src="js/flatui-checkbox.js"></script>
<script src="js/flatui-radio.js"></script>
<script src="js/jquery.tagsinput.js"></script>
<script src="js/jquery.placeholder.js"></script>

<script src="js/application.js"></script>

<script type="text/javascript">
    $(document).on("keypress", 'form', function(e) {
        var code = e.keyCode || e.which;
        if (code == 13) {
            e.preventDefault();
            return false;
        }
    });
    $(document).ready(function() {
        $("#background-block").css("height", 2 * $(window).height() / 5);

        $('#free-ticket').click(function() {
            var id = getLastId()
            var priceInput = '<input type="text" class="form-control" value="Free" name="event_ticket_price_' + id + '" id="event-ticket-price-' + id + '" readonly="" disabled="disabled" />';
            addTicket(priceInput);
        });

        $('#paid-ticket').click(function() {
            var id = getLastId()
            var priceInput = '<input type="number" class="form-control" placeholder="0" name="event_ticket_price_' + id + '" id="event-ticket-price-' + id + '" min="0" />';
            addTicket(priceInput);
        });

        $('#donation-ticket').click(function() {
            var id = getLastId()
            var priceInput = '<input type="text" class="form-control" value="Donation" name="event_ticket_price_' + id + '" id="event-ticket-price-' + id + '" readonly="" disabled="disabled" />';
            addTicket(priceInput);
        });

        var addTicket = function(priceInput) {
            var id = getLastId();
            $('#tickets > #tickets-body:last').append(
                    '<div id="' + id + '" class="row">' +
                            '<div class="col-md-6 col-sm-6">' +
                            '<label class="visible-xs" for="event-ticket-name-' + id + '">Ticket name</label>' +
                            '<input type="text" class="form-control" placeholder="Examples: Early Bird, VIP, Press" name="event_ticket_name_' + id + '" id="event-ticket-name-' + id + '" />' +
                            '</div>' +
                            '<div class="col-md-2 col-sm-2">' +
                            '<label class="visible-xs" for="event-ticket-quantity-' + id + '">Quantity available</label>' +
                            '<input type="number" class="form-control" placeholder="100" name="event_ticket_quantity_' + id + '" id="event-ticket-quantity-' + id + '" min="1" />' +
                            '</div>' +
                            '<div class="col-md-2 col-sm-2">' +
                            '<label class="visible-xs" for="event-ticket-price-' + id + '">Price</label>' +
                            priceInput +
                            '</div>' +
                            '<div class="col-md-2 col-sm-2 actions text-center">' +
                            '<label class="visible-xs text-left">Ticket name</label>' +
                            '<a href="#" data-toggle="modal" data-target="#my-modal-' + id + '">' +
                            '<span class="fui-gear"></span>' +
                            '</a>' +
                            '<a class="delete-row" href="#">' +
                            '<span class="fui-trash"></span>' +
                            '</a>' +
                            '</div>' +
                            '<div class="modal fade" id="my-modal-' + id + '" tabindex="-1" role="dialog" aria-labelledby="my-modal-label-' + id + '" aria-hidden="true">' +
                            '<div class="modal-dialog">' +
                            '<div class="modal-content">' +
                            '<div class="modal-header">' +
                            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>' +
                            '<h4 class="modal-title" id="my-modal-label-' + id + '">Ticket Settings</h4>' +
                            '</div>' +
                            '<div class="modal-body">' +
                            '<div class="form-group">' +
                            '<label for="ticket-description-' + id + '">Ticket Description</label>' +
                            '<textarea rows="3" placeholder="Additional info about ticket" class="form-control" id="ticket-description-' + id + '" form="create-event-form"></textarea>' +
                            '</div>' +
                            '<div class="form-group">' +
                            '<span>Tickets Allowed Per Order</span>' +
                            '<label class="additional" for="ticket-min-per-order-' + id + '">Min</label>' +
                            '<input type="number" class="form-control" placeholder="1" value="1" name="ticket_min_per_order_' + id + '" id="ticket-min-per-order-' + id + '" min="1" />' +
                            '<label class="additional" for="ticket-max-per-order-' + id + '">Max</label>' +
                            '<input type="number" class="form-control" placeholder="1" name="ticket_max_per_order_' + id + '" id="ticket-max-per-order-' + id + '" min="1" />' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>'
            );
            return this;
        };

        var getLastId = function() {
            var stringId = $('#tickets > #tickets-body:last .row:last').attr('id');
            var id = 0;
            if (stringId != 'undefined' && !isNaN(stringId)) {
                id = parseInt(stringId) + 1;
            }
            return id;
        };

    });

    $(window).resize(function() {
        $("#background-block").css("height", 2 * $(window).height() / 5);
    });

    $(document).on('click', "#tickets .delete-row", function() {
        var tr = $(this).closest('.row');
        tr.fadeOut(400, function() {
            tr.remove();
        });
        return false;
    });
</script>

</body>

</html>