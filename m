Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340A606A322
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xVWWdJP3;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fiQOzvhT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YoiKgrlu3jS2oBRKxPzmeURp2GOIi7ThEavPNJNThX0=; b=xVWWdJP33ibHf2VOhXjZNKMR6g
	j9HwWBTbGMK8DjXJVre6jP83Npu3kRzBf81BpUgAVjT+5G82+/Q1V3yIK9VlNexwTfXOdaKnrWuBk
	WRhcisGlYt34Hvgn4cnwuBzCSPHeztkuUm63HAbqs98MDp5kBx4XqRzuvYWPV2bjb7IezdxfgcNyY
	6w3Yjj24KUWFm9l8rCo6xFE4ifSMPAorojstV1ONJMwCmLEjrYV0PvdEcCYJsk2KPbWsU5ZvHz0xE
	wt8zBHPGwmFjmgT8C1G+Udy3cSJYlVTgk8ySecJ+bwKre1E5JVeEoQhDieCijUHgn4eUkN8TTMASR
	a7RklyNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8XN-00000009cuo-16Oy;
	Tue, 20 Oct 2026 12:01:49 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8XJ-00000009cuF-3laa
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 12:01:48 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso4333032a12.0
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792497704; x=1793102504; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YoiKgrlu3jS2oBRKxPzmeURp2GOIi7ThEavPNJNThX0=;
        b=fiQOzvhTmGQRzgDKQQpbqCCsr5i1U5yFj4hw1+onfWqza+VH99HjmqYhCUSWAPyOMe
         7zNJaRRmMUxWyto+GMTFBblqYoKSvwzs8HMFWj8rMXCQSApZS8jvoCY4vWxIn5DE1TGh
         zuINr69JSNWbNIq8sCszXuvoMlkaVX3GY9ra9NG/IFi9+zhhWWkFmKOPSSStGQtNCiMh
         BrPPJWxCpIRQflixFofnXb2kREGqkdQ/A1PcmINcf1pHN4wFn6cazTcCIxbgRfGSlj2O
         5OizU8k499XxevxRKBb4gwqYl1b73TzWfetz7ndQy1BLNW9UIzZmEVIZqRBplhFQYmLY
         eAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792497704; x=1793102504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoiKgrlu3jS2oBRKxPzmeURp2GOIi7ThEavPNJNThX0=;
        b=tsIvAxzE0P5H8Js5E9vfT5J5c3pAV4pcLpf2ffJTj1bbR/7G+mnaNe8EsmzjZebCcs
         BckK3Ix4Z5R4VrTTGR7fT2VNd+rhh+ESKFISZ9OaVJho4WO2fyhtJo+7kcQ0Emc8NvdU
         /6CtTnT4iiPfEgqM60/RYxtW53YxoOMUIbQEyid1MwcdoIqWHfbqyRPDgZMioNDA/IyZ
         gWG5PsegSZwDBLOYjkFBcttYeiH+kwXJ1URa2NQJbxfdwOB/dAj3vgXJcGqWjt5doEGe
         gEjMk6bg+YGEhH4qvknlag50qppbkcVdvvA+Sg94oKBAx4vv5RDjrMlFrpLLZN9RLCa/
         R8xQ==
X-Forwarded-Encrypted: i=1; AKwUvByGjVib6W4unP7uhENAMFMJHNLlwcUklTrw02beJOi0t2mk+rIwjDNZQXWehYAvKgNPGi76+g==@lists.infradead.org
X-Gm-Message-State: AFq9FYLZqH0Q/vtWGT+0bR0JIyFmyt/l13fBi+vR8aS+QLs15zrzp2w0
	w/yuAis/+9UcK+L3mBPRFtH6G2cxU5vpNArYLN20cSKiJEYT4yrgmrwR9A/InwTPnd4=
X-Gm-Gg: AYBFou1V6SoYXUe0oE5bVkMdfSTy9lmKQtdtTbfWPRpN/gPb/Gmy3KA5THAREkz50u9
	DfcY76MO4a7z3PcNZ5ghm43+PTn9lqWAXy67BuxVkIU1tx7guLCTAIl3EpD6TOSwv++PZ9kS2VZ
	coZ5olv3MM69QMv8t/QqSrgPvdOCE77oQhey5OusfDi1j5q3kMu5NctN1G+/G2Lsl3TIx75PK2K
	GnQf2R0GHznyTokEAHSbcWyEA8xH1znd+WUl0hJUL9qQigvh/rsCdhGtNQky96KKzEu8Ai/23+h
	4dyTNA58lEkLG/d0kUwZ1+L/rrTPGXdBkQ1z+iKQFbq0odu3AutPGzqDu+7vXHnA9fTy2IZH0FE
	QQn6upkumo1FPqJi6YgKKWgQZejqZ8VO1N2aTNnEWoXl+6kqvXbJGxu8BGJ9iqq8hnHvzPw8LP+
	k//ccZSiJ4I35PRD6oBQPl5fqldHM9/nhOwouijP+x1uwUyurVqryOCJ+YHUIFmh4roAPHwQPy
