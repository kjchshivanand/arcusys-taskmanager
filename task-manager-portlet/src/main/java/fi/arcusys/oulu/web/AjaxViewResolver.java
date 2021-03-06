/**
 * $Id$
 * 
 * Copyright (C) 2011 Arcusys Oy - http://www.arcusys.fi/
 * 
 * This file is part of Arcusys Taskmanager.
 * 
 * Arcusys Taskmanager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Arcusys Taskmanager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 * 
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 */

package fi.arcusys.oulu.web;

import java.util.Locale;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractCachingViewResolver;

/**
 * Implements Ajaxview resolver for ajax view
 * @author Jinhua Chen
 * May 11, 2011
 */
public class AjaxViewResolver extends AbstractCachingViewResolver  {  
    
    public static final String AJAX_PREFIX = "ajax_";   
    public String ajaxPrefix = AJAX_PREFIX;    
    private View ajaxView = new AjaxView ();  
  
    @Override  
    protected View loadView(String viewName, Locale locale) throws Exception {  
        View view = null;  
        if (viewName.startsWith(AJAX_PREFIX)) {  
            view = ajaxView;  
        }  
        return view;  
    }  
   
}  
