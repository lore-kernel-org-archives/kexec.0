Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebpxT-0008Gu-Qj
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 15:49:01 +0000
Date: Wed, 17 Jan 2018 10:48:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180117104844.7ae779d2@gandalf.local.home>
In-Reply-To: <20180117134217.6gjr5ep3g2ns2v3w@pathway.suse.cz>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <20180117085734.jx77p3brjykk3ude@pathway.suse.cz>
 <20180117123244.GA1503@dhcp-128-65.nay.redhat.com>
 <20180117134217.6gjr5ep3g2ns2v3w@pathway.suse.cz>
MIME-Version: 1.0
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, sergey.senozhatsky@gmail.com, Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On Wed, 17 Jan 2018 14:42:17 +0100
Petr Mladek <pmladek@suse.com> wrote:

> > kexec_crash_loaded is enough, we only care if kdump kernel being
> > loaded or not, nothing else, no matter how long it has been loaded.
> > In Fedora/RHEL a kdump service takes care of loading the kernel but
> > it runs after networking is ready.  If people want to save
> > the vmcore to nfs/ssh then we need detect network and build the
> > initramfs. In the nfs/ssh case if some networking code panicked it
> > is possible that kdump service has not started, but sometimes bug
> > can not be easily reproduced thus nobody can know if kdump is active
> > or not.  
> 
> I see.
> 
> > Since kexec_crash_loaded() is already in kexec souce code, and it
> > is the only thing need to know, do you think it is really necessary
> > to add a printk_kexec_info()?  I can do it if you strongly suggest
> > to do so.  
> 
> No, the original approach is fine if it is really that simple ;-)

I have to ask. Why is dump_stack_print_info() in printk to begin with.
It seems to be an odd place to put it, and not something I would think
should be in the printk() subsystem anyway. Why is it not in
lib/dump_stack.c?


> 
> > > 
> > > Finally, the style of the other lines is:
> > > 
> > >     Name: details
> > > 
> > > I would suggest to print something like:
> > > 
> > >     Kexec: details
> > > 
> > > , where the details might be whether the image is loaded,
> > > whether the loaded kernel is being executed, and
> > > other kexec-related flags.  
> > 
> > Will do, it can be something like:
> > Kexec: kdump kernel loaded  
> 
> Looks good to me. With this message, I could give this
> patch even
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I could update the string when pushing into printk.git.
> I am just going to wait a bit for more feedback if any.

The patch looks fine to me.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
