Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EC60A6F71
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v79h3RbJ;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BmDadvJ5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3huXbL6tfvWL0Pcc+xlEk6CMxUZ1VDARolPUJTgc12w=; b=v79h3RbJYZ3bHnLkHVfBO+qZi3
	6MWOqxpVpYEjEIzU/DJ/zjKTD0sXxHUcEGbljr8D9Ly/ES9gdMm8kxRHb8CRw1BAIf49mhC0UCqLw
	BRfQ2vQ0aco0iF/+KBBpoYL64nuc7W6bGIxOW/3qr0Lkw7S0+p6dnnDBuKRxRVLXXOUkZhc79uRIR
	zagpZww30/w5+85v+q1F4aXNoFKiOOcpJNuk8gPhGB9U5sFX2ihv6bT4Yps7r8pCPs6ULj2eT3ac9
	UuiuZPjFhigMjxOYFEn/R1gfTUnktw1KkofmmLzZ1leZhd+IiJ+CIVXh2URz/uBByqlXISy5IVhgb
	zlBcPXJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJCqF-0000000ACVY-1j14;
	Tue, 20 Oct 2026 16:37:35 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJCqB-0000000ACUi-2yqb
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 16:37:33 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so26775775e9.0
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792514250; x=1793119050; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3huXbL6tfvWL0Pcc+xlEk6CMxUZ1VDARolPUJTgc12w=;
        b=BmDadvJ5bj+fmlmTBS1Ao1yYgV6CvpwX4dEkx44bjWFFvxBjzZ9wAWx96b+GrVdpmN
         E6Hw7673p7/CxqZvSfXllcHdBOCIbbQTMzPZr1vUQpp23JpgML2vhBpa+VcrIkDy0PTl
         wqRS8eIZKEvk1xFmC9WlFCbW4ukZ2YgFB+AZCAKb76lQSsD51M3PLp/IHoEnRHcIx9K1
         pY979Kg9KVYozCBO4MKQc9pvRfH26umwmt2ypK4vD16IahrF1x7eoKm39q5M7VGAD1Jw
         sd+jCDX+oTScAKMLVLPIOvFuZiyYzjJkY3Fl0Xopuxyz7fD7N5FZzU+wFI5sFE1Ig0Q0
         4gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514250; x=1793119050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3huXbL6tfvWL0Pcc+xlEk6CMxUZ1VDARolPUJTgc12w=;
        b=sDCeTaKYpVIH9jApaN4ZnNXVWTk9QqmCGJk7iv8gljYdOm1F0ZQp9I3I5ZqtLBvzMg
         nAlnODbpu4XvexvkBxWXkAOvxFnuah75tfLRTb+Iwniq4DmrTBIcHMbO0h5jmJOjKwe/
         2EdoHz4xe/gSvpFoUXdO7kUkArWKCqFjsBy3adQT1tyGMyyz2QX5BUXOzWfi/XsZL7nE
         gmXC9Fhu6Xivq+GWdKfAT/T+Y6xDTY0xSR7BkRvXqbsIeudjVxZToMPHqn53OSDLUv8w
         iYo1TOMr+MsV0oHAywCz+k/eI2gVF54ufQU5o3PU8UCCIYNiqVBs4TUvfbzqw2RCitzT
         DEhA==
X-Forwarded-Encrypted: i=1; AKwUvBy/2KuxYG4SD5+ZLl6TxBOkPSnMIpIdMDzJV6jOxC6Hed0u6V/GPWxpbVvSXFdAN93j/WGgNQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYK6n79OirANb6KqW7v6AGp5U14UPR2JXBLmHSnwhUUYMq5/+pDy
	i3x3w5ekAdYTFJMJOnGPHk1pXqbolPvORljEpZxSVus569r2BoLstlrFk/jz5q9QoTw=
