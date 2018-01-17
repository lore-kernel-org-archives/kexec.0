Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebjXX-0007Ne-HF
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 08:57:49 +0000
Date: Wed, 17 Jan 2018 09:57:34 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180117085734.jx77p3brjykk3ude@pathway.suse.cz>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
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

On Wed 2018-01-17 12:50:57, Dave Young wrote:
> It is useful to print kdump kernel loaded status in dump_stack() 
> especially when panic happens so that we can  differenciate 
> kdump kernel early hang and a normal panic in a bug report.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kernel/printk/printk.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-x86.orig/kernel/printk/printk.c
> +++ linux-x86/kernel/printk/printk.c
> @@ -48,6 +48,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/kexec.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/sections.h>
> @@ -3127,6 +3128,8 @@ void dump_stack_print_info(const char *l
>  	if (dump_stack_arch_desc_str[0] != '\0')
>  		printk("%sHardware name: %s\n",
>  		       log_lvl, dump_stack_arch_desc_str);
> +	if (kexec_crash_loaded())
> +		printk("%skdump kernel loaded\n", log_lvl);

IMHO, it would be better to do it like for the workqueues.
I mean to call printk_kexec_info(log_lv1, current) here
that would be impletemented in kexec sources.
Then it could be maintained by kexec people.

Anyway, I wonder if the info about kexec_crash_loaded() is
enough. I am not much familiar with kexec. AFAIK,
the image might be loaded long time before it
is acutally used.

Finally, the style of the other lines is:

    Name: details

I would suggest to print something like:

    Kexec: details

, where the details might be whether the image is loaded,
whether the loaded kernel is being executed, and
other kexec-related flags.

How does that sound?

>  	print_worker_info(log_lvl, current);
>  }

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
