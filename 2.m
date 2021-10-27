% x = [0 1 1 0];
x = randi([0,1],[1,8])
H = [0 0 0 1 1 1 1;
    0 1 1 0 0 1 1;
    1 0 1 0 1 0 1];
[r,n] = size(H); 
k = n - r; 
G = [eye(k),[ones(3)-eye(3);ones(1,3)]]; 
if mod(G*H',2) ~=0
    fprintf("this code is not support for your H!")
end
% G = [1 0 0 0 0 1 1;
%     0 1 0 0 1 0 1;
%     0 0 1 0 1 1 0;
%     0 0 0 1 1 1 1;];

for k=1:2
    x_ = x((k-1)*4+1:k*4)
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
