<%--

    Copyright (C) 2000 - 2009 Silverpeas

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    As a special exception to the terms and conditions of version 3.0 of
    the GPL, you may redistribute this Program in connection with Free/Libre
    Open Source Software ("FLOSS") applications as described in Silverpeas's
    FLOSS exception.  You should have received a copy of the text describing
    the FLOSS exception, and it is also available here:
    "http://repository.silverpeas.com/legal/licensing"

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="photoAndInfo">
  <div id="photo">
<img src="<c:url value="${snUserFull.profilPhoto}"/>" class="avatar" border="0" alt="viewUser" />
  </div>
  <div id="info">
        <span class="userName">${snUserFull.userFull.lastName} ${snUserFull.userFull.firstName}</span>
        <span class="connection">
          <c:if test="${snUserFull.connected=='true'}">
            <img src="<c:url value="/directory/jsp/icons/connected.jpg" />" border="1" width="10" height="10"
                  alt="connected"/> <fmt:message key="directory.connected"  /> ${snUserFull.duration}
          </c:if>
          <c:if test="${snUserFull.connected=='false'}">
            <img src="<c:url value="/directory/jsp/icons/deconnected.jpg" />" border="1" width="10" height="10" alt="connected"/>
          </c:if>
        </span>
  </div>
</div>
<div id="status" class="StatusDiv"/>
<script type="text/javascript">  
              getLastStatus();
</script>
