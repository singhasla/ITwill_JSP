<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>전국주간날씨</title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
        <script type="text/javascript">
        $(document).ready(function(){    
            $.ajax({
                url: 'http://www.weather.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108',
                dataType: 'xml',
                success: function(response){
                    console.log(response);
                    $(response).find('location').each(function(){
                        var city = $(this).find('city').text();
                        if(city == '부산'){
                            $('body').append(city + '<br>');
                            $(this).find('data').each(function(){
                                var output = $(this).find('tmEf').text() + " " + $(this).find('wf').text();
                                $('body').append(output + '<br>');
                            })
                        }
                    });
                }
            });
        })
        </script>
    </head>
    <body>
    </body>
</html>
