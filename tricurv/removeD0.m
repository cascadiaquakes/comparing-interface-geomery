function out=removeD0(x)
% Removing duplicate and null values
s=sort(x);
s1=[0,s];
s2=[s,s(length(s))];
ds=(s1-s2);
out=s(logical(ds~=0));
end% End removeD0