<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<ul class="pagination justify-content-center">
		<fmt:formatNumber type="number" maxFractionDigits="0" groupingUsed="false" value="${((pageImpl.pageable.pageNumber) / 3 - ((pageImpl.pageable.pageNumber) / 3) % 1)}" var="start"/>
		
		   <li class="page-item <c:if test="${pageImpl.pageable.pageNumber < 3 }">disabled</c:if>"><a class="page-link" 
		    href="${url }&page=${start * 3 - 3}">Previous</a></li>
		    <c:forEach 
		    begin="${start * 3 }" 
		    end="${start * 3 + 2 }" var="page">
		    <c:if test="${page+1 <= pageImpl.totalPages }">
		    <li class="page-item <c:if test="${pageImpl.pageable.pageNumber eq page }">active</c:if>"><a class="page-link" 
		    href="${url }&page=${page}">${page+1}</a></li>
		    </c:if>
		    </c:forEach>
		    <li class="page-item <c:if test="${start * 3 + 3 >= pageImpl.totalPages }">disabled</c:if>"><a class="page-link" 
		    href="${url }&page=${start * 3 + 3}">Next</a></li>
		 </ul>	