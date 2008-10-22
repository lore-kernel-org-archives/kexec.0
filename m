Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsblP-0000qc-8y
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 11:20:33 +0000
Date: Wed, 22 Oct 2008 07:18:25 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 5/7] i386, dumpstack: use x86_64's method to account
	die_nest_count
Message-ID: <20081022111825.GF18951@hmsreliant.think-freely.org>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-3-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-4-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-5-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-6-git-send-email-heukelum@fastmail.fm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224669614-25863-6-git-send-email-heukelum@fastmail.fm>
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

On Wed, Oct 22, 2008 at 12:00:12PM +0200, Alexander van Heukelum wrote:
> oops_begin/oops_end should always be used in pairs. On x86_64
> oops_begin increments die_nest_count, and oops_end decrements
> die_nest_count. Doing this makes oops_begin and oops_end equal
> to the x86_64 versions.
> 
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>

Acked-by: Neil Horman <nhorman@tuxdriver.com>


> ---
>  arch/x86/kernel/dumpstack_32.c |   29 +++++++++++++++++------------
>  1 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
> index a29b88f..7c7d691 100644
> --- a/arch/x86/kernel/dumpstack_32.c
> +++ b/arch/x86/kernel/dumpstack_32.c
> @@ -289,21 +289,24 @@ static unsigned int die_nest_count;
>  
>  unsigned __kprobes long oops_begin(void)
>  {
> +	int cpu;
>  	unsigned long flags;
>  
>  	oops_enter();
>  
> -	if (die_owner != raw_smp_processor_id()) {
> -		console_verbose();
> -		raw_local_irq_save(flags);
> -		__raw_spin_lock(&die_lock);
> -		die_owner = smp_processor_id();
> -		die_nest_count = 0;
> -		bust_spinlocks(1);
> -	} else {
> -		raw_local_irq_save(flags);
> +	/* racy, but better than risking deadlock. */
> +	raw_local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	if (!__raw_spin_trylock(&die_lock)) {
> +		if (cpu == die_owner)
> +			/* nested oops. should stop eventually */;
> +		else
> +			__raw_spin_lock(&die_lock);
>  	}
>  	die_nest_count++;
> +	die_owner = cpu;
> +	console_verbose();
> +	bust_spinlocks(1);
>  	return flags;
>  }
>  
> @@ -315,13 +318,15 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  	bust_spinlocks(0);
>  	die_owner = -1;
>  	add_taint(TAINT_DIE);
> -	__raw_spin_unlock(&die_lock);
> +	die_nest_count--;
> +	if (!die_nest_count)
> +		/* Nest count reaches zero, release the lock. */
> +		__raw_spin_unlock(&die_lock);
>  	raw_local_irq_restore(flags);
> -
>  	oops_exit();
> +
>  	if (!signr)
>  		return;
> -
>  	if (in_interrupt())
>  		panic("Fatal exception in interrupt");
>  	if (panic_on_oops)
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
