function [result] = getresult(predictIndex,rice_k)
[num,~] = size(predictIndex);
result = [];
for i=1:num
    switch predictIndex(i,1)
    case 1
        re = "���";
        result = [result;re];
    case 2
        re = "��˺��";
        result = [result;re];
    case 3
        re = "�ƹϼ���";
        result = [result;re];
    case 4
        re = "Ѽ��";
        result = [result;re];
    case 5
        re = "���Ӽ�";
        result = [result;re];
    case 6
        re = "����«";
        result = [result;re];
    case 7
        re = "�²˼���";
        result = [result;re];
    case 8
        re = "������";
        result = [result;re];
    case 9
        re = "С����";
        result = [result;re];  
    case 10
        re = "��������";
        result = [result;re];
    case 11
        re = "����";
        result = [result;re];
    case 12
        re = "�ཷţ��";
        result = [result;re];
    case 13
        re = "����";
        result = [result;re];
    case 14
        re = "����";
        result = [result;re];
    case 15
        re = "��ѿ";
        result = [result;re];
    case 16
        re = "�׷�"+ ""+rice_k +"��";
        result = [result;re];
    case 17
        re = "����";
        result = [result;re];
    case 18
        re = "������";
        result = [result;re];
        otherwise 
    end
end




end