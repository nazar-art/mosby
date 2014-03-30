<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <meta charset="utf-8">
    <title>Mosby - event management</title>
    <link rel="shortcut icon" href="media/images/favicon.ico">
    <link rel="icon" type="image/png" href="media/images/favicon.png"/>
    <meta name="description" content="Mosby - make it simple. New event management system"/>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <!-- Loading Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="css/flat-ui.css" rel="stylesheet">
    <link href="css/pro-features.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/bootstrap-social.css" rel="stylesheet">
    <link href="css/simple-sidebar.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">


    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="../parts/navbar.jsp"/>
    </div>

    <div class="row" style="background: #000">
        <div id="background-block" class="flow-img"
             style="background-image: url(media/images/bg_mask.png), url(media/images/default/holi-feast.jpg)"></div>
    </div>

    <div id="wrapper" class="row user-profile">
        <jsp:include page="parts/sideNavnar.jsp"/>
        <div id="page-content-wrapper">
            <div class="content-header">
                <h1>
                    <a id="menu-toggle" href="#" class="btn btn-default">
                        <span class="fui-list-columned"></span>
                    </a>
                    API Access Keys
                </h1>
            </div>
            <div class="page-content inset">
                <div class="row api">
                    <div class="col-md-12 col-sm-12">
                        <form action="apiAccess" method="post" id="generate-key-form">
                            <% if (request.getAttribute("generatedKey") != null) { %>
                            <div class="form-group col-md-12">
                                <div class="col-md-8">
                                    <p>You may now enter your new application-specific key into your application. Note
                                        that this key grants complete access to your Mosby Account. For security
                                        reasons, it will not be displayed again</p>

                                    <div class="secure-key text-center">
                                        <div id="qr-code"></div>
                                        <p>${generatedKey}</p>
                                        <span class="additional-input-info">No need to memorize this password.</span>
                                        <span class="additional-input-info">You should need to enter it only once. Spaces don't matter.</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <div class="form-group col-md-3 col-sm-3">
                                    <button class="btn btn-primary btn-lg btn-block" name="submit" type="submit"
                                            value="Done">
                                        Done
                                    </button>
                                </div>
                            </div>
                            <% } else { %>
                            <div class="form-group col-md-5 col-sm-5">
                                <label for="name">Name</label>
                                <input class="form-control" type="text" placeholder="Name" name="name" id="name"/>
                                <span class="additional-input-info">ex: "Android App", "Google Glass"</span>
                            </div>
                            <div class="form-group col-md-3 col-sm-3">
                                <label for="organizer">Organizer</label>
                                <select name="organizer" class="select-block" id="organizer" form="generate-key-form">
                                    <c:forEach items="${organizers}" var="organizer">
                                        <option value="${organizer.id}">
                                                ${organizer.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group col-md-4 col-sm-4">
                                <button class="btn btn-primary btn-lg btn-block generate" name="submit" type="submit"
                                        value="Generate">
                                    Generate key
                                </button>
                            </div>
                            <% }%>
                        </form>
                    </div>
                </div>
                <div class="row">
                    <div id="my-apis">
                        <div class="row my-apis-header hidden-xs">
                            <div class="col-md-6 col-sm-6">Api access name</div>
                            <div class="col-md-2 col-sm-2">Organizer</div>
                            <div class="col-md-3 col-sm-3">Creation date</div>
                            <div class="col-md-1 col-sm-1 text-center">Actions</div>
                        </div>
                        <div id="my-apis-body">
                            <c:forEach items="${keys}" var="key">
                                <div id="${key.id}" class="row">
                                    <div class="col-md-6 col-sm-6">
                                        <span class="as-label visible-xs">Api access name</span>

                                        <p>${key.name}</p>
                                    </div>
                                    <div class="col-md-2 col-sm-2">
                                        <span class="as-label visible-xs">Organizer</span>

                                        <p>${key.organizer.name}</p>
                                    </div>
                                    <div class="col-md-3 col-sm-3">
                                        <span class="as-label visible-xs">Creation date</span>

                                        <p>${key.timeOfCreation}</p>
                                    </div>
                                    <div class="col-md-1 col-sm-1 actions text-center">
                                        <label class="visible-xs text-left">Actions</label>
                                        <a class="delete-nearby-row" href="<c:url value="/apiAccess"/>?delete=${key.id}">
                                            <span class="fui-trash"></span>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="row">
        <jsp:include page="../parts/footer.jsp"/>
    </div>
</div>

<!-- Load JS here for greater good =============================-->
<script src="js/classie.js"></script>
<script src="js/cbpAnimatedHeader.min.js"></script>

<script src="js/jquery-2.0.3.min.js"></script>
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="js/jquery.ui.touch-punch.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-select.js"></script>
<script src="js/bootstrap-switch.js"></script>
<script src="js/flatui-checkbox.js"></script>
<script src="js/flatui-radio.js"></script>
<script src="js/jquery.tagsinput.js"></script>
<script src="js/jquery.placeholder.js"></script>
<script src="js/jquery.qrcode-0.7.0.min.js"></script>
<script src="js/typeahead.bundle.min.js"></script>

<script src="js/application.js"></script>

<script type="text/javascript">
    $('#qr-code').qrcode({
        render: 'div',
        width: 250,
        height: 250,
        color: '#212121',
        text: '${generatedKey}'
    });
    $(".secure-key p").html(function (idx, html) {
        return html.replace(/(....)/g, '$1 ')
    });
</script>

</body>

</html>