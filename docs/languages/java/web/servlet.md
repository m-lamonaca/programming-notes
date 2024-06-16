# Servlet

A Java servlet is a Java software component that extends the capabilities of a server.
Although servlets can respond to many types of requests, they most commonly implement web containers for hosting web applications on web servers and thus qualify as a server-side servlet web API.

## Basic Structure

```java
package <package>;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/route")
public class <className> extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /** handle get request */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // GET REQUEST: load and display page (forward to JSP)
        // OPTIONAL: add data to request (setAttribute())

    }

    /** handle post request */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // POST REQUEST: add stuff to DB, page, ...

        doGet(request, response);  // return same page with new  content added (default case)
    }
}
```

## Servlet Instructions

```java
request.getParameter()  // read request parameter

response.setContentType("text/html");  // to return HTML in the response

response.getWriter().append("");  //append content to the http response

request.setAttribute(attributeName, value);  // set http attribute of the request
request.getRequestDispatcher("page.jsp").forward(request, response);  // redirect the request to another page
```
