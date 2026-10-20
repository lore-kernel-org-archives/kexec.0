Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD51606A321
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RdHLLUEz;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gq9K9tje
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lfZbqFmLr8Q6MECdNX562ifwqH83lxZBW8nCUfGoGTs=; b=RdHLLUEzeJBcJfi55PWDam254f
	C1SriwudhM50FT8jKiPednG5Wy29EGCXU4eFo9HpkmV2V8y0X89+fHzyJzstt8VihOL1vuqFNcZnP
	VdbFDa3w7DUjB45Fa1bcH7229lz8+f+p72cfqfK9Oq8WM91fFTNYn3ZPzo3Q+KbiJDJbzJqUZNnxO
	OrkW1yh/KKkzZEF22/jqp7p2E5O/jDnCoH7tB1JjDmQUkNSeuAsCamOivjjAURpyNlOtaSMXdFg8q
	XdonDKIvUyY2ltvAm1vxlstD0W9U7Hs4JYNe44SQ1XgZ+iV8tYEFklwrKOdgqsEK4ZKBBxcnbW3ZX
	c2ge4RCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8xi-00000009fMe-1tfh;
	Tue, 20 Oct 2026 12:29:02 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8xf-00000009fLd-3Akz
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 12:29:01 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2743499f8f.0
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792499338; x=1793104138; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfZbqFmLr8Q6MECdNX562ifwqH83lxZBW8nCUfGoGTs=;
        b=gq9K9tjeEUHEur1QYCfFk5tS9xZFh6Y58Y2Vu9orYkZf4sLKMOXChu/sOam8tvEyTm
         DBUUsLRLbtvN83gNaOsBzVr9zXXAYymLQgyQ9Yysc2Z4kQgDJ2kQGW1GJNGdNepoK/6S
         FZTcuYCrvbIVQ1tVZwCGvOzmrWDGKTujqqmfaWJPSUF7EOEXHdQMnqgUVglwsIHhBbN0
         K/OxayBhPb9F3x+w4ceoK4B8CnnVdhodJ/5EzdGMCM8q5THTLR8rTbpU81m+0kY+nazy
         JLf3aWy7nCgOqWSqvdRzFwB0sBlI8UTBtKFX3wEgqwZFFCf0o9iYXsc+GpuVncZhcibj
         QNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499338; x=1793104138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfZbqFmLr8Q6MECdNX562ifwqH83lxZBW8nCUfGoGTs=;
        b=iE+2Ya/domxJuxbpnBAaywDdfdsWHgejzzrkVgcZnuuFEieLCD3+E9sw5EpjX9c8eo
         TEcQNbgd83CnJ7vsaqQJo7Xig3QMJkX6x9f+PSmLXvnVZCd4RajsJneM+7CAVqNwVFDW
         X4aNcVHxmt/lMJAV4WEbMsQRuD8bQkX61wz6d0tBsXhomXFR2u+qCY1O6kTsKIs6IvfF
         u+IoMJFS/pUY61wCu68gQItnaYJg/0HSSIN6Cw9GkBdmGtzUMnGEMzjxTFsUnSdbh2hT
         xMLTDRqeyuSaZiUbjhLeyNtnxCHBRRdshRw1tbcKr3ZSMRvNfT7/P88jvJ/Pa7F41U+8
         W0FA==
X-Forwarded-Encrypted: i=1; AKwUvBw99WyWnunoehfPb4oO2Q9BC7AQe828W9mkYGJSXyQ6sUI5PyGuPIEcjxNmsPYzlVNVSqzo7g==@lists.infradead.org
X-Gm-Message-State: AFq9FYIhgHhzEkoOU3VMYG7XyEzEx4/G1IbhiRl9/aCoc9sDqz/0VGm1
	1eG9Z+VW2R7DXh2AFKxgE8Zps/yy7reWSM0lZ8wFqtf+fCwSUtzrS9TKisGCqsP/deE=