X-Received: by 2002:a17:907:9347:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c41a10c2ddemr789464366b.47.1792497703502;
        Tue, 20 Oct 2026 05:01:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80fc6csm5503140f8f.14.2026.10.20.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:01:42 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:01:39 +0200
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
Message-ID: <atdYIxwz8ksYNty6@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_050145_971833_7CB192B5 
X-CRM114-Status: GOOD (  32.90  )
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

On Mon 2026-10-19 19:05:21, Guilherme G. Piccoli wrote:
> On 28/09/2026 14:55, Zack Rusin wrote:
> > Selected crash callbacks should not require running every panic notifier
> > before kdump. Add a separate atomic chain with an at-most-once dispatch
> > helper, and invoke it before panic reaches the kmsg dumpers.
> > 
> > The helper permits another call from the crash path without repeating
> > callbacks or recursing into them. Document that callbacks may run in NMI
> > context, with other CPUs running and the kexec lock held.
> > 
> > Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
> > New in v2: separate pre-kdump chain, with a set-once dispatch guard.
> > 
> >  include/linux/panic_notifier.h |  3 +++
> >  kernel/panic.c                 | 26 ++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > index 41e32483d7a7..3ad390764a41 100644
> > --- a/include/linux/panic_notifier.h
> > +++ b/include/linux/panic_notifier.h
> > @@ -6,6 +6,9 @@
> >  #include <linux/types.h>
> >  
> >  extern struct atomic_notifier_head panic_notifier_list;
> > +extern struct atomic_notifier_head panic_pre_kdump_list;
> > +
> > +void panic_notify_pre_kdump(char *msg);
> >  
> >  extern bool crash_kexec_post_notifiers;
> >  
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 213725b612aa..d78e90abb192 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> >  
> >  EXPORT_SYMBOL(panic_notifier_list);
> >  
> > +struct atomic_notifier_head panic_pre_kdump_list =
> > +	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
> > +EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
> > +
> >  static void panic_print_deprecated(void)
> >  {
> >  	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> > @@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
> >  		crash_smp_send_stop();
> >  }
> >  
> > +/**
> > + * panic_notify_pre_kdump - invoke selected callbacks before kdump
> > + * @msg: Panic message, or NULL for direct crash-kexec entry
> > + *
> > + * Dispatch at most once per boot, including recursive entry. Callbacks run
> > + * with interrupts disabled, possibly in NMI context, before other CPUs have
> > + * necessarily stopped. The kexec lock may be held. They must not sleep,
> > + * allocate, wait for other CPUs, or call into kexec management operations.
> > + * The message is read-only and may only be used during the callback.
> > + */
> > +void panic_notify_pre_kdump(char *msg)
> > +{
> > +	static atomic_t started = ATOMIC_INIT(0);
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	if (!atomic_xchg(&started, 1))

It is far from clear why this is needed. It would deserve a comment in
the code and explanation in the commit message.

Well, I am not even sure whether this synchronization is enough.
If __crash_exec() and vpanic() are running in parallel on two CPUS
then one path will skip the notifiers but it will not wait until
they are finished.

But I think that the problem is the explicitly called __crash_exec()
is not synchronized against vpanic() in the first place. IMHO,
it is an existing problem which probably should get fixed.

> > +		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
> > +	local_irq_restore(flags);
> > +}
> > +
> >  /**
> >   * vpanic - halt the system
> >   * @fmt: The text string to print
> > @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
> >  
> >  	sys_info(panic_print);
> >  
> > +	panic_notify_pre_kdump(buf);
> >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> >  
> >  	/*
> 
> Hi Zack, thanks for trying to improve this conundrum called panic
> notifiers heh
> 
> I confess at first sight I got a bit confused, and only after reading
> patch 1 and 2 twice, things made sense to me: you're hooking
> __crash_kexec() directly!
> 
> So, in my head, 2 things that would make sense upfront: merge patches #1
> and #2, and comment a bit about it in the code.

+1

But honestly, the semantic and ordering of all the variables and
functions is very complicated. It is very hard to follow and
understand all the rules.

I am going to think about it. But I'll first comment the 2nd
and 3rd patch.

Best Regards,
Petr

