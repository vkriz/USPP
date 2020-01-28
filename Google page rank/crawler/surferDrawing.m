function [U,L] = surferDrawing(root,n);
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

clf
shg
axis([0 n 0 n])
axis square
axis ij
box on
set(gca,'position',[.12 .20 .78 .78])
uicontrol('style','frame','units','normal','position',[.01 .09 .98 .07]);
uicontrol('style','frame','units','normal','position',[.01 .01 .98 .07]);
t1 = uicontrol('style','text','units','normal','position',[.02 .10 .94 .04], ...
   'horiz','left');
t2 = uicontrol('style','text','units','normal','position',[.02 .02 .94 .04], ...
   'horiz','left');
slow = uicontrol('style','toggle','units','normal', ...
   'position',[.01 .24 .07 .05],'string','slow','value',0);
quit = uicontrol('style','toggle','units','normal', ...
   'position',[.01 .17 .07 .05],'string','quit','value',0);


% Initialize
U = cell(n,1);
hash = zeros(n,1);
L = logical(sparse(n,n));
m=1;
U{m} = root;
hash(m) = hashfun(root);
j = 1;
while j < n & get(quit,'value') == 0
    
    % Try to open a page.
    try
        disp(['open ' num2str(j) ' ' U{j}])
        set(t1,'string',sprintf('%5d %s',j,U{j}))
        set(t2,'string','');
        drawnow
        page = urlread(U{j});
    catch
        disp(['fail ' num2str(j) ' ' U{j}])
        set(t1,'string',sprintf('fail: %5d %s',j,U{j}))
        drawnow
        j = j+1;
        continue
    end
    if get(slow,'value')
      pause(.25)
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
                set(t2,'string',sprintf('skip: %s',url))
                drawnow
                if get(slow,'value')
                   pause(.25)
                end
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
            set(t2,'string',sprintf('%5d %s',i,url))
            line(j,i,'marker','.','markersize',6)
            drawnow
            if get(slow,'value')
                pause(.25)
            end
            L(i,j) = 1;
        end
    end
    j = j+1;
end
delete(t1)
delete(t2)
delete(slow)
set(quit,'string','close','callback','close(gcf)','value',0)