X-Gm-Gg: AYBFou1QkooNvSlNil3pzNVx/16YarmtN6JxbvJ9rN98hZVwtcmoloxwOPHPJ4BAzxW
	BYwPhrrWh8QnYcxLKlvLLa3OCX014dF2wENmPGlTkX2WiAqTlZ9pYL2FpxPUMVYVkz9EFsUVcBs
	xhvIGV83R+P+0uhZDrQix5tONQD84NmjdBzwDjTPb/SoMqWWDj8doV6fpHkPn1I3aUVylzIdC7u
	I/NCJWKvZMeOFnKQj9hnotwcuvuo2BQ3hD0D8ZZm1QW1/O2x+jmfhkwT1KqSbk+ftXewmWDDP8y
	FaKtvLNZ1ZA+zvzN3pXZgkJ+7JEqfmwGit5/8pjOtwJlmaiw98yP+JpeP44gJ/O224IwzNaABRO
	5p8Aq9Kb+z+2bL9W9FyeGFChS4nJoMsRjDv2SouK+ICpss1toIRg/2oQ00QqKK4QlyUMbMHiGYA
	GnTgzExhZNhjyzGJhu3qACho2Z3h+Yl9abJ2gPVRduktp1nS8AN9+p8EENX4nnsew+KULIpHCo1
	ddk+Ray9Vg=
X-Received: by 2002:a05:6000:4694:b0:48c:414f:cc12 with SMTP id ffacd0b85a97d-48e07f9c387mr16153415f8f.40.1792499337854;
        Tue, 20 Oct 2026 05:28:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbd33sm5588977f8f.8.2026.10.20.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:28:56 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:28:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
Message-ID: <atdee9q7DExYLGPE@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_052859_853468_66608CBD 
X-CRM114-Status: GOOD (  28.09  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-09-28 13:55:37, Zack Rusin wrote:
> Provide an escape hatch for debugging kdump failures that may involve
> pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
> invocation in crash core without consuming the once-only guard.
> 
> When enabled, the chain runs before kdump only when
> crash_kexec_post_notifiers is also enabled. Leave the late panic call
> unchanged so callbacks remain eligible if that path is reached.
> Skipping the callbacks may prevent hypervisor crash handling.
> 
> Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: optional postponement policy suggested by Guilherme.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  include/linux/panic_notifier.h                  |  1 +
>  kernel/crash_core.c                             |  3 ++-
>  kernel/panic.c                                  |  2 ++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 33cd30996e47..3d722df30838 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4904,6 +4904,20 @@ Kernel parameters
>  			This option should only be used for systems with the above
>  			constraints as it might cause the panic operation to be less reliable.
>  
> +	panic_pre_kdump_postpone=
> +			[KNL] Defer pre-kdump notifiers to the late panic path.
> +			They run before kdump only when
> +			crash_kexec_post_notifiers is also enabled. If panic
> +			reaches the late path without entering kdump, they
> +			can still run there.
> +			Intended for debugging kexec/crash-dump failures.
> +			Skipping these callbacks may prevent correct crash
> +			handling by the hypervisor.
> +			Format: <bool>
> +			Default: 0
> +			Writable at runtime via
> +			/sys/module/kernel/parameters/panic_pre_kdump_postpone.
> +
>  	panic_print=	Bitmask for printing system info when panic happens.
>  			User can chose combination of the following bits:
>  
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 3ad390764a41..655ee5c77181 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -11,5 +11,6 @@ extern struct atomic_notifier_head panic_pre_kdump_list;
>  void panic_notify_pre_kdump(char *msg);
>  
>  extern bool crash_kexec_post_notifiers;
> +extern bool panic_pre_kdump_postpone;
>  
>  #endif	/* _LINUX_PANIC_NOTIFIERS_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 5d9fe9e00f39..d6b2293dd0fe 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -140,7 +140,8 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
>  
>  			crash_setup_regs(&fixed_regs, regs);
> -			panic_notify_pre_kdump(NULL);
> +			if (!READ_ONCE(panic_pre_kdump_postpone))
> +				panic_notify_pre_kdump(NULL);

Honestly, it looks a bit confusing to me.

The name "postpone" suggests that they will be called later.
But they likely will never be called because the crash kernel
will take over the control and eventually reboot the system.
The panic() path will never run.

Also there is:

void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
{
	if (regs && kexec_should_crash(current))
		crash_kexec(regs);

where

int kexec_should_crash(struct task_struct *p)
{
	/*
	 * If crash_kexec_post_notifiers is enabled, don't run
	 * crash_kexec() here yet, which must be run after panic
	 * notifiers in panic().
	 */
	if (crash_kexec_post_notifiers)
		return 0;

So, when: "crash_kexec_post_notifiers == true" then
kexec_should_crash() returns "0" then
crash_exec() is not called. The system might still
call panic() but remember "crash_kexec_post_notifiers == true"
so the notifiers are called before __crash_kexec().
So panic_notify_pre_kdump() will still get called
before __crash_exec().

Is this intended, please?
What is use case, please?

Maybe, it would make sense to add "panic_pre_kdump_disable"
which would completely disable the notifiers when they cause
problems.

Best Regards,
Petr

