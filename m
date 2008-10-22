Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ksbho-00034Y-Re
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 11:16:49 +0000
Date: Wed, 22 Oct 2008 07:14:42 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 4/7] x86, dumpstack: always call oops_exit from oops_end
Message-ID: <20081022111442.GE18951@hmsreliant.think-freely.org>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-5-git-send-email-heukelum@fastmail.fm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224669614-25863-5-git-send-email-heukelum@fastmail.fm>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, tglx@linutronix.de, ebiederm@xmission.com, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, vgoyal@redhat.com

On Wed, Oct 22, 2008 at 12:00:11PM +0200, Alexander van Heukelum wrote:
> Always call oops_exit from oops_end, even if signr==0.
> 
> Also, move add_taint(TAINT_DIE) from __die to oops_end
> on x86_64 and interchange two lines to make oops_end
> more similar to the i386-version.
> 
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>


Acked-by: Neil Horman <nhorman@tuxdriver.com>

> ---
>  arch/x86/kernel/dumpstack_32.c |    2 +-
>  arch/x86/kernel/dumpstack_64.c |   11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
> index 7c22f99..a29b88f 100644
> --- a/arch/x86/kernel/dumpstack_32.c
> +++ b/arch/x86/kernel/dumpstack_32.c
> @@ -318,6 +318,7 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  	__raw_spin_unlock(&die_lock);
>  	raw_local_irq_restore(flags);
>  
> +	oops_exit();
>  	if (!signr)
>  		return;
>  
> @@ -325,7 +326,6 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  		panic("Fatal exception in interrupt");
>  	if (panic_on_oops)
>  		panic("Fatal exception");
> -	oops_exit();
>  	do_exit(signr);
>  }
>  
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index 57ce11b..dc6162b 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -461,22 +461,22 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  	if (regs && kexec_should_crash(current))
>  		crash_kexec(regs);
>  
> -	die_owner = -1;
>  	bust_spinlocks(0);
> +	die_owner = -1;
> +	add_taint(TAINT_DIE);
>  	die_nest_count--;
>  	if (!die_nest_count)
>  		/* Nest count reaches zero, release the lock. */
>  		__raw_spin_unlock(&die_lock);
>  	raw_local_irq_restore(flags);
> -	if (!signr) {
> -		oops_exit();
> +	oops_exit();
> +
> +	if (!signr)
>  		return;
> -	}
>  	if (in_interrupt())
>  		panic("Fatal exception in interrupt");
>  	if (panic_on_oops)
>  		panic("Fatal exception");
> -	oops_exit();
>  	do_exit(signr);
>  }
>  
> @@ -499,7 +499,6 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
>  		return 1;
>  
>  	show_registers(regs);
> -	add_taint(TAINT_DIE);
>  	/* Executive summary in case the oops scrolled away */
>  	printk(KERN_ALERT "RIP ");
>  	printk_address(regs->ip, 1);
> -- 
> 1.5.4.3
> 
> 

-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
