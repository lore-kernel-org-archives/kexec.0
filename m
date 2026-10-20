Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7803606A32D
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fzIOoBAC;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LcCj+tfx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4p1f+D4ihXNqpiH1QSa2hiu1MulUajBwYpao7q44aQ=; b=fzIOoBACJpejm4XRUnFycbmx+g
	1Lf+Jmvd8O5cNDB1UvmvNFALeFtPpzr4UdLXW9paXGNGYJK7qkF8CHb7fMZt114yMNUozk6gwSYD3
	CUnAWN+0Eovqmnd5YuIUGF/ih4TFhi+Ef3PclraAZcjoLYv+d9lh0DvJ/m5ZMNz82WX6WtRBnxP4/
	g7UQbu2PTsuPSvOG1J1P6oBACjOUoYPmr7aWchKejVIr4BG1zDh4KT1GjeH3d/5/oMjXokb9S+oMj
	fXFEFMsHgO4rhASfcENerSpYwmkZij1aykuFaz9+/GfUj6Lc+BhqpmFsr6p8EsFIoYZYwZCdrXMGg
	HS2O5y+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9lE-00000009m9K-1st4;
	Tue, 20 Oct 2026 13:20:12 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9lC-00000009m8d-1W6T
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 13:20:11 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-48e0d885929so2489319f8f.3
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792502408; x=1793107208; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t4p1f+D4ihXNqpiH1QSa2hiu1MulUajBwYpao7q44aQ=;
        b=LcCj+tfxd4PSy2eZnmo4UfpRVbAK2JVABj2QXmqrz+SLbCpQsjIwLFMlyiom8qBnJ6
         Vs4FyUcN1Isv0YPDccQ1p5BgShhkQ9DUseX8aEs/hCqYYkce6AZoJPnsczOZLvcKW0Mz
         R697nCJGU2JUBM3UIu/r4Jk8ogzf/g7ioYVXDAoO6XgHsR+4leOgGDO/59FHb5xlBHMu
         ulElbNjqSPqY3l0zoWBwOECTnjQPcGndDugqK6GOKQpYzhTswBFu1yZ7i8mooniK1JA0
         xM7OX+m1gdU2wZCELf6eIwGQPB1niM97KcFzbJF3tULE7LIlrJzTDEAtPd8MnWKmUJRB
         OZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502408; x=1793107208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4p1f+D4ihXNqpiH1QSa2hiu1MulUajBwYpao7q44aQ=;
        b=bYTdIobi/dBODCXrx9nIwU3SFXXnjOILIhj3EdxxpJZ11zrzmZkBP81wWXngM83zd2
         +xAZBXO4MFSCYYocBEwW1pDwSrkoCwQm8KhbMMcelcQwnBoXZSAkT0TOQCv1R8Przu1t
         Y/nVoF5H2YFkjYr+KKPRM4Gte/EZR+OyaiAKday3Zm728PZBBeXPoEtno9Dr/RH3Eliu
         ps2kZUe9CWV9CE7jPR+ygas/4x3mBrq+RiMtNBzml6IgR/lNuPPCpKUEuPaDvDkzAp6h
         ykab5w4/8LeGSYy3Awk57aJLycrFZ4cho4zKlLx7NDb1QagGj/GnTaLcy0i7ViB92JH4
         hsrw==
X-Forwarded-Encrypted: i=1; AKwUvBzeOLKltJyLT8P8jJqu57O3VqXNpHjbn3Wx9G42L2C8MiATsp5WGtlmydb20fcot6pwzQtbNQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ7gjVuidz/oIy4UcT9fx+66GgbwOIjc15SaUf4IRpkuFuV/Qoy
	bJOvOaXG9OgDKssw0e05+iT0O6wNZCKo1+2AaAbHvFf3Q/YzJMWDbRhMv0+HSDcLxd0=
X-Gm-Gg: AYBFou1ztUqPq/EEKg6x1t4RLRroeMl9UOSAOGSBhR9mktJ7tXvEAJ6dZx1j0l5oXou
	QSAMHF9sTmSiZxf8nr9ZignkD2kh+rmfqi2rXpBX85HNnafcUkwwjG6IGNW/M3K56paz+aOeSmf
	ctsZMrN3qzsRG1SzFxpr1sxHq7xVSni7k/U4t1BE/xLeozUQ6kwfyLVPnfQXSKzAxeMUf1oBgrB
	rj7k5OPu4gL49TjD/4iGDOjGy5dZ3mzBSgaHFvRAUXRSaS1cHhi5rJi4P0JkthxBEC+JpJL6NJ0
	H1JmerIKay+vGdMgU2rNQbsWkLWQPXqQiYFpNGKwMA9XBS6G/RGRvxaxWwTZm1ts/4Ru18Sikrx
	PaMRHREwBDuw439fFGkjyOR+erPLIug4p4IsT1/J97SVJ/V2KJajLwMCshJ+6bJPHljlT0O8RWQ
	ytG6bMh7St4VW+HaJ0siGLzeh+k/TTuRDxa9LpuVT7Eye/vkgCcB7KwjYOQQXc5LdUwTrwno6wp
	TJSz7ZVVVJ9
