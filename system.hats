extern fun getchar (): int = "xgetchar"
extern fun puts (s: string): size_t = "xputs"
extern fun getcga (): [l:agz] (char @ l | ptr l) = "xgetcga"
extern fun rand (): int = "xrand"
extern fun textmode {l:agz} (pf: char @ l | p : ptr l): void = "xtextmode"
extern fun write_color (p : ptr, y: int, color: int, upper_bound: int, lower_bound: int): void = "xwrite_color"

