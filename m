Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVaJs-0002OQ-2g
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 08:49:44 +0000
Date: Mon, 23 Jan 2017 16:48:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] x86/crash: Update the stale comment in
 reserve_crashkernel()
Message-ID: <20170123084850.GA15988@dhcp-128-65.nay.redhat.com>
References: <1485154103-18426-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1485154103-18426-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Robert LeBlanc <robert@leblancnet.us>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>

Hi, Xunlei

On 01/23/17 at 02:48pm, Xunlei Pang wrote:
> CRASH_KERNEL_ADDR_MAX has been missing for a long time,
> update it with more detailed explanation.
> 
> Cc: Robert LeBlanc <robert@leblancnet.us>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  arch/x86/kernel/setup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 4cfba94..c32a167 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -575,7 +575,9 @@ static void __init reserve_crashkernel(void)
>  	/* 0 means: find the address automatically */
>  	if (crash_base <= 0) {
>  		/*
> -		 *  kexec want bzImage is below CRASH_KERNEL_ADDR_MAX
> +		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory
> +		 * as old kexec-tools loads bzImage below that, unless
> +		 * "crashkernel=size[KMG],high" is specified.

There is already comment before the define of those macros, also
there are 32bit case which has a different reason about 512M there as
well.

So it looks better to just drop the one line comment without adding
further comments here.
>  		 */
>  		crash_base = memblock_find_in_range(CRASH_ALIGN,
>  						    high ? CRASH_ADDR_HIGH_MAX
> -- 
> 1.8.3.1
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
