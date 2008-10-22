Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ksbf5-0006I6-IQ
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 11:13:59 +0000
Date: Wed, 22 Oct 2008 07:11:54 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 3/7] x86_64, dumpstack: move kexec_crash from __die to
	oops_end
Message-ID: <20081022111154.GD18951@hmsreliant.think-freely.org>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
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

On Wed, Oct 22, 2008 at 12:00:10PM +0200, Alexander van Heukelum wrote:
> oops_end is preceded by either a call to __die, or a conditional
> call to crash_kexec. Move the conditional call to crash_kexec
> from the end of __die to the start of oops_end and remove
> the superfluous call to crash_kexec in die_nmi.
> 
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>

Acked-by: Neil Horman <nhorman@tuxdriver.com>

> ---
>  arch/x86/kernel/dumpstack_64.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index ffefea6..57ce11b 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -458,6 +458,9 @@ unsigned __kprobes long oops_begin(void)
>  
>  void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  {
> +	if (regs && kexec_should_crash(current))
> +		crash_kexec(regs);
> +
>  	die_owner = -1;
>  	bust_spinlocks(0);
>  	die_nest_count--;
> @@ -501,8 +504,6 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
>  	printk(KERN_ALERT "RIP ");
>  	printk_address(regs->ip, 1);
>  	printk(" RSP <%016lx>\n", regs->sp);
> -	if (kexec_should_crash(current))
> -		crash_kexec(regs);
>  	return 0;
>  }
>  
> @@ -536,11 +537,9 @@ die_nmi(char *str, struct pt_regs *regs, int do_panic)
>  	printk(" on CPU%d, ip %08lx, registers:\n",
>  		smp_processor_id(), regs->ip);
>  	show_registers(regs);
> -	if (kexec_should_crash(current))
> -		crash_kexec(regs);
> +	oops_end(flags, regs, 0);
>  	if (do_panic || panic_on_oops)
>  		panic("Non maskable interrupt");
> -	oops_end(flags, regs, 0);
>  	nmi_exit();
>  	local_irq_enable();
>  	do_exit(SIGBUS);
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
