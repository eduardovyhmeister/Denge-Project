function [T,p] = cholcoved(Sigma,flag)

if nargin < 2, flag = 1; end
[n,m] = size(Sigma);
wassparse = issparse(Sigma);
tol = 10*eps(max(abs(diag(Sigma))));
if (n == m) && all(all(abs(Sigma - Sigma') < n*tol))
    [T,p] = chol(Sigma);

    if p > 0
        if flag
            [U,D] = eig(full((Sigma+Sigma')/2));
            [~,maxind] = max(abs(U),[],1);
            negloc = (U(maxind + (0:n:(m-1)*n)) < 0);
            U(:,negloc) = -U(:,negloc);

            D = diag(D);
            tol = eps(max(D)) * length(D);
            t = (abs(D) > tol);
            D = D(t);
            p = sum(D<0); 
            if (p==0)
                T = diag(sqrt(D)) * U(:,t)';
            else
                T = zeros(0,'like',Sigma);
            end
        else
            T = zeros(0,'like',Sigma);
        end
    end

else
    T = zeros(0,'like',Sigma);
    p = nan('like',Sigma);
end

if wassparse
    T = sparse(T);
end
