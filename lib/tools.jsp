<%!
public String CheckSafe(String text)
{
    int sign = 1;
    if(text.lastIndexOf("'")!= -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf("\\") != -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf("and") != -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf("=") != -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf("union") != -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf("--") != -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf("<") != -1)
    {
        sign = 0;
    }
    else if(text.lastIndexOf(">") != -1)
    {
        sign = 0;
    }

    if(sign == 1)
    {
        return "True";
    }
    else
    {
        return "I am very safe!";
    }
}
public String removeAllBlank(String s){
        String result = "";
        if(null!=s && !"".equals(s)){
            result = s.replaceAll("[　*| *| *|//s*]*", "");
        }
        return s;
    }
%>