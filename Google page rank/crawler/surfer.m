function [U,L] = surfer(root,n);
% SURFER  Create the adjacency matrix of a portion of the Web.
%    [U,L] = surfer(root,n) starts at the URL root and follows
%    Web links until it forms an n-by-n adjacency matrix of links.
%    The output U is a cell array of the URLs visited and
%    L is a sparse matrix with L(i,j)=1ifurl{i} links to url{j}.
%    Example:  [U,L] = surfer(’http://www.ncsu.edu’,500);
%    This function currently has two defects.  (1) The algorithm for
%    finding links is naive.  We just look for the string ’http:’.
%    (2) An attempt to read from a URL that is accessible, but very
%    slow, might take an unacceptably long time to complete.  In
%    some cases, it may be necessary to have the operating system
%    terminate MATLAB. Key words from such URLs can be added to the
%    skip list in surfer.m.

% Initialize
U = cell(n,1);
hash = zeros(n,1);
L = logical(sparse(n,n));
m=1;
U{m} = root;
hash(m) = hashfun(root);

for j = 1:n
    % Try to open a page.
    try
        disp(['open ' num2str(j) ' ' U{j}])
        page = urlread(U{j});
    catch
        disp(['fail ' num2str(j) ' ' U{j}])
        continue
    end
    
    % Follow the links from the open page.
    for f = regexp(page, '<a href="');
        e = min(strfind(page(f+9:end), '"'));
        if isempty(e), continue, end
        url = deblank(page(f+9:f+e+7));
        if length(url) > 0 && url(1) == '/'
            if length(url) > 1 && url(2) ~= '#'
                url = strcat(getHost(root), url);
            else
                continue
            end
        else
            protocol = regexp(url, 'http:|https:');
            if isempty(protocol)
                url = strcat('/', url);
                url = strcat(root, url);
            else
                unizgIndex = min(strfind(url, 'unizg.hr'));
                if isempty(unizgIndex), continue, end
            end
        end
        disp(url);
        url(url<' ') = '!';
        % Nonprintable characters
        if url(end) == '/', url(end) = []; end
        % Look for links that should be skipped.
        skips = {'.gif','.jpg','.pdf','.css','lmscadsi','cybernet',...
            'search.cgi','.ram','www.w3.org', 'mailto', 'wp-', ...
            'scripts','netscape','shockwave','webex','fansonly'};
        skip = any(url=='!') | any(url=='?');
        k=0;
        while ~skip && (k < length(skips))
            k = k+1;
            skip = ~isempty(findstr(url,skips{k}));
        end
        if skip
            if isempty(findstr(url,'.gif')) && ...
                    isempty(findstr(url,'.jpg'))
                disp(['     skip ' url])
            end
            continue
        end
        
        % iz svih linkova prije spremanja izbaciti protokol i www i zadnji slash
        % slash vec izbacen prije
        %cleanUrl = clean(url);
        
        % Check if page is already in url list.
        i=0;
        for k = find(hash(1:m) == hashfun(url))';
            % mozda ovo ipak nema smisla
            if isequal(U{k},url)
                i=k;
                break
            end
        end
        % Add a new url to the graph there if are fewer than n.
        if (i == 0) && (m < n)
            m = m+1;
            U{m} = url;
            hash(m) = hashfun(url);
            i=m;
        end
        
        % Add a new link.
        
        if i>0
            disp(['     link ' int2str(i) ' ' url])
            L(i,j) = 1;
        end
    end
end