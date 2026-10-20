Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14208606A31C
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LK8GrFYt;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZEd6uQeb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CniGtgnti6KdC6pQIvauHlETM08FpIVgz45KXnuEH4=; b=LK8GrFYtr/1UEtn/EYHqUz20++
	UIll85fE19ISOYbIqPQg2aJT5zfmmYSJSmYKtOKDTeMslgh+uqtMUYB3GHd73NwRueL59Qms39GXG
	fwVENWO8AAxnUxtgRBb3O4LpqUvooruD0FaAhhLkocl4PJfaKyoqfniKHq7QAfFob/EBBUkFU6+P7
	QtoMfQ4n6NARJLq6i7kr/KG56Lbsk4SHZErFdxtcxsdvEtU1jXwsOc11QO82YUbUDN3h5Ri8ROX26
	eGXjTHfBtISClSUcoJa7FnnlJ8lU1aMr57M8bPX+gGpizGlOd49oJIjnbUYVsHByRefrNVm+khj3n
	wET6NtCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJAri-00000009wtW-0Rti;
	Tue, 20 Oct 2026 14:30:58 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJArf-00000009wsU-1ZAZ
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 14:30:56 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2576724f8f.2
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792506653; x=1793111453; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CniGtgnti6KdC6pQIvauHlETM08FpIVgz45KXnuEH4=;
        b=ZEd6uQebxBPtV4Ecx4Y0zQUGzmwBhnkVlDxKtnndaFmvGX7VofMJ559thjn3Wfksqi
         KWARGsbfzlWogh9ieDZ0jKUwt64kFTLaSV8ncoxIaBY6ns3amCWgBsX7nFOcDQFnGHz1
         ZHn2pF/E8KujtfKnewP89ADtsblBvaF4ezq0zihYlSjQ6bFgKs6nmuKM3eOb1SwPieAL
         xuu+oeEPi0HRxYACiUAsA7X1Jd6Olh62sohscagEXtB9B6Gqdgtk7Mo5h1eAYJzT2Gtm
         +8RwIb9xkdIO1D2KQK28MGIASGZFCmBWkuucIsX/GGHDTDgyVrslIJcL65fUNBfWZLa2
         aZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506653; x=1793111453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CniGtgnti6KdC6pQIvauHlETM08FpIVgz45KXnuEH4=;
        b=YHpXQcuybV6XnwWeQWXJQv7mj21foPxKKFODbKa2/OiRcbjNOIC/RS2AdbdTNJIZkh
         JAWpKa1+r93jW/kwQibpXnI+uCs6V4fmsyidXH7oAfF6sHFWz75FbkaTT3U6aK3tYM1P
         medWqzBcsg/lqDZ1dWP+MPWGg8o8bBKpCxc5BUEh4cUS2zUBOj9+s3iJx5NS0xDFvxYf
         ahxhjK3qhYl/IDMfliCuVTPnvnbWV5/6JP04Vl20zK6Z8kbGIOiucc9QcSy/N3hHTshA
         x2cV07VtlR0P+IG5QJoW23Pmc31/w/rWS/hXe5FR2Tfoed+IZBpMjF/PCrmCIb2ZZnsT
         Wrew==
X-Forwarded-Encrypted: i=1; AKwUvByVIbBRX8FAoY93ulrJ6t54/1AmNNVcL3DvYpSyvBBblCxF2lRtzxXDa4CLYJtr9BojHdl9bg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLUYjRrOoWRoaWP30Ko1mpkdq/KIKbL3Qa9KCu3fcpg4Ku7VpqL
	nGvqPmeV5ZDlGlzDSwemXhO9tqUiarYtxpNd4+7zkSQr7bsdkmdF9cYhDKXOE8BZsSs=
X-Gm-Gg: AYBFou0M9mpc03aYR9W41NA8p7TaFqGgPlu3ahG1+RTj5AvLsna2OrVANPvSQwe11tI
	yl102z5Z83D/EEECq5wiPOPUQG6ziBHYFTgKPx32pordykMSjyqPrAJY2Kvx0STNNYlHATSFSSK
	f+zNBJe/+EEnYmEoVqfktZW9/ckokmrgQ75fnJJE6MnXKEUiSNYw3eBOMamjCPqCFxLnJdfx2ob
	I4ZDQmRg+jnfk2dbMjLTsC5OudebngWRRhWgOfIArxZiUGk7GkN3ZxhbyzmOKUzElYSHzg82jVa
	ra5dV6jtcGL4OMH5/gj8BfyKJWXn6isf6xUCr1aI5XHhBXF0K2tTGFrikoSthsLoCFhAjNj1pB7
	inTMOLkFJ+lQzqLLe+VTnqHXn1smXpZvxSOCLVBR4lzcuADSZrtYQwBuNo7xUXGGzJtJz95O9IN
	no0Eh2Qyj+RL30vSvYnIH3tYu+dFs2Rswyp/5ZOUPZBNxrsDizmbv/ARzhSv6xhoHe5GeBwbQo
X-Received: by 2002:a05:6000:2887:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e07bbc6e6mr23535312f8f.19.1792506653058;
        Tue, 20 Oct 2026 07:30:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214e1sm6395924f8f.37.2026.10.20.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:30:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:30:48 +0200
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
Message-ID: <atd7GInNurGWLUha@pathway.suse.cz>
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
X-CRM114-CacheID: sfid-20261020_073055_495721_ADCCB4BA 
X-CRM114-Status: GOOD (  50.64  )
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
> 
> > > +		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
> > > +	local_irq_restore(flags);
> > > +}
> > > +
> > >  /**
> > >   * vpanic - halt the system
> > >   * @fmt: The text string to print
> > > @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
> > >  
> > >  	sys_info(panic_print);
> > >  
> > > +	panic_notify_pre_kdump(buf);
> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> > >  
> > >  	/*
> > 
> > Hi Zack, thanks for trying to improve this conundrum called panic
> > notifiers heh
> > 
> > I confess at first sight I got a bit confused, and only after reading
> > patch 1 and 2 twice, things made sense to me: you're hooking
> > __crash_kexec() directly!
> > 
> > So, in my head, 2 things that would make sense upfront: merge patches #1
> > and #2, and comment a bit about it in the code.
> 
> +1
> 
> But honestly, the semantic and ordering of all the variables and
> functions is very complicated. It is very hard to follow and
> understand all the rules.

Warning: You might skip the first part about my confusion.
	Maybe, I am the only one who is a bit lost this way.

	My motivation is to do not repeat the mess which I saw in
	the printk registration code. People added many features
	there for over two decades. Each change made sense on its own.
	But, for me, it was really hard to understand and distinguish
	what were the wanted and unwanted effects.


I trying to understans why I am confused by the panic notifiers code.
There are several aspects:

1. I was involved in many mail threads where we discussed calling:

	notifiers  before/after  kdump

   but the variable "crash_kexec_post_notifiers" defines calling:

	kdump   before/after  notifiers

   It actually matches the code because __crash_kexec() is called
   twice in vpanic() before and after the notifiers.

   Sigh, it looks like a trivial mental switch. But it is not
   that trivial when we though about splitting the notifiers
   into more lists and discussed where to call them.

   The discussion always was where to call notifiers and not where to
   call kdump.

   And we are also discussing about disabling notifiers. Not about
   disabling kdump.


2. We call the new list "panic_pre_kdump" and this patchset calls
   it in both vpanic() and __crash_kexec() code paths.

   The name "pre_kdump" suggests that it is needed only when kdump
   is called. But we want to call it in panic() even when
   kdump is not called.


3. The new "pre_kdump" notifiers are called before stopping CPUs.
   While the rest is called in the more safe environment
   with stopped CPUs.


4. I am a bit confused by this patch set because it allows
   dumping printk log before kdump. It does not fit with
   my understanding of having "pre_kdump" list only for
   the strictly needed operations.


5. There is the idea of splitting the remainig notifiers into
   _safe and _unsafe lists, see
   https://lore.kernel.org/r/atcjhe4329sYHWvZ@pathway.suse.cz

   It would complicate the design even more. But it might help
   with the endless war whether "crash_kexec_post_notifiers"
   should be "true" or "false" by a platform-specific default.

   I wonder how all this fits together.


Top-level look:
===============

Sigh, one problem is that the notifiers have different purpose:

   1. Notify hypervisor (platform). This looks like a must-to-have.

   2. Platform specific dump of printk messages. This is
      nice-to-have. But note that we also have kmsg_dump API
      for this, see kmsg_dump_desc().

   3. Print extra info. Also this is nice-to-have.

      Some is optional when kdump is created because it might be
      read from there. Some can't be found in crash dump, e.g.
      dumping lowlevel HW state.

      In addition, there is sys_info() info API which allows to
      dump state of various subsystems.

   4. Some notifiers are smp-safe and some just a best effort
      and more safe after disabling other CPUs.

      In addition, I guess that it is better to call crash_kexec()
      without stopping other CPUs because stopping is not reliable
      without NMI. And it would create extra noise in the backtrace.
      And ???


Now, different people have different preferences but mainly:

   + the more safe kdump the better
   + the more safe reboot the better
   + the more info the better


Now, the question is how to satisfy the various requirements
and keep the design sane. We need a compromise but where.

Continue thinking...

Best Regards,
Petr

