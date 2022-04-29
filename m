From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 29 Apr 2022 09:23:51 -0400
Subject: [PATCH 17/30] tracing: Improve panic/die notifiers
In-Reply-To: <b8771b37-01f5-f50b-dbb3-9db4ee26e67e@gmail.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-18-gpiccoli@igalia.com>
 <b8771b37-01f5-f50b-dbb3-9db4ee26e67e@gmail.com>
Message-ID: <20220429092351.10bca4dd@gandalf.local.home>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 29 Apr 2022 12:22:44 +0300
Sergei Shtylyov <sergei.shtylyov@gmail.com> wrote:

> > +	switch (ev) {
> > +	case DIE_OOPS:
> > +		do_dump = 1;
> > +		break;
> > +	case PANIC_NOTIFIER:
> > +		do_dump = 1;
> > +		break;  
> 
>    Why not:
> 
> 	case DIE_OOPS:
> 	case PANIC_NOTIFIER:
> 		do_dump = 1;
> 		break;

Agreed.

Other than that.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