X-Gm-Gg: AYBFou1Rj8VLi5D6kS43uIM9ofgnjhlTzFaXRog5gHFUY96eR1WLbeMay9c1ld+aeIu
	pKOfNeINTtXeoTQmAB+6c/R1tBJ6MJZh0VV84yWFl4Zx+pOjAtMf3+rofIS21W1l1ftP+0rHClA
	bYfI6mSgtyzX7t55z1jhqOMgLxNdm9+C7v071VArHpS4K+AQuN6PBFYYduA0MNQMxs34N/JgyPc
	vmwGZgpQrjdiZPjaPSJUam5tRiJ7UB3wI5fGzqnqf1eIUd2nZLX2A+JWBXc0/Bi7sHrxNxjPuh/
	kGLgjU+JFIwoIgyyUG3Id5NYkpWT0ydd5YHnCBxNfbxwHyHQ1Wa0FYVSyesiDJZXMQ687Kr9/qe
	fPmpsgVzup8BzEpgZLVuc4eMhBz2X4fUu1mxZjjJDHoDX1zgSlq5E6WtynLBBuDsRF6rOGvAl9U
	yJoTmbPz3o+QC5mCkYpaVPjk6zmbQaSfdxfF7oK+KsrkVPFITU/Ru4kJY2H+6aEsDIBO9ewpo0
X-Received: by 2002:a05:600c:8709:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a1d75f8f28mr236777835e9.18.1792514249669;
        Tue, 20 Oct 2026 09:37:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d41c8asm84327885e9.8.2026.10.20.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:37:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:37:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	Dave Young <ruirui.yang@linux.dev>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Pratyush Yadav <pratyush@kernel.org>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Message-ID: <ateYxCu63pRY9EGq@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atd7GInNurGWLUha@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_093731_801921_D00E7670 
