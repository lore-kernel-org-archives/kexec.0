From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 17 May 2022 12:33:52 -0300
Subject: [PATCH 17/30] tracing: Improve panic/die notifiers
In-Reply-To: <20220511114541.GC26047@pathway.suse.cz>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-18-gpiccoli@igalia.com>
 <20220511114541.GC26047@pathway.suse.cz>
Message-ID: <31f96f73-46b5-aa6f-a5db-5052c6f3fc92@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 11/05/2022 08:45, Petr Mladek wrote:
> [...]
> DIE_OOPS and PANIC_NOTIFIER are from different enum.
> It feels like comparing apples with oranges here.
> 
> IMHO, the proper way to unify the two notifiers is
> a check of the @self parameter. Something like:
> 
> static int trace_die_panic_handler(struct notifier_block *self,
> 				unsigned long ev, void *unused)
> {
> 	if (self == trace_die_notifier && val != DIE_OOPS)
> 		goto out;
> 
> 	ftrace_dump(ftrace_dump_on_oops);
> out:
> 	return NOTIFY_DONE;
> }
> 
> Best Regards,
> Petr

OK Petr, thanks - will implement your suggestion in V2 (CC Steven)

Cheers!

