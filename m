Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1efHcl-0001MV-Ch
 for kexec@lists.infradead.org; Sat, 27 Jan 2018 03:57:53 +0000
Date: Sat, 27 Jan 2018 11:57:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180127035732.GB26591@dhcp-128-65.nay.redhat.com>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180118135704.62d0f79f@gandalf.local.home>
 <20180119044719.GA3985@dhcp-128-65.nay.redhat.com>
 <20180126073724.GA27220@dhcp-128-65.nay.redhat.com>
 <20180126121757.kec5ecxfxf5fprbi@pathway.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180126121757.kec5ecxfxf5fprbi@pathway.suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andi Kleen <ak@linux.intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On 01/26/18 at 01:17pm, Petr Mladek wrote:
> On Fri 2018-01-26 15:37:24, Dave Young wrote:
> > On 01/19/18 at 12:47pm, Dave Young wrote:
> > > On 01/18/18 at 01:57pm, Steven Rostedt wrote:
> > > > On Thu, 18 Jan 2018 10:02:17 -0800
> > > > Andi Kleen <ak@linux.intel.com> wrote:
> > > > 
> > > > > Dave Young <dyoung@redhat.com> writes:
> > > > > >  		printk("%sHardware name: %s\n",
> > > > > >  		       log_lvl, dump_stack_arch_desc_str);
> > > > > > +	if (kexec_crash_loaded())
> > > > > > +		printk("%skdump kernel loaded\n", log_lvl);  
> > > > > 
> > > > > Oops/warnings are getting longer and longer, often scrolling away
> > > > > from the screen, and if the kernel crashes backscroll does not work
> > > > > anymore, so precious information is lost.
> > > > > 
> > > > > Can you merge it with some other line?
> > > > > 
> > > > > Just a [KDUMP] or so somewhere should be good enough.
> > > > 
> > > > Or perhaps we should add it as a TAINT. Not all taints are bad.
> > > 
> > > Hmm, I also thought about this before but It sounds like not match the
> > > "tainted" meaning with the assumption that it is bad :(
> > > 
> > > Maybe it would be better to do like Andi said, but print a better word
> > > than "KDUMP", eg. "Kdumpable" sounds better.  If this is fine I can
> > > repost the patch.
> > 
> > I have been not available recently, sorry for late about the update,
> > rethinking about this, it is looks good to use "[KDUMP]".  Also for
> > the tainted flags, I tried but it is not what we want since kdump kernel
> > can be unloaded, this is not like "tainted" which can only be added and
> > it can not be removed.
> > 
> > How about below version?
> > ---
> > 
> > It is useful to print kdump kernel loaded status in dump_stack() 
> > especially when panic happens so that we can  differentiate
> > kdump kernel early hang and a normal panic in a bug report.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> > [v1 -> v2] merge the status in other line as Andi Kleen suggested
> >  kernel/printk/printk.c |    3 +++
> > --- linux.orig/kernel/printk/printk.c
> > +++ linux/kernel/printk/printk.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/sched/clock.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched/task_stack.h>
> > +#include <linux/kexec.h>
> >  
> >  #include <linux/uaccess.h>
> >  #include <asm/sections.h>
> > @@ -3118,9 +3119,11 @@ void __init dump_stack_set_arch_desc(con
> >   */
> >  void dump_stack_print_info(const char *log_lvl)
> >  {
> > -	printk("%sCPU: %d PID: %d Comm: %.20s %s %s %.*s\n",
> > +	printk("%sCPU: %d PID: %d Comm: %.20s %s %s %s %.*s\n",
> >  	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
> > -	       print_tainted(), init_utsname()->release,
> > +	       print_tainted(),
> > +	       kexec_crash_loaded() ? "[KDUMP]" : "",
> 
> I am afraid that people might be confused what that exactly means.
> For example, if I would wonder if it was already running the crashdump
> kernel.
> 
> And two small nits. It always prints the extra space. It does not fit
> the style of the line.
> 
> What about the following?
> 
> 	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
> 	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
> 	       kexec_crash_loaded() ? "Kdump: loaded " : "",
> 	       print_tainted(),
> 	       init_utsname()->release,
> 	       (int)strcspn(init_utsname()->version, " "),
> 	       init_utsname()->version);
> 
> It would produce something like:
> 
> CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 4.14.0-4-default+ #670

That should be a better version, thanks for catching the extra 
whitespace. Let me do a test and send it out as V2 separately.

> 
> 
> Best Regards,
> Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
