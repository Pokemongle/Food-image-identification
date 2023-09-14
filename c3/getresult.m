function [result] = getresult(predictIndex,rice_k)
[num,~] = size(predictIndex);
result = [];
for i=1:num
    switch predictIndex(i,1)
    case 1
        re = "Çà²Ë";
        result = [result;re];
    case 2
        re = "ÊÖËº¼¦";
        result = [result;re];
    case 3
        re = "»Æ¹Ï¼¦µ°";
        result = [result;re];
    case 4
        re = "Ñ¼Èâ";
        result = [result;re];
    case 5
        re = "À±×Ó¼¦";
        result = [result;re];
    case 6
        re = "Î÷ºùÂ«";
        result = [result;re];
    case 7
        re = "¾Â²Ë¼¦µ°";
        result = [result;re];
    case 8
        re = "Î÷À¼»¨";
        result = [result;re];
    case 9
        re = "Ğ¡ËÖÈâ";
        result = [result;re];  
    case 10
        re = "¼¦µ°³´Èâ";
        result = [result;re];
    case 11
        re = "ôø¶¹";
        result = [result;re];
    case 12
        re = "Çà½·Å£Èâ";
        result = [result;re];
    case 13
        re = "²¤²Ë";
        result = [result;re];
    case 14
        re = "¶¹¸¯";
        result = [result;re];
    case 15
        re = "¶¹Ñ¿";
        result = [result;re];
    case 16
        re = "Ã×·¹"+ ""+rice_k +"Á½";
        result = [result;re];
    case 17
        re = "¿ÕÅÌ";
        result = [result;re];
    case 18
        re = "¼¦µ°»¨";
        result = [result;re];
        otherwise 
    end
end




end