Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20658C4321E
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zhek/Dxj/0GlFT+pzisca/1x+otsrRK5E7fd3D5Pj8I=; b=fRRdj1T4FblZPm
	gwrxsO63cBfhPsPVTOBj7d/ffAvY8YvFtiuePebAs8I5/qhqSFfaXpnC7aCd8m+UzO6WyZFQC18yV
	9yQl0VZuqXKX6aEQfYnKcH5UOke+VysuycOSTtjNQx4DZFZZ+/NP2MjhOt0yphypFdw5ltrOIJg3p
	B7YQrNTkB7QfJd14tTFsxoAYqTxi6pqMKRgJETee825fongh897+LDgKsfa+GWcbj/qJBpqmtZXrL
	wK3EiC7tpPxOvUuWYBsRWZEeoyuwYY+CDTvrwX1XuMAOvokuNMkKrYlKDlWdoHa/HvargmH6eG5tq
	J3ISRJLDKmXpu9XWtXaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozmng-004dRv-Ex; Mon, 28 Nov 2022 22:40:32 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozmne-004dPg-9l
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 22:40:31 +0000
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 646F81EC042F;
	Mon, 28 Nov 2022 23:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1669675223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=lZmQ7j7zgK9JHgQnY7ydnqQbz44P4Bhdp+DPFB7I0JE=;
	b=JmX75N2bOGozIbq6a9mlp2lFnrW28dA6Bv62M/XaNO5nThh4xGC/EVb1FYs0RDQPA2dXpG
	mNTFLP+uVGAJLyMlCnqGzgeD3+qsXBcJSX2X6Wu2RSoDIcazWV9/lb6/xZ+MFrEdH0RjLw
	+ggtTzGAP56gM6H7IkB3AiLfjFKJgHo=
Date: Mon, 28 Nov 2022 23:40:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y4U40wKoSF/ze1Ud@zn.tnic>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128220358.n5vk6youcdl2er35@desk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_144030_517393_3CE4438E 
X-CRM114-Status: GOOD (  14.81  )
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

On Mon, Nov 28, 2022 at 02:03:58PM -0800, Pawan Gupta wrote:
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..cfc2ed2661fc 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
>   */
>  void write_spec_ctrl_current(u64 val, bool force)
>  {
> -	if (this_cpu_read(x86_spec_ctrl_current) == val)
> +	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
>  		return;
>  	this_cpu_write(x86_spec_ctrl_current, val);

Still looks hacky to me.

I think it would be a lot cleaner if MSR_IA32_SPEC_CTRL gets cleaned of
the speculation bits in init_speculation_control() which gets run on
*every* CPU.

So by the time check_bugs() gets to setup stuff, the MSR will be ready
to go regardless.

I.e., something like this (not supposed to work - just to show what I
mean):

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 73cc546e024d..367732c92942 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -993,9 +993,19 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	 * Intel CPUs, for finer-grained selection of what's available.
 	 */
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
+		u64 msr;
+
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+
+		/*
+		 * Clear speculation control settings from a previous kernel
+		 * run, i.e., kexec.
+		 */
+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
+		if (msr & SPEC_CTRL_MASK)
+			wrmsr (MSR_IA32_SPEC_CTRL, msr & ~SPEC_CTRL_MASK);
 	}
 
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
