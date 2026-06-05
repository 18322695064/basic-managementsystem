package com.management.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class XssFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        chain.doFilter(new XssRequestWrapper((HttpServletRequest) request), response);
    }

    private static class XssRequestWrapper extends HttpServletRequestWrapper {

        public XssRequestWrapper(HttpServletRequest request) {
            super(request);
        }

        @Override
        public String[] getParameterValues(String name) {
            String[] values = super.getParameterValues(name);
            if (values == null) return null;
            String[] encodedValues = new String[values.length];
            for (int i = 0; i < values.length; i++) {
                encodedValues[i] = cleanXss(values[i]);
            }
            return encodedValues;
        }

        @Override
        public String getParameter(String name) {
            return cleanXss(super.getParameter(name));
        }

        @Override
        public String getHeader(String name) {
            return cleanXss(super.getHeader(name));
        }

        private String cleanXss(String value) {
            if (value == null) return null;
            return value
                    .replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#x27;")
                    .replaceAll("&(?!lt;|gt;|quot;|#x27;|amp;)", "&amp;");
        }
    }
}