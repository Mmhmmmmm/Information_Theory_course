% x = [0 1 1 0];
x = randi([0,1],[1,22])
H = [0 0 0 1 1 1 1;
    0 1 1 0 0 1 1;
    1 0 1 0 1 0 1];
[rr,n] = size(H);
k = n - rr;
% c = zeros(1,r);
ke = eye(k);
G = [eye(k),zeros(k,rr)];
for kk =1:k
    for i=1:2^rr
        obj=dec2bin(i,rr);
        for q=1:rr
            G(kk,k+q)=str2num(obj(q));
        end
        if mod(G(kk,:) * H',2) == 0
            break; 
        end
    end
end
G
if mod(G*H',2) ~=0
    fprintf("this code is not support for your H!")
end
% G = [1 0 0 0 0 1 1;
%     0 1 0 0 1 0 1;
%     0 0 1 0 1 1 0;
%     0 0 0 1 1 1 1;];

for kk=1:2
    x_ = x((kk-1)*k+1:kk*k)
    e =eye(7);
    key = randi(7);
    e_ = e(key,:)
    c = mod(x_*G,2)
    r = mod((c + e_ ),2)
    s = mod(r * H',2)
    flag = 0;
    for i=1:7
        e_hat = e(i,:);
        if mod(e_hat*H',2) == s
            e_hat
            flag =1;
            break
        end
    end
    if flag ~=1
        fprintf("no! not find e_hat\n");
        return
    end
    
    c_hat = mod((r+e_hat),2)
    if c_hat == c
        fprintf("find error is true\n");
    end
end
