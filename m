Return-path: <kexec-bounces@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IkZnI-0007X5-Jl
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 07:32:49 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l9O5KL4u029890
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 01:20:21 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9O6TMlc118216
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 00:29:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9O6TMWg011877
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 00:29:22 -0600
Date: Wed, 24 Oct 2007 11:59:33 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 1/3] x86: add lapic_shutdown for x86_64
Message-ID: <20071024062933.GA4622@in.ibm.com>
References: <47195763.1090803@ct.jp.nec.com> <47195807.6030809@ct.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47195807.6030809@ct.jp.nec.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: hbabu@us.ibm.com, tglx@linutronix.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Oct 19, 2007 at 06:21:11PM -0700, Hiroshi Shimamoto wrote:
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> ---
>  arch/x86/kernel/apic_64.c |   14 ++++++++++++++
>  include/asm-x86/apic_64.h |    1 +
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic_64.c b/arch/x86/kernel/apic_64.c
> index f47bc49..f28ccb5 100644
> --- a/arch/x86/kernel/apic_64.c
> +++ b/arch/x86/kernel/apic_64.c
> @@ -287,6 +287,20 @@ void disable_local_APIC(void)
>  	apic_write(APIC_SPIV, value);
>  }
> 
> +void lapic_shutdown(void)
> +{
> +	unsigned long flags;
> +
> +	if (!cpu_has_apic)
> +		return;
> +
> +	local_irq_save(flags);
> +
> +	disable_local_APIC();
> +
> +	local_irq_restore(flags);
> +}
> +
>  /*

Do we really have to introduce this function for 64bit? I remember some
issues were faced on i386 w.r.t kernel enabling the LAPIC against the
wishes of BIOS hence kernel was disabling it while shutting down. No
such problems were reported for x86_64 hence this function existed only
for i386.

If that is the case, probably we don't have to introduce lapic_shutdown()
for x86_64. Instead call lapic_shutdown() for X86_32, and disble_local_APIC()
otherwise?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
