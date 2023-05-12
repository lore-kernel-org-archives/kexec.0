Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1EEC77B75
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+SEwe2fooStbv68VVSPzg7Jd7DMcyoA1+n0QP5m3UhY=; b=kDHV3Hbi/hxK7E
	Euj4AFE3OLS+STLEQGzgLoy7a9g9j6h6df0hYkaUeqTITQmpGxK+tJ8Jm1FUxHiKu2Rp/l+Cby+ug
	HLEY/cYTI+6y9n6szlxrXyTrsnS+i5KS7SWwjSWkBYPbeE8krxn7e7GmjilD3cwEJXhO2HRInvCoq
	MjahUIjXKYiHIkc2faz+UZQsCcjtO3un8jOvi2QoRf6cbDpDivcsK6ue0nfBv1wv8PbzN22KpYmxy
	nFze22s2ikeS/Zz4t4hd0xhzjVlSwnPr/PFALLEMgxuvhtjdLn2FTdPb7uiWoi4a62XOVJEhPPvSb
	si8L/PXtPDDn3xfS1EKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxX7o-00CdYC-0Z;
	Fri, 12 May 2023 18:04:16 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxX7l-00CdXc-0Q
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 18:04:14 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683914651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFxNOuozAXli2+8g1C7PNYQPp9ZAqOWKvaCJaJ4AfAc=;
	b=LbHwvTDEc0hV4KAq1PUZc94tVWyRgGsAAeeXU0VmCuW3TAeKZs2uZEyLzwUfs7KS4dD38i
	wgoTZ0gz12qJirbvixaWm6i2mya+exWUqbRFt0i3/Tf1gQD9dPblbc9NTvC0Xe1aCGMexi
	BS7/VZkQmFzIJ5m36zKm8RbQWIYGqLYcL84XsZJ+d65i+DSDWSPr4o5pomszVzJd0/0UZy
	hcMpcxnoj0ioBJ8HqpZicvOhhb+2j86/n4Bc20WWyH634r6ZCt1jUTk592kO+imzmhlfXf
	SsTaJUjliki/XDWEbhkzSBFzVpkLuP2Vx9y3ZLr0tntD//WJEdHNGQVrpwEhdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683914651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFxNOuozAXli2+8g1C7PNYQPp9ZAqOWKvaCJaJ4AfAc=;
	b=cDKb0AjjgsU6KeETTwLx/yZcsZ5RLmSVquWPcafZOE/qRkv8tzXB+St5rDZRLL9PYByy2g
	ey9n95kLHFWhEzDg==
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
In-Reply-To: <20230504145023.835096-8-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
Date: Fri, 12 May 2023 20:04:11 +0200
Message-ID: <87ednlbf50.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_110413_309205_3DD8C69F 
X-CRM114-Status: GOOD (  18.07  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
> +
> +/* CPUID: leaf 1, ECX, SMX feature bit */
> +#define X86_FEATURE_BIT_SMX	(1 << 6)
> +
> +/* Can't include apiddef.h in asm */

Why not? All it needs is a #ifndef __ASSEMBLY__ guard around the C parts.

> +#define XAPIC_ENABLE	(1 << 11)
> +#define X2APIC_ENABLE	(1 << 10)
> +
> +/* Can't include traps.h in asm */

NMI_VECTOR is defined in irq_vectors.h which just has a include
<linux/threads.h> for no real good reason.

> +#define X86_TRAP_NMI	2

<SNIP>

> +/*
> + * See the comment in head_64.S for detailed informatoin on what this macro
> + * is used for.
> + */
> +#define rva(X) ((X) - sl_stub_entry)

I'm having a hard time to find that comment in head_64.S. At least it's
not in this patch.

> +.Lsl_ap_cs:
> +	/* Load the relocated AP IDT */
[ 11 more citation lines. Click/Enter to show. ]
> +	lidt	(sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
> +
> +	/* Fixup MTRRs and misc enable MSR on APs too */
> +	call	sl_txt_load_regs
> +
> +	/* Enable SMI with GETSEC[SMCTRL] */
> +	GETSEC $(SMX_X86_GETSEC_SMCTRL)
> +
> +	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
> +	leal	rva(.Lnmi_enabled_ap)(%ebx), %eax
> +	pushfl
> +	pushl	$(__SL32_CS)
> +	pushl	%eax
> +	iret

So from here on any NMI which hits the AP before it can reach the wait
loop will corrupt EDX...

> +/* This is the beginning of the relocated AP wake code block */
> +	.global sl_txt_ap_wake_begin
[ 10 more citation lines. Click/Enter to show. ]
> +sl_txt_ap_wake_begin:
> +
> +	/*
> +	 * Wait for NMI IPI in the relocated AP wake block which was provided
> +	 * and protected in the memory map by the prelaunch code. Leave all
> +	 * other interrupts masked since we do not expect anything but an NMI.
> +	 */
> +	xorl	%edx, %edx
> +
> +1:
> +	hlt
> +	testl	%edx, %edx
> +	jz	1b

This really makes me nervous. A stray NMI and the AP starts going.

Can't this NMI just bring the AP out of HLT w/o changing any state and
the AP evaluates a memory location which indicates whether it should
start up or not.

> +	/*
> +	 * This is the long absolute jump to the 32b Secure Launch protected
> +	 * mode stub code in the rmpiggy. The jump address will be fixed in

Providing an actual name for the stub might spare to rummage through
code to figure out where this is supposed to jump to.

> +	 * the SMP boot code when the first AP is brought up. This whole area
> +	 * is provided and protected in the memory map by the prelaunch code.
[ 2 more citation lines. Click/Enter to show. ]
> +	 */
> +	.byte	0xea
> +sl_ap_jmp_offset:
> +	.long	0x00000000
> +	.word	__SL32_CS

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