X-Received: by 2002:adf:fcca:0:b0:48d:fbf4:8961 with SMTP id ffacd0b85a97d-48e07bc6c5fmr16247962f8f.23.1792502405199;
        Tue, 20 Oct 2026 06:20:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm6409645f8f.33.2026.10.20.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:20:04 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:20:01 +0200
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
Message-ID: <atdqgZQrGbp36_O_@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atdYIxwz8ksYNty6@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_062010_462903_BA1964D3 
X-CRM114-Status: GOOD (  37.47  )
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 14:01:43, Petr Mladek wrote:
> On Mon 2026-10-19 19:05:21, Guilherme G. Piccoli wrote:
> > On 28/09/2026 14:55, Zack Rusin wrote:
> > > Selected crash callbacks should not require running every panic notifier
> > > before kdump. Add a separate atomic chain with an at-most-once dispatch
> > > helper, and invoke it before panic reaches the kmsg dumpers.
> > > 
> > > The helper permits another call from the crash path without repeating
> > > callbacks or recursing into them. Document that callbacks may run in NMI
> > > context, with other CPUs running and the kexec lock held.
> > > 
> > > Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > > ---
> > > New in v2: separate pre-kdump chain, with a set-once dispatch guard.
> > > 
> > >  include/linux/panic_notifier.h |  3 +++
> > >  kernel/panic.c                 | 26 ++++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > > 
> > > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > > index 41e32483d7a7..3ad390764a41 100644
> > > --- a/include/linux/panic_notifier.h
> > > +++ b/include/linux/panic_notifier.h
> > > @@ -6,6 +6,9 @@
> > >  #include <linux/types.h>
> > >  
> > >  extern struct atomic_notifier_head panic_notifier_list;
> > > +extern struct atomic_notifier_head panic_pre_kdump_list;
> > > +
> > > +void panic_notify_pre_kdump(char *msg);
> > >  
> > >  extern bool crash_kexec_post_notifiers;
> > >  
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index 213725b612aa..d78e90abb192 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> > >  
> > >  EXPORT_SYMBOL(panic_notifier_list);
> > >  
> > > +struct atomic_notifier_head panic_pre_kdump_list =
> > > +	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
> > > +EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
> > > +
> > >  static void panic_print_deprecated(void)
> > >  {
> > >  	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> > > @@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
> > >  		crash_smp_send_stop();
> > >  }
> > >  
> > > +/**
> > > + * panic_notify_pre_kdump - invoke selected callbacks before kdump
> > > + * @msg: Panic message, or NULL for direct crash-kexec entry
> > > + *
> > > + * Dispatch at most once per boot, including recursive entry. Callbacks run
> > > + * with interrupts disabled, possibly in NMI context, before other CPUs have
> > > + * necessarily stopped. The kexec lock may be held. They must not sleep,
> > > + * allocate, wait for other CPUs, or call into kexec management operations.
> > > + * The message is read-only and may only be used during the callback.
> > > + */
> > > +void panic_notify_pre_kdump(char *msg)
> > > +{
> > > +	static atomic_t started = ATOMIC_INIT(0);
> > > +	unsigned long flags;
> > > +
> > > +	local_irq_save(flags);
> > > +	if (!atomic_xchg(&started, 1))
> 
> It is far from clear why this is needed. It would deserve a comment in
> the code and explanation in the commit message.
> 
> Well, I am not even sure whether this synchronization is enough.
> If __crash_exec() and vpanic() are running in parallel on two CPUS
> then one path will skip the notifiers but it will not wait until
> they are finished.
> 
> But I think that the problem is the explicitly called __crash_exec()
> is not synchronized against vpanic() in the first place. IMHO,
> it is an existing problem which probably should get fixed.

It seems that __crash_exec() should be called only when panic_cpu
is set. This is why crash_exec() does:

__bpf_kfunc void crash_kexec(struct pt_regs *regs)
{
	if (panic_try_start()) {
		/* This is the 1st CPU which comes here, so go ahead. */
		__crash_kexec(regs);

The only exception seems to be (found by gemini) in Hyper-V code:

static void __noreturn hv_crash_handle(void)
{
	hv_crash_restore_tss();
	hv_crash_clear_kernpt();

	/* we are now fully in devirtualized normal kernel mode */
	__crash_kexec(NULL);

	hv_panic_timeout_reboot();
}

I belive that it is a bug and it should do:

	/* Only one CPU is allowed to process with kdump and panic. */
	if (!panic_try_start())
		return;

But it is possible that it is serialized another way. Anyway, even
Hyper-V must make sure that __crash_kexec() is called only on
one CPU.

Result: We should not need any extra synchronization for
	the panic_notify_pre_kdump().

	We might just need to prevent calling them twice if we
	decide to call this function in __crash_exec() as well.
	A simple bool variable should be enough. But I am still
	not sure if it is a good design.

Continue thinking...

Best Regards,
Petr

