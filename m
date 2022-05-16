From: Petr Mladek <pmladek@suse.com>
Date: Mon, 16 May 2022 16:56:41 +0200
Subject: [PATCH 25/30] panic, printk: Add console flush parameter and
 convert panic_print to a notifier
In-Reply-To: <20220427224924.592546-26-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-26-gpiccoli@igalia.com>
Message-ID: <YoJmKYLzPZqCDDim@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-04-27 19:49:19, Guilherme G. Piccoli wrote:
> Currently the parameter "panic_print" relies in a function called
> directly on panic path; one of the flags the users can set for
> panic_print triggers a console replay mechanism, to show the
> entire kernel log buffer (from the beginning) in a panic event.
> 
> Two problems with that: the dual nature of the panic_print
> isn't really appropriate, the function was originally meant
> to allow users dumping system information on panic events,
> and was "overridden" to also force a console flush of the full
> kernel log buffer. It also turns the code a bit more complex
> and duplicate than it needs to be.
> 
> This patch proposes 2 changes: first, we decouple panic_print
> from the console flushing mechanism, in the form of a new kernel
> core parameter (panic_console_replay); we kept the functionality
> on panic_print to avoid userspace breakage, although we comment
> in both code and documentation that this panic_print usage is
> deprecated.
> 
> We converted panic_print function to a panic notifier too, adding
> it on the panic informational notifier list, executed as the final
> callback. This allows a more clear code and makes sense, as
> panic_print_sys_info() is really a panic-time only function.
> We also moved its code to kernel/printk.c, it seems to make more
> sense given it's related to printing stuff.

I really like both changes. Just please split it them into two
patchset. I mean one patch for the new "panic_console_replay"
parameter and 2nd that moves "printk_info" into the notifier.

Best Regards,
Petr