X-CRM114-Status: GOOD (  52.58  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 16:30:53, Petr Mladek wrote:
> On Tue 2026-10-20 14:01:43, Petr Mladek wrote:
> > On Mon 2026-10-19 19:05:21, Guilherme G. Piccoli wrote:
> > > On 28/09/2026 14:55, Zack Rusin wrote:
> > > > Selected crash callbacks should not require running every panic notifier
> > > > before kdump. Add a separate atomic chain with an at-most-once dispatch
> > > > helper, and invoke it before panic reaches the kmsg dumpers.
> > > > 
> > > > The helper permits another call from the crash path without repeating
> > > > callbacks or recursing into them. Document that callbacks may run in NMI
> > > > context, with other CPUs running and the kexec lock held.
> > > > 
> > > > --- a/kernel/panic.c
> > > > +++ b/kernel/panic.c
> > > > @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
> > > >  
> > > >  	sys_info(panic_print);
> > > >  
> > > > +	panic_notify_pre_kdump(buf);
> > > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> > > >  
> > > >  	/*
> > > 
> > > Hi Zack, thanks for trying to improve this conundrum called panic
> > > notifiers heh
> > > 
> > > I confess at first sight I got a bit confused, and only after reading
> > > patch 1 and 2 twice, things made sense to me: you're hooking
> > > __crash_kexec() directly!
> > > 
> > > So, in my head, 2 things that would make sense upfront: merge patches #1
> > > and #2, and comment a bit about it in the code.
> > 
> > +1
> > 
> > But honestly, the semantic and ordering of all the variables and
> > functions is very complicated. It is very hard to follow and
> > understand all the rules.
> 
> I trying to understans why I am confused by the panic notifiers code.
> There are several aspects:
> 
> 1. I was involved in many mail threads where we discussed calling:
> 
> 	notifiers  before/after  kdump
> 
>    but the variable "crash_kexec_post_notifiers" defines calling:
> 
> 	kdump   before/after  notifiers
> 
>    It actually matches the code because __crash_kexec() is called
>    twice in vpanic() before and after the notifiers.
> 
>    Sigh, it looks like a trivial mental switch. But it is not
>    that trivial when we though about splitting the notifiers
>    into more lists and discussed where to call them.
> 
>    The discussion always was where to call notifiers and not where to
>    call kdump.
> 
>    And we are also discussing about disabling notifiers. Not about
>    disabling kdump.
> 
> 
> 2. We call the new list "panic_pre_kdump" and this patchset calls
>    it in both vpanic() and __crash_kexec() code paths.
> 
>    The name "pre_kdump" suggests that it is needed only when kdump
>    is called. But we want to call it in panic() even when
>    kdump is not called.
> 
> 
> 3. The new "pre_kdump" notifiers are called before stopping CPUs.
>    While the rest is called in the more safe environment
>    with stopped CPUs.
> 
> 
> 4. I am a bit confused by this patch set because it allows
>    dumping printk log before kdump. It does not fit with
>    my understanding of having "pre_kdump" list only for
>    the strictly needed operations.
> 
> 
> 5. There is the idea of splitting the remainig notifiers into
>    _safe and _unsafe lists, see
>    https://lore.kernel.org/r/atcjhe4329sYHWvZ@pathway.suse.cz
> 
>    It would complicate the design even more. But it might help
>    with the endless war whether "crash_kexec_post_notifiers"
>    should be "true" or "false" by a platform-specific default.
> 
>    I wonder how all this fits together.
> 
> 
> Top-level look:
> ===============
> 
> Sigh, one problem is that the notifiers have different purpose:
> 
>    1. Notify hypervisor (platform). This looks like a must-to-have.
> 
>    2. Platform specific dump of printk messages. This is
>       nice-to-have. But note that we also have kmsg_dump API
>       for this, see kmsg_dump_desc().
> 
>    3. Print extra info. Also this is nice-to-have.
> 
>       Some is optional when kdump is created because it might be
>       read from there. Some can't be found in crash dump, e.g.
>       dumping lowlevel HW state.
> 
>       In addition, there is sys_info() info API which allows to
>       dump state of various subsystems.
> 
>    4. Some notifiers are smp-safe and some just a best effort
>       and more safe after disabling other CPUs.
> 
>       In addition, I guess that it is better to call crash_kexec()
>       without stopping other CPUs because stopping is not reliable
>       without NMI. And it would create extra noise in the backtrace.
>       And ???
> 
> 
> Now, different people have different preferences but mainly:
> 
>    + the more safe kdump the better
>    + the more safe reboot the better
>    + the more info the better
> 
> 
> Now, the question is how to satisfy the various requirements
> and keep the design sane. We need a compromise but where.

With the above in mind, I think about two approaches. I have the
following constrains in mind:

   + keep it simple (2-3 lists max)

   + If people configure kdump then they want to use it.
     Post crash_kexec() paths are just a fallback.

   + If people configure panic_sys_info + crash dump then they
     want it even in crash dump.

   + If people configure any kmsg dump and configure kdump
     then they want it before crash_kexec().

   + If a platform wants to do something then it wants to do
     it before __crash_kexec().

   + If something cause problems then fix it. But allow to disable
     it for debugging purposes.

One very important aspect is when other cpus should get disabled.
I guess that most people would want to call __crash_kexec() before
disabling other CPU. Even though, I am not completely sure why.
But some notifiers might be hard to do smp_safe.

The disabling of other CPUs seems to be the most critical operation
which would split notifiers into two groups.

Approach A: Two list: smp_safe vs. smp_unsafe
=============================================

We could create two list:

   + panic_notifiers_smp_safe_list
   + panic_notifiers_smp_unsafe_list

Where the safe list would be called before __crash_kexec().
And the other after CPUs get disabled.

In the long term, I would get rid of the controversial
"crash_kexec_post_notifiers" options. Instead, I would add:

    + disable_panic_notifiers_smp_safe
    + disable_panic_notifiers_smp_unsafe
    + disable_cpus_before_kdump

Then we might call:

	panic_notify_smp_safe();

	if (disable_cpus_before_kdump) {
		crash_smp_send_stop();
		panic_notify_smp_unsafe();
	}

	__crash_kexec();

	if (!disable_cpus_before_kdump) {
		crash_smp_send_stop();
		panic_notify_smp_unsafe();
	}

Where the panic_notify* functions would get implemented as:

	void panic_notify_smp_safe(void)
	{
		if (disable_panic_notifiers_smp_safe)
			return;

		...
	}


Approach B: Three lists: platform, smp_safe, and smp_unsafe()
=============================================================

It is similar to approach A. We would just add an extra:

     + panic_notifiers_platform_list
     + disable_panic_notifiers_platform_list

This list would be used for smp-safe notifiers which are
required be some platform. It would be the notifiers which
are crucial. Which are currently the reason to set
"_crash_kexec_post_notifiers".

It might be called also when __crash_kexec() is called
outside panic().

It would allow to separate the most crucial stuff from
the rest. It might help when it might be enough to
disable the less crucial stuff for debugging kdump
issues.


Conclusion:
===========

Of course, there are many details which might need to be sorted,
for example:

  + how to put this together with the existing list
    until all notifiers are migrated.

  + which list should be called when (__)crash_kexec() is
    called explicitly outside vpanic().

This patchset, adding vmware_log_notifier, might implement just
the panic_notifiers_platform_list. The rest might be
added by another volunteer.

How does this sounds, please?

Best Regards,
Petr

