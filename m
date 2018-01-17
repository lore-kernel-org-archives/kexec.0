Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebnz4-00079q-Vj
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 13:42:34 +0000
Date: Wed, 17 Jan 2018 14:42:17 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180117134217.6gjr5ep3g2ns2v3w@pathway.suse.cz>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <20180117085734.jx77p3brjykk3ude@pathway.suse.cz>
 <20180117123244.GA1503@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180117123244.GA1503@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: sergey.senozhatsky@gmail.com, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org

On Wed 2018-01-17 20:32:44, Dave Young wrote:
> Hi,
> 
> Thanks for your comments.
> On 01/17/18 at 09:57am, Petr Mladek wrote:
> > On Wed 2018-01-17 12:50:57, Dave Young wrote:
> > > It is useful to print kdump kernel loaded status in dump_stack() 
> > > especially when panic happens so that we can  differenciate 
> > > kdump kernel early hang and a normal panic in a bug report.
> > >
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > ---
> > >  kernel/printk/printk.c |    3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > --- linux-x86.orig/kernel/printk/printk.c
> > > +++ linux-x86/kernel/printk/printk.c
> > > @@ -48,6 +48,7 @@
> > >  #include <linux/sched/clock.h>
> > >  #include <linux/sched/debug.h>
> > >  #include <linux/sched/task_stack.h>
> > > +#include <linux/kexec.h>
> > >  
> > >  #include <linux/uaccess.h>
> > >  #include <asm/sections.h>
> > > @@ -3127,6 +3128,8 @@ void dump_stack_print_info(const char *l
> > >  	if (dump_stack_arch_desc_str[0] != '\0')
> > >  		printk("%sHardware name: %s\n",
> > >  		       log_lvl, dump_stack_arch_desc_str);
> > > +	if (kexec_crash_loaded())
> > > +		printk("%skdump kernel loaded\n", log_lvl);
> > 
> > IMHO, it would be better to do it like for the workqueues.
> > I mean to call printk_kexec_info(log_lv1, current) here
> > that would be impletemented in kexec sources.
> > Then it could be maintained by kexec people.
> > 
> > Anyway, I wonder if the info about kexec_crash_loaded() is
> > enough. I am not much familiar with kexec. AFAIK,
> > the image might be loaded long time before it
> > is acutally used.
> 
> kexec_crash_loaded is enough, we only care if kdump kernel being
> loaded or not, nothing else, no matter how long it has been loaded.
> In Fedora/RHEL a kdump service takes care of loading the kernel but
> it runs after networking is ready.  If people want to save
> the vmcore to nfs/ssh then we need detect network and build the
> initramfs. In the nfs/ssh case if some networking code panicked it
> is possible that kdump service has not started, but sometimes bug
> can not be easily reproduced thus nobody can know if kdump is active
> or not.

I see.

> Since kexec_crash_loaded() is already in kexec souce code, and it
> is the only thing need to know, do you think it is really necessary
> to add a printk_kexec_info()?  I can do it if you strongly suggest
> to do so.

No, the original approach is fine if it is really that simple ;-)

> > 
> > Finally, the style of the other lines is:
> > 
> >     Name: details
> > 
> > I would suggest to print something like:
> > 
> >     Kexec: details
> > 
> > , where the details might be whether the image is loaded,
> > whether the loaded kernel is being executed, and
> > other kexec-related flags.
> 
> Will do, it can be something like:
> Kexec: kdump kernel loaded

Looks good to me. With this message, I could give this
patch even

Reviewed-by: Petr Mladek <pmladek@suse.com>

I could update the string when pushing into printk.git.
I am just going to wait a bit for more feedback if any.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
