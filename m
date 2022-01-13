From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 13 Jan 2022 12:15:08 -0300
Subject: [PATCH V2] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YeA1pXz7f0wqSnah@alley>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley> <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
 <YeA1pXz7f0wqSnah@alley>
Message-ID: <f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 13/01/2022 11:22, Petr Mladek wrote:
> [...]
> OK, do we have any specific reason why panic_print_sys_info()
> should get called right before kmsg_dump() when this code patch
> is used?
> 
> Alternative solution would be to remove the check of
> kexec_crash_loaded() and always call panic_print_sys_info(false)
> at the beginning (after kgdb_panic(buf)).
> 
> The advantage is that panic_print_sys_info(false) will be always
> called on the same location. It will give the same results
> in all code paths so that it will be easier to interpret them.
> And it will have the same problems so it should be easier
> to debug and maintain.
> 
> It is possible that it will not work for some users. Also it is
> possible that it might cause some problems. But it is hard to
> guess at least for me.
> 
> I think that we might try it and see if anyone complains.
> Honestly, I think that only few people use panic_printk_sys_info().
> And your use-case makes sense.
> 
> Best Regards,
> Petr

Hi Petr, thanks for your idea - it's simple and effective, would resolve
the problems in a straightforward way. But there are some cons, let me
detail more.

Currently (in linux-next), if users set panic_print but not kdump, the
panic_print_sys_info() is called *after* the panic notifiers. If user
has kdump configured and still sets panic_print (which is our use case),
then panic_print_sys_info() is called _before_ the panic notifiers. In
other words, the behavior for non-kdump users is the same as before,
since the merge of panic_print functionality.

Your idea brings the printing earlier, always before the panic
notifiers. This isn't terrible, but might lead to unfortunate and
hard-to-debug problems; for example, some panic notifiers are
rcu_panic() and hung_task_panic(), both are simple functions to disable
RCU warnings and hung task detector in panic scenarios. If we go with
your idea, these won't get called before panic_print_sys_info(), even if
kdump is not set. So, since the panic_print triggers a lot of printing
in the console, we could face a stall and trigger RCU messages, maybe
intermixed with the panic_print information.

Again, this is not the end of the world, we could live with that. But
keeping two calls - and guarding against double print using
kexec_crash_loaded() as per your idea - is completely non-invasive and
doesn't change the current behavior.

So, let me know if we should go with your idea or keep both calls but
guarding against double printing to keep the current behavior untouched.
Both ways work for me, I'm slightly inclined to the latter, but I can
rework the patch if you prefer and use your idea!
Cheers,


Guilherme

