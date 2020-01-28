function extractLinks()
    root = 'http://www.unizg.hr';
    page = "<div id=\'cssmenu\'><ul><li><a href=\"/o-sveucilistu/\" onfocus=\"blurLink(this);>OSveučilištu</a><ul><li><a href=\"/o-sveucilistu/dobrodoslica-rektora/\" onfc=\"blurLink(this);\"  >Dobrodošlica rektora</a></li><li><a href=\"/o-sveucilistu/sastavnice-sveucilista/\" onfocus=\"blurLink(this);\"  >Sastavnice Sveučilišta</a><ul><li><a href=\"/o-sveucilistu/sastavnice-sveucilista/fakulteti/\" onfocus=\"blurLink(this);\"  >Fakulteti</a></li><li><a href=\"/o-sveucilistu/sastavnice-sveucilista/akademije/\" onfocus=\"blurLink(this);\"  >Akademije</a></li><li><a href=\"/o-sveucilistu/sastavnice-sveucilista/sveucilisni-centri-i-odjeli/\" >Sveučilišni centri i odjeli</a></li><li><a href=\"/o-sveucilistu/sastavnice-sveucilista/ostale-sastavnice/\" >Ostale sastavnice</a></li><li><a href=\"/o-sveucilistu/sastavnice-sveucilista/ustrojbene-jedinice/\" onfocus=\"blurLink(this);\"  >Ustrojbene jedinice</a></li></ul></li><li><a href=\"/o-sveucilistu/sveucilisna-tijela-i-sluzbe/\" onfocus=\"blurLink(this);\"  >Sveučilišna tijela i službe</a><ul><li><a href=\"/o-sveucilistu/sveucilisna-tijela-i-sluzbe/rektor/\" onfocus=\"blurLink(this);\"  >Rektor</a></li><li><a href=\"/o-sveucilistu/sveucilisna-tijela-i-sluzbe/prorektori/\" onfocus=\"blurLink(this);\"  >Prorektori</a></li><li><a href=\"/o-sveucilistu/sveucilisna-tijela-i-sluzbe/pomocnici-rektora/\" onfocus=\"blurLink(this);\"  >Pomoćnici rektora</a></li><li><a href=\"/o-sveucilistu/sveucilisna-tijela-i-sluzbe/savjetnici-rektora/\" onfocus=\"blurLink(this);\"  >Savjetnici rektora</a></li><li><a href=\"/o-sveucilistu/sveucilisna-tijela-i-sluzbe/rektorski-kolegij/\"a><ul class=\"to-left\"><li class=\'zadnji\'><a href=\"/suradnja/medunarodna-suradnja/\"<a href=\"/novosti-i-press/priopcenja-za-medije/\"</div></div></div><a href=\"/nc/novosti-i-press/vijesti/\" target=\"_self\" class=\"svevijesti\" >Sve vijesti i najave...</a></div></div><div class=\"row\">div class=\"col-xs-12 col-sm-12 col-md-12 col-lg-12\" style=\"background-color:white;padding-right:13px;\"><div class=\"col-lg-3 col-md-3 col-sm-6 col-xs-6\"><a data-lighter=\'uploads/pics/unizg-350G-logo-plava-pozadina.png\' href=\'uploads/pics/unizg-350G-logo-plava-pozadina.png\'><img class=\"img-responsive img-border\" src=\"/uploads/pics/unizg-350G-logo-plava-pozadina.png\"></a><br/><b class=\"obavijesti_podnaslovi\"><a href=\"nc/vijest/article/obiljezavanje-350-akademske-godine/\">ObilDiplomski sveučilišni studij <a href=\"https://www.math.pmf.unizg.hr/hr/diplomski-sveu%C4%8Dili%C5%A1ni-studij-teorijska-matematika-0\" target=\"_blank\" >Teorijska matematika</a><br />Diplomski sveučilišni studij <a href=\"https://www.math.pmf.unizg.hr/hr/diplomski-sveu%C4%8Dili%C5%A1ni-studij-primijenjena-matematika-0\" targebsp;>&nbsp;<a href=\"/studiji-i-studiranje/studiji/diplomski-studiji/podrucje-prirodnih-znanosti/\" o";
    for f = regexp(page, '<a href="');
        e = min(strfind(page(f+9:end), "\""));
        if isempty(e), continue, end
        url = deblank(page(f+9:f+e+7));
        if url(1) == '/'
            if url(2) != '#'
                url = strcat(getHost(root), url);
            else continue
            endif
        else
            protocol = regexp(url, 'http:|https:');
            if isempty(protocol)
                url = strcat('/', url);
                url = strcat(root, url);
            else
                unizgIndex = min(strfind(url, 'unizg.hr'));
                if isempty(unizgIndex), continue, end
            endif
        endif
        url(url<' ') = '!';
        % Nonprintable characters
        if url(end) == '/', url(end) = []; end
        % Look for links that should be skipped.
        skips = {'.gif','.jpg','.pdf','.css','lmscadsi','cybernet',...
            'search.cgi','.ram','www.w3.org', 'mailto' ...
            'scripts','netscape','shockwave','webex','fansonly'};
        skip = any(url=='!') | any(url=='?');
        k=0;
        while ~skip && (k < length(skips))
            k = k+1;
            skip = ~isempty(findstr(url,skips{k}));
        end
        if skip
            if isempty(findstr(url,'.gif')) & ...
                    isempty(findstr(url,'.jpg'))
                disp(['     skip ' url])
            end
            continue
        end
        disp(url);
        % iz svih linkova prije spremanja izbaciti protokol i www i zadnji slash
        % slash vec izbacen prije
        cleanUrl = clean(url);
    end
end