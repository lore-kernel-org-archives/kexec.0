From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 May 2022 16:11:06 +0200
Subject: [PATCH 20/30] panic: Add the panic informational notifier list
In-Reply-To: <20220427224924.592546-21-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-21-gpiccoli@igalia.com>
Message-ID: <YoJbeuTNBXOIypSH@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:14, Guilherme G. Piccoli wrote:
> The goal of this new panic notifier is to allow its users to
> register callbacks to run earlier in the panic path than they
> currently do. This aims at informational mechanisms, like dumping
> kernel offsets and showing device error data (in case it's simple
> registers reading, for example) as well as mechanisms to disable
> log flooding (like hung_task detector / RCU warnings) and the
> tracing dump_on_oops (when enabled).
> 
> Any (non-invasive) information that should be provided before
> kmsg_dump() as well as log flooding preventing code should fit
> here, as long it offers relatively low risk for kdump.
> 
> For now, the patch is almost a no-op, although it changes a bit
> the ordering in which some panic notifiers are executed - specially
> affected by this are the notifiers responsible for disabling the
> hung_task detector / RCU warnings, which now run first. In a
> subsequent patch, the panic path will be refactored, then the
> panic informational notifiers will effectively run earlier,
> before ksmg_dump() (and usually before kdump as well).
> 
> We also defer documenting it all properly in the subsequent
> refactor patch. Finally, while at it, we removed some useless
> header inclusions too.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

All notifiers moved in this patch seems to fit well the "info"
notifier list. The patch looks good from this POV.

I still have to review the rest of the patches to see if it
is complete.

Best Regards,
Petr

