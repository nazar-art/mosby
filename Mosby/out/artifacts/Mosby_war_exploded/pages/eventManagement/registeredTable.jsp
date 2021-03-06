<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="main.java.com.mosby.i18n.text"/>
<html>

<head>
    <meta charset="utf-8">
    <title><fmt:message key="registeredTable.registeredTable"/> - Mosby - <fmt:message key="title"/></title>
    <link rel="shortcut icon" href="media/images/favicon.ico">
    <link rel="icon" type="image/png" href="media/images/favicon.png"/>
    <meta name="description" content="Mosby - make it simple. New event management system"/>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <!-- Loading Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="css/flat-ui.css" rel="stylesheet">
    <link href="css/pro-features.css" rel="stylesheet">
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
             style="background-image: url(media/images/bg_mask.png), url(media/images/default/${event.background})"></div>
    </div>

    <div id="wrapper" class="row user-profile">
        <jsp:include page="parts/sideNavbar.jsp"/>
        <div id="page-content-wrapper">
            <div class="content-header">
                <h3>
                    <a id="menu-toggle" href="#" class="btn btn-default">
                        <span class="fui-list-columned"></span>
                    </a>
                    <fmt:message key="registeredTable.tableOfRegisteredUsers"/>
                </h3>
            </div>
            <div class="page-content inset">
                <div class="errors">
                    <c:forEach items="${errors}" var="error">
                        <p>${error}</p>
                    </c:forEach>
                </div>
                <form action="registeredTable" method="post" id="registered-table-form">
                    <input type="hidden" name="eventId" value="${event.id}"/>

                    <div class="row registered-table">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                <tr>
                                    <th>
                                        <label class="checkbox no-label toggle-all" for="checkbox-table-1">
                                            <input type="checkbox" value="" id="checkbox-table-1"
                                                   data-toggle="checkbox">
                                        </label>
                                    </th>
                                    <th>#</th>
                                    <th><fmt:message key="registeredTable.checked"/></th>
                                    <th><fmt:message key="registeredTable.user"/></th>
                                    <th>Email</th>
                                    <th><fmt:message key="registeredTable.ticket"/></th>
                                    <th><fmt:message key="registeredTable.timeOfPurchase"/></th>
                                    <th><fmt:message key="registeredTable.promoCode"/></th>
                                    <th><fmt:message key="registeredTable.actions"/></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${tickets}" var="ticket">
                                    <tr>
                                        <td>
                                            <input type="number" name="id" class="hide" value="${ticket.id}">
                                            <label class="checkbox no-label" for="checkbox-table-${ticket.id}">
                                                <input type="checkbox" value="${ticket.id}"
                                                       id="checkbox-table-${ticket.id}"
                                                       name="checked_tickets" data-toggle="checkbox">
                                            </label>
                                        </td>
                                        <td>${ticket.id}</td>
                                        <td>
                                            <div class="switch switch-square" data-on-label="<i class='fui-check'></i>"
                                                 data-off-label="<i class='fui-cross'></i>">
                                                <input type="checkbox" name="checked_in_tickets" value="${ticket.id}" 
                                                        <c:if test="${ticket.checked}"> checked </c:if> />
                                            </div>
                                        </td>
                                        <td>
                                            <a href="<c:url value='/userPage'/>?id=${ticket.user.id}>"
                                               target="_blank">${ticket.user.firstName} ${ticket.user.lastName}</a>
                                        </td>
                                        <td>
                                            <a href="mailto:${ticket.user.email}"
                                               target="_blank">${ticket.user.email}</a>
                                        </td>
                                        <td>
                                            <span>${ticket.ticketInfo.name}</span>
                                            <span class="additional-price-info">*
                                                <c:choose>
                                                    <c:when test="${ticket.ticketInfo.type == 'Free'}">
                                                        Free
                                                    </c:when>
                                                    <c:when test="${ticket.ticketInfo.type == 'Donation'}">
                                                        Donation
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${ticket.ticketInfo.price}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <p>${ticket.timeOfPurchase}</p>
                                        </td>
                                        <td>
                                            <p>${ticket.promoCode.code}</p>
                                        </td>
                                        <td class="text-center">
                                            <a class="delete-nearby-row"
                                               href="<c:url value="/registeredTable?eventId=${event.id}&delete=${ticket.id}"/>">
                                                <span class="fui-trash"></span>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <button class="btn btn-info" name="check" type="submit" value="check">
                            <fmt:message key="registeredTable.check"/>
                        </button>
                        <button class="btn btn-danger" name="delete" type="submit" value="delete">
                            <fmt:message key="registeredTable.delete"/>
                        </button>
                        <button class="btn btn-primary pull-right" name="save" type="submit" value="save">
                            <fmt:message key="registeredTable.save"/>
                        </button>
                    </div>
                </form>
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
<script src="js/uisearch.js"></script>

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
<script src="js/jquery.stacktable.js"></script>
<script src="http://vjs.zencdn.net/4.3/video.js"></script>

<script src="js/application.js"></script>

</body>

</html>
