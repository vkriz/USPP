function x = arnoldiRank(B, q1, m)

    [Q, H] = arnoldi(B, q1, m);
    [EVEC, EVAL] = eig(full(H));
    
    [eigval ind] = max(diag(EVAL));
    
    firstvec = EVEC(:, ind);
    
    eigvec = Q * firstvec;
    
    eigvec = eigvec./norm(eigvec, 1);
    
    if(eigvec(1)<0)
        eigvec = abs(eigvec);
    end
    
    x = eigvec;
end

