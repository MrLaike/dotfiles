void
grid(Monitor *m) {
	unsigned int i, n, cx, cy, cw, ch, aw, ah, cols, rows;
	Client *c;

    unsigned int g = 6;

	for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next))
		n++;

	/* grid dimensions */
	for(rows = 0; rows <= n/2; rows++)
		if(rows*rows >= n)
			break;
	cols = (rows && (rows - 1) * rows >= n) ? rows - 1 : rows;

	/* window geoms (cell height/width) */
	ch = m->wh / (rows ? rows : 1) - g;
	cw = m->ww / (cols ? cols : 1) - g;
	for(i = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next)) {
		cx = m->wx + (i / rows) * cw + g/2;
		cy = m->wy + (i % rows) * ch + g/2;
		/* adjust height/width of last row/column's windows */
		ah = ((i + 1) % rows == 0) ? m->wh - ch * rows : 0;
		aw = (i >= rows * (cols - 1)) ? m->ww - cw * cols : 0;
		resize(c, cx, cy, cw - 2 * c->bw + aw - g, ch - 2 * c->bw + ah - g, False);
		i++;
	}
}

void
fibonacci(Monitor *mon, int s) {
	unsigned int i, n, nx, ny, nw, nh;
	Client *c;

    unsigned int g = 6;

	for(n = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next), n++);
	if(n == 0)
		return;
	
	nx = mon->wx + g;
	ny = 0 + g;
	nw = mon->ww - g;
	nh = mon->wh - g;
	
	for(i = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next)) {
		if((i % 2 && nh / 2 > 2 * c->bw)
		   || (!(i % 2) && nw / 2 > 2 * c->bw)) {
			if(i < n - 1) {
				if(i % 2)
					nh /= 2;
				else
					nw /= 2;
				if((i % 4) == 2 && !s)
					nx += nw;
				else if((i % 4) == 3 && !s)
					ny += nh;
			}
			if((i % 4) == 0) {
				if(s)
					ny += nh;
				else
					ny -= nh;
			}
			else if((i % 4) == 1)
				nx += nw;
			else if((i % 4) == 2)
				ny += nh;
			else if((i % 4) == 3) {
				if(s)
					nx += nw;
				else
					nx -= nw;
			}
			if(i == 0)
			{
				if(n != 1)
					nw = mon->ww * mon->mfact;
				ny = mon->wy + g;
			}
			else if(i == 1)
				nw = mon->ww - nw - g;
			i++;
		}
		resize(c, nx, ny, nw - 2 * c->bw - g, nh - 2 * c->bw - g, False);
	}
}

void
dwindle(Monitor *mon) {
	fibonacci(mon, 1);
}

void
spiral(Monitor *mon) {
	fibonacci(mon, 0);
}

