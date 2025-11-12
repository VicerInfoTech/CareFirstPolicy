CFP.Leaderboard = new function () {

    let scores = [];
    const players = [];   

    const board = document.getElementById('leaderboard');
    
    let interval;
    let dailyTarget = 100;

    this.bindPlayers = function () {
        scores.forEach(function (entity, index) {
            var avatr = 'linear-gradient(135deg,#cfe2ff,#b7b2ff)';
            if (index == 0) avatr = 'linear-gradient(135deg,#00d4ff,#6a7cff)';
            if (index == 1) avatr = 'linear-gradient(135deg,#ffd166,#ff7ab6)';
            if (index == 2) avatr = 'linear-gradient(135deg,#7bffb2,#00d4ff)';
            if (index == 3) avatr = 'linear-gradient(135deg,#a78bfa,#7c3aed)';
            if (index == 4) avatr = 'linear-gradient(135deg,#ffb86b,#ff7a7a)';
            if (index == 5) avatr = 'linear-gradient(135deg,#8be9fd,#9be15d)';
            if (index == 6) avatr = 'linear-gradient(135deg,#f6d365,#fda085)';
            if (index == 7) avatr = 'linear-gradient(135deg,#cfe2ff,#b7b2ff)';

            players.push({ id: (index + 1), name: entity.text, nick: entity.text.split(' ')[0], score: entity.extraValue, avatarBg: avatr })
        });
    }

    this.createItem = function (p, rank) {
        const li = document.createElement('div');
        li.className = 'item';
        li.dataset.id = p.id;

        if (rank === 1) li.classList.add('top-1');
        else if (rank === 2) li.classList.add('top-2');
        else if (rank === 3) li.classList.add('top-3');

        var runImgSrc = '';
        //if (rank === 1) runImgSrc = '<div class="runner"><img src="https://cdn-ildpbjm.nitrocdn.com/DNFbjUCPWTXiaenlvaftCfYTTTYPdzXQ/assets/images/optimized/rev-e860287/ourdesignz.com/wp-content/uploads/2015/03/running-horse.gif" style="height: 50px;"></div>';
        //else if (rank === players.length) runImgSrc = '<div class="runner"><img src="https://c.tenor.com//_Nbvod4MYo0AAAAd//tenor.gif" style="height: 50px;"></div>';

        li.innerHTML = `
			<div class="rank">${rank}</div>
			<div class="avatar" style="background:${p.avatarBg}">${p.name.split(' ')[0][0]}</div>
			<div class="meta">
			  <div class="name">${p.name}</div>
			  <div class="sub">@${p.nick}  • ${Math.max(0, dailyTarget - p.score)} deals to go</div>
			</div>
			${runImgSrc}
			<div class="scoreBox">
			  <div class="score">${p.score}</div>
			  <div class="progress"><div class="bar" style="width:${Math.min(100, (p.score / dailyTarget) * 100)}%"></div></div>
			</div>
		  `;
        return li;
    }

    this.render = function (initial) {
        const sorted = players.slice().sort((a, b) => b.score - a.score || a.id - b.id);

        if (initial) {
            board.innerHTML = '';
            sorted.forEach((p, i) => board.appendChild(this.createItem(p, i + 1)));
        } else {
            const beforeRects = new Map();
            [...board.children].forEach(n => beforeRects.set(n.dataset.id, n.getBoundingClientRect()));

            sorted.forEach((p, i) => {
                const existing = board.querySelector(`[data-id='${p.id}']`);
                if (existing) {
                    existing.querySelector('.score').textContent = p.score;
                    existing.querySelector('.sub').textContent = `@${p.nick} • ${Math.max(0, dailyTarget - p.score)} pts to go`;
                    existing.querySelector('.bar').style.width = Math.min(100, (p.score / dailyTarget) * 100) + '%';
                    existing.classList.remove('top-1', 'top-2', 'top-3');
                    if (i === 0) existing.classList.add('top-1');
                    if (i === 1) existing.classList.add('top-2');
                    if (i === 2) existing.classList.add('top-3');

                    existing.querySelector('.rank').textContent = i + 1;
                    board.appendChild(existing);
                } else {
                    board.appendChild(this.createItem(p, i + 1));
                }
            });

            [...board.children].forEach(node => {
                const id = node.dataset.id;
                const before = beforeRects.get(id);
                const after = node.getBoundingClientRect();
                if (before) {
                    const dx = before.left - after.left;
                    const dy = before.top - after.top;
                    if (dx || dy) {
                        node.style.transform = `translate(${dx}px, ${dy}px)`;
                        node.classList.add('moving');
                        requestAnimationFrame(() => {
                            node.style.transform = '';
                            setTimeout(() => node.classList.remove('moving'), 520);
                        });
                    }
                }
            });
        }
    }

    this.render(true);

    this.refreshScores = function () {
        console.log(1);
        $.ajax({
            type: "GET",
            url: UrlContent("Dashboard/LeaderBoard"),
            success: function (data) {
                players.length = 0;
                scores = data;
                CFP.Leaderboard.bindPlayers();
                CFP.Leaderboard.render(true);
            }
        })
    }

    this.startReload = function () {
        if (interval) clearInterval(interval);
        interval = setInterval(() => { CFP.Leaderboard.refreshScores(); }, 1000 * 6);
    }
    this.stopReload = function () { if (interval) clearInterval(interval); interval = null }

    //this.startReload();

    board.addEventListener('click', (ev) => {
        const node = ev.target.closest('.item');
        if (!node) return;
        const id = Number(node.dataset.id);
        const p = players.find(x => x.id === id);
        if (!p) return;
        p.score = Math.min(1000, p.score + 60);
        render(false);
        node.animate([{ boxShadow: '0 0 0 rgba(0,0,0,0)' }, { boxShadow: '0 0 18px rgba(0,0,0,0.1)' }, { boxShadow: '0 0 0 rgba(0,0,0,0)' }], { duration: 700 });
    });
}