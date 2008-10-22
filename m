Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsbJ4-00050l-K0
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:51:14 +0000
Date: Wed, 22 Oct 2008 06:49:09 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/7] i386, dumpstack: Move crash_kexec before
	bust_spinlocks(0) in oops_end
Message-ID: <20081022104909.GB18951@hmsreliant.think-freely.org>
References: <1224669614-25863-1-git-send-email-heukelum@fastmail.fm>
	<1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224669614-25863-2-git-send-email-heukelum@fastmail.fm>
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

On Wed, Oct 22, 2008 at 12:00:08PM +0200, Alexander van Heukelum wrote:
> crash_kexec should not be called with console_sem held. Move
> the call before bust_spinlocks(0) in oops_end to avoid the
> problem.
> 
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
> Cc: "Neil Horman" <nhorman@tuxdriver.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>

> ---
>  arch/x86/kernel/dumpstack_32.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
> index b361475..5493d31 100644
> --- a/arch/x86/kernel/dumpstack_32.c
> +++ b/arch/x86/kernel/dumpstack_32.c
> @@ -309,6 +309,9 @@ unsigned __kprobes long oops_begin(void)
>  
>  void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  {
> +	if (regs && kexec_should_crash(current))
> +		crash_kexec(regs);
> +
>  	bust_spinlocks(0);
>  	die_owner = -1;
>  	add_taint(TAINT_DIE);
> @@ -318,8 +321,6 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
>  	if (!regs)
>  		return;
>  
> -	if (kexec_should_crash(current))
> -		crash_kexec(regs);
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
