/* See LICENSE file for copyright and license details. */

#include "layouts.c"
#include <X11/X.h>

/* appearance */
static unsigned int borderpx  = 1;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static char font[]            = "Fora Code:size=10";
static char dmenufont[]       = "Fora Code:size=10";
static const char *fonts[]          = { font };
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  normbgcolor,  selbordercolor  },
};

static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-p", "run: ", NULL };
static const char *screenshotcmd[] = { "screenshot", NULL };
static char *screencmd[] = { "flameshot", "gui", NULL };
static char *slockcmd[] = { "slock", NULL };

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "copyq",    NULL,       NULL,       0,            1,           -1 },
};

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[Λ]",      spiral },
	{ "HHH",      grid },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[]=",      tile },    /* first entry is default */
	{ "[\\]",     dwindle },
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },



/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]  = { "st", NULL };

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "font",               STRING,  &font },
		{ "dmenufont",          STRING,  &dmenufont },
		{ "background",        STRING,  &normbgcolor },
		{ "color3",    STRING,  &normbordercolor },
		{ "foreground",        STRING,  &normfgcolor },
		{ "color2",         STRING,  &selbgcolor },
		{ "color4",     STRING,  &selbordercolor },
		{ "color3",         STRING,  &selfgcolor },
		{ "color6",          	INTEGER, &borderpx },
		{ "snap",          		INTEGER, &snap },
		{ "showbar",          	INTEGER, &showbar },
		{ "topbar",          	INTEGER, &topbar },
		{ "nmaster",          	INTEGER, &nmaster },
		{ "resizehints",       	INTEGER, &resizehints },
		{ "mfact",      	 	FLOAT,   &mfact },
};


static const Key keys[] = {
	/* modifier                     key        function            argument */
	{ MODKEY,                       XK_d,      spawn,              {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,              {.v = termcmd } },
	{ MODKEY|ControlMask,           XK_l,      spawn,              {.v = slockcmd } },
	{ MODKEY,                       XK_b,      togglebar,          {0} },
	{ MODKEY,                       XK_j,      focusstack,         {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,         {.i = -1 } },
	/*{ MODKEY,                       XK_i,      incnmaster,         {.i = +1 } },*/
	/*{ MODKEY,                       XK_p,      incnmaster,         {.i = -1 } },*/
	{ MODKEY,                       XK_h,      setmfact,           {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,           {.f = +0.05} },
	{ MODKEY,                       XK_f,      togglefullscreen,   {0} },
	{ MODKEY,                       XK_Tab,    view,               {0} },
	{ MODKEY,                       XK_q,      killclient,         {0} },
	{ MODKEY|ShiftMask,             XK_space,  layoutscroll,       {.i = -1} },
	{ MODKEY,                       XK_space,  layoutscroll,       {.i = +1} },
	{ MODKEY,                       XK_0,      view,               {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,                {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,           {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,           {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,             {.i = +1 } },
	{ MODKEY,                       XK_r,      reload_xresources,  {.v = NULL } },
	{ MODKEY,                       XK_p,      spawn,			   {.v = screenshotcmd } },
	{ 0,                            XK_Print,  spawn,              {.v = screencmd } },
	TAGKEYS(                        XK_1,                          0)
	TAGKEYS(                        XK_2,                          1)
	TAGKEYS(                        XK_3,                          2)
	TAGKEYS(                        XK_4,                          3)
	TAGKEYS(                        XK_5,                          4)
	TAGKEYS(                        XK_6,                          5)
	TAGKEYS(                        XK_7,                          6)
	TAGKEYS(                        XK_8,                          7)
	TAGKEYS(                        XK_9,                          8)
	{ MODKEY|ShiftMask,             XK_q,      quit,               {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

