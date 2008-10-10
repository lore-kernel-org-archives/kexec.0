Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ko94t-0001Iy-Kt
	for kexec@lists.infradead.org; Fri, 10 Oct 2008 03:54:12 +0000
Subject: Re: [RFC] powerpc: add kexec support on Book-E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1222896024-22172-2-git-send-email-sebastian@breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-2-git-send-email-sebastian@breakpoint.cc>
Date: Fri, 10 Oct 2008 14:53:46 +1100
Message-Id: <1223610826.8157.142.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
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
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

On Wed, 2008-10-01 at 23:20 +0200, Sebastian Andrzej Siewior wrote:

> +#define KEXEC_MODE_NOMMU 1
> +#define KEXEC_MODE_BOOKE 2

No need for runtime detection here, you cannot and likely never will be
able to build a kernel that does bot BookE and real mode...

> +
> +/* 1. Find the index of the entry we're executing in */
> +	bl	invstr			/* Find our address */
> +invstr:
> +	mflr	r6			/* Make it accessible */
> +	mfmsr	r7
> +	rlwinm	r4,r7,27,31,31		/* extract MSR[IS] */
> +	mfspr	r7, SPRN_PID0
> +	slwi	r7,r7,16
> +	or	r7,r7,r4
> +	mtspr	SPRN_MAS6,r7
> +	tlbsx	0,r6			/* search MSR[IS], SPID=PID0 */
> +	mfspr	r7,SPRN_MAS1
> +	andis.	r7,r7,MAS1_VALID@h
> +	bne	match_TLB

This isn't just BookE .. it's specifically FSL BookE (or "merged"
architecture). This isn't going to work on 44x for example. You need to
make it clearer.

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
