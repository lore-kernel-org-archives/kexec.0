Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE7606A325
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bnd8bp/v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=S8cCSxod
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vSptOXaAc4WANOLKTLPaIIgrm+JA253ibUu+7POdwvM=; b=bnd8bp/vtsM4Nlv5tQvQ2azI8w
	jKpUm/F/papdiht2z6iUSqZJOmIujJCpStofbdZqharb+Zr4napAVTa1NUPzkbguLzS9RgXOQalBT
	39jWbcVd19rHv6CN6kJ3TEL3p5/lyKHDyt5prvyKfuIS9NY6BDBzGguNrM35ckCZdHwEgeItK+CkY
	OwpMOjWmoIafORaAaYw8S2BoFi5r4XQjlq5i535EoSfNoxZe1pysU2oVq3rsK4iXhEgG1Ppj50V29
	vDHbWy3YMqtbZJ8JfF8Y/LeyPOa1+UnR2vU6Q7I0D7slyGVmOTluiKDFqglHiZAtvtaXm/6Q+2Mic
	SOjL5mGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURos-0000000FarN-3MC0;
	Fri, 20 Nov 2026 16:50:39 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURob-0000000Faoe-2fDI
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 16:50:29 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso585367a12.1
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 08:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193419; x=1795798219;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vSptOXaAc4WANOLKTLPaIIgrm+JA253ibUu+7POdwvM=;
        b=xEZ+uq+gAivbziLcU7h4ZJyoKXquNHpWDWGtXh8AWQ2UgqWouyzPJ6wauA2b0LmqeR
         dICxi9exwyl+6sqV6S3g4uvXplbUYo41tQM8/KnOZQANS/ZJiva6sTEHEHsCC8eRNLk0
         CQ+4bg56klFb+4H4iVWaGiHoqaOvnTodY0XcCTd4YfLR5kbvxEOpwyYNu/03X3d8bd09
         o+bOSxIBa27njCEa3rX0nHzYHorOhZwTnheQu42D160cUd4HDyevk3QLXn06TLTWpRVC
         A2ktsUHuCPslA7zVZj/peFXP0r/h+FiHAYmds9Y+9h+Vut2T7B3c91llPp9eo1e9Kmue
         prZQ==
X-Forwarded-Encrypted: i=1; AL+hErF8DoC4q14mao8zHbhW3eh9CFWhlHFn7Xb42Qr3jj34Q2wJBJf4crC69LN9/U0X2ubF3JAr4Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z/uMg8Jl4pE+i9Z97CsZK6W2U4dMCQkJPElrfhmrGVBxY8G/IyV
	erDTEYpXLzWm2PlD6n0EdYv3cHPpCOC5maO2c2AhV0qPt2RRkKT09f3g+OcrIWFEDLOq6pu4UH1
	uiRyJKxAm/w/KSMS6H7PyBkRmRp19QIF9SOnJQdWzo0rFH18zD9hylwi3fT1aEsQ8T3xgC14HOO
	b7yyzXXZccE69ZThqgyvMtSWAWpilHj8ljP5mb9eAwv1MmCzKCpmDE4/I0Zo5wrkQMdgZlhq+l8
	5r7F9KQ8r5o
X-Gm-Gg: AZFdTZcudXayhoZjxNgzNq+OGEN5xJ0c2xj6eveGxXY4/Q98KtURMc5E18viL2KB9SV
	oXcLPUmtxIYks8w4w+a8lqgZvp2yxnB06jkLhPXHKXgl2Sizloc3b1zeG3/snRMIg6BzLGJNc2Q
	utvJEs9LBOp9ziWDHkdMJ/1ReMZ4dehb6bRa0tWhky3mSo0mqIrdtYumTiYThKH5d/ihzBuj+ww
	SV2fTmRBaHH/PZMXUUu0VEc8kukEVA6LZIs8OJEFpB6nqPSbQHNzTFwj7cW0q9DSLV6sB8NUSJD
	aC3Ge0ywDZmmgdXRjrQ6NtgLvln+7jBOjlgUVp0zQVG0OAzPcicNVvsLc9rffLJca0WVQguJbe/
	wPI6J3KBf31AGpIC4kNyHGEBrOu2p5kis9ZsgNnS6OtWi7Pk/aKQ6wQiPjiIcvhacQgSyxW4W2D
	OIWeyfM/UGGSfvCKPTaVVn7rAsBFJhlBD4
X-Received: by 2002:a17:90b:4ec5:b0:3b3:a6b0:8991 with SMTP id 98e67ed59e1d1-3b41c96180amr3576015a91.60.1795193418627;
        Fri, 20 Nov 2026 08:50:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b4062a77f5sm3475605a91.6.2026.11.20.08.50.17
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2026 08:50:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3acd4b46482so4128741fa.2
        for <kexec@lists.infradead.org>; Fri, 20 Nov 2026 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795193416; x=1795798216; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSptOXaAc4WANOLKTLPaIIgrm+JA253ibUu+7POdwvM=;
        b=S8cCSxodq7XNWpc8kB75E/VPtP4Xy4UJZpnyFW5p3No/lu5JYkqRS7rGZeanHhoiEL
         dVAM72jUE1ko6+8pEO67S0B/YEMd02WZWTPLC7dWX4x9xraX/SyRq32HJop2jxQL18X8
         5WPDud+smG+em3y20+mXvkcEawA0QKEjWKjCE=
X-Forwarded-Encrypted: i=1; AL+hErFOjTwNRHaBy37UOWgeqYCjxW1w39l4bHGrGDgEbE291BX/B7H3V96/n8cFXCGZ9s0vjTbEUw==@lists.infradead.org
X-Received: by 2002:a05:651c:4217:b0:3ab:4412:354b with SMTP id 38308e7fff4ca-3ae7f8d487dmr10593601fa.1.1795193416258;
        Fri, 20 Nov 2026 08:50:16 -0800 (PST)
X-Received: by 2002:a05:651c:4217:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3ae7f8d487dmr10593461fa.1.1795193415716; Fri, 20 Nov 2026
 08:50:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794980455.git.zack.rusin@broadcom.com> <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
 <awAgkNoIKpFx764w@pathway>
In-Reply-To: <awAgkNoIKpFx764w@pathway>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 20 Nov 2026 11:50:02 -0500
X-Gm-Features: AclHuK9GQbfZsE-e_FygJiBCaH9fgQM-jyLJG0lFbO4vRhXl8iPcfZYOTlFChxY
Message-ID: <CABQX2QN7qbaJWzk7APtB4x82d-=Wf7=tdBQQnjBnuvjS6nBa9g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg dumpers
To: Petr Mladek <pmladek@suse.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e950670660b80919"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_085022_137342_DD092611 
X-CRM114-Status: GOOD (  61.60  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e950670660b80919
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 5:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Hi,
>
> this patch looks a bit messy, But maybe, I just do not know enough
> about VMvare.

It's my fault for not explaining it better. I'm trying to find a
balance between being overly verbose and explaining only what's
necessary for review, while omitting details irrelevant outside of
VMware, and I'm failing.

> On Wed 2026-11-18 01:01:51, Zack Rusin wrote:
> > VMware accepts a structured guest-crash event, but a host configured wi=
th
> > backdoor.coredumpOnCrash may terminate the VM before the hypercall
> > returns. Keep this event separate from the log sender, which runs
> > earlier in panic.
>
> I am a bit lost here ;-)
>
> What exactly means the "structured guest-crash event"?
> Which hypercall are we talking about?

VMWARE_CMD_REPORTGUESTCRASH, the vmware_hypercall1() in
vmware_report_guest_crash(). It takes no arguments and carries no
data. It tells the host that the guest OS has crashed. The host
records that, and vSphere can raise a "Guest OS crashed" event for the
VM that management tools and alarms act on.

"Structured" was a poor way of saying "a crash state the host
understands". Patch 2, by contrast, only copies log text into the VM's
log file on the host. I can drop the word "structured".

> Is this primary about synchronization of vmware_panic_log_notify()
> against termination of the crashing guest by the host?
> Or is this about something else?

It's about ordering rather than synchronization. Patch 2 sends the log
from the platform list, before kdump, so it is done before the report
can happen. Patch 4 is about the other side: it skips the report when
a crash kernel is loaded, and otherwise tries to give the guest's own
log dumpers (pstore etc.) a chance to finish first.

> What exactly does vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)?
> Does it _block_ or _trigger_ backdoor.coredumpOnCrash?

It triggers it. Normally the call records the guest OS crash and
returns, and Linux continues its panic path. backdoor.coredumpOnCrash
is a debugging option in the VM's configuration, off by default. With
it enabled, the host attempts a dump of the guest and stops the VM
during the call, so the hypercall never returns.

So with that option set, anything panic() still has to do after the
report never happens. That always includes the kmsg dumpers that come
after the report, and, without the crash-kernel check, kdump too when
crash_kexec_post_notifiers is set. That is also why the report can't
share the platform list with the log sender.

> > Register a panic-only kmsg dumper with late_initcall_sync(), after buil=
t-in
> > dumpers registered by then.
>
> Is this ordering important?

Yes. kmsg_dump_desc() calls the dumpers in registration order, since
kmsg_dump_register() appends with list_add_tail_rcu(). Registering
from late_initcall_sync() puts the report after the panic dumpers that
are already registered at that point, giving them a chance to save
their records before a coredumpOnCrash host stops the VM. Dumpers
registered later, by modules or late-probing drivers, end up behind
it. It only makes a difference with that option set.

> > Skip the event while a crash kernel is loaded
> > so the host cannot terminate the guest before kdump saves its vmcore.
>
> This suggests that vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)
> actually triggers the external crash dump procedure made by the host.

Yes, when the option is set. With crash_kexec_post_notifiers, kdump
runs after kmsg_dump_desc(), so the report would stop the VM before
the capture kernel started. A guest with a crash kernel loaded
therefore leaves the crash to kdump and does not report it.

> > Issue the event at most once. With CONFIG_PRINTK=3Dn, use a late INT_MI=
N
> > panic notifier. An unexpected dumper registration failure with printk
> > enabled leaves reporting disabled rather than overtaking working dumper=
s.
>
> This is another mystery. What do you want to achieve when
> CONFIG_PRINTK is not defined, please?
>
> Note that printk() is a NOP when CONFIG_PRINTK is not defined.
> There is nothing to dump in this case.
>
> Honestly, I would not complicate the code by this.
> I doubt that anyone is using kernel without CONFIG_PRINTK.
>
> > --- a/arch/x86/kernel/cpu/vmware.c
> > +++ b/arch/x86/kernel/cpu/vmware.c
> > +static int __init vmware_crash_report_init(void)
> > +{
> > +     int ret;
> > +
> > +     if (!hypervisor_is_type(X86_HYPER_VMWARE))
> > +             return 0;
> > +
> > +     ret =3D kmsg_dump_register(&vmware_crash_report_dumper);
> > +     if (!ret)
> > +             return 0;
> > +     if (IS_ENABLED(CONFIG_PRINTK)) {
> > +             pr_err("failed to register crash report dumper: %d\n", re=
t);
> > +             return 0;
>
> This is weird. As I said, printk() is a NOP when CONFIG_PRINTK
> is not defined. So, you would achieve the same with:
>
>         ret =3D kmsg_dump_register(&vmware_crash_report_dumper);
>         if (ret)
>                 pr_err("failed to register crash report dumper: %d\n", re=
t);
>         return 0;
>
> But wait, this means that the code below is never reached.
>
> Ah, I see, you wanted to run the code below when CONFIG_PRINTK
> was disabled. It was far from obvious. And I do not understand
> the motivation much.
>
> Anyway, it won't work because kmsg_dump_register() returns -EINVAL
> when CONFIG_PRINTK is not defined. err !=3D 0 ...

That -EINVAL is what the fallback relies on. With CONFIG_PRINTK=3Dn the
stub returns -EINVAL and IS_ENABLED(CONFIG_PRINTK) is false, so init
falls through and registers the INT_MIN panic notifier instead. The
pr_err() branch is only for a real registration failure with printk
enabled.

The motivation was that the report doesn't need the log, so a kernel
without printk could still report its crash. Now having said that, is
CONFIG_PRINTK=3Dn actively used inside vmware? Not to my knowledge, I
did it for completness more than a very specific need so if you really
don't want it in, I can remove all the CONFIG_PRINTK=3Dn handling, at
least until I have a specific need for it.

> Let's take a step back.
>
> Why do you want to use kmsg_dump infrastructure for notifying
> host about the crash, please?
>
> The kmsg_dump API should be used to dump the printk messages.
> But this just notifies the host about the crash. It looks like
> an API misuse.

The only reason is ordering. In vpanic() the platform list runs before
kdump, and panic_notifier_list, even at INT_MIN, runs before
kmsg_dump_desc(). Registering a late dumper is the only way to run
after the dumpers registered before it. I agree that a dumper which
never reads the log is a bit hacky :)

> > +     }
> > +
> > +     ret =3D atomic_notifier_chain_register(&panic_notifier_list,
> > +                                          &vmware_crash_report_nb);
> > +     if (ret)
> > +             pr_err("failed to register crash report notifier: %d\n", =
ret);
> > +
> > +     return 0;
>
> IMHO, you either want to use the panic_notifier list.
>
> Or you might even use the new panic_notifiers_platform_list
> if you make sure that this is called as the last event
> and you really want to stop the guest at this point.

I don't think that the platform can be last: by design it runs before
kdump, and it already holds the log sender from patch 2.

panic_notifier_list at INT_MIN would work, and it would cover
CONFIG_PRINTK=3Dn without a special case. The cost applies only when
coredumpOnCrash is set and no crash kernel is loaded: the VM would
stop before panic_print's sys_info() output and before all of the kmsg
dumpers, pstore included. The host's dump would win over pstore. On a
default host the dumpers still run; the host just hears about the
crash a little earlier.

I'm fine with either. If you don't like this approach for v5 I can
switch to a panic_notifier_list entry at INT_MIN (still skipped while
a crash kernel is loaded), or keep the dumper and add a comment
explaining why it ignores the log. Which would you prefer?

> My assumption is that the "host" will stop the "crashing guest"
> when it gets notified about the crash.

Not by default. Normally the host records the crash and the call
returns, so the guest continues its panic path. It's stopped during
the call only when backdoor.coredumpOnCrash is enabled.

> PS: It looks to me like Sashiko AI completely failed here. It did not
>     mind if the commit message made sense. It did not see the big
>     picture. And it even missed that the code did not work with
>     CONFIG_PRINTK undefined.

I don't know if sashiko reads commit messages, that one is on me. I'm
trying to get better at finding the right balance between oversharing
and not sharing enough and it's not easy.

The CONFIG_PRINTK=3Dn case isn't a miss, though. As above, init falls
back to the panic notifier when kmsg_dump_register() returns -EINVAL,
so that path works. It's just a question of whether it's worth having:
for me it was easy enough to handle it but I wouldn't object to
dropping it if you find it too complex.

Thanks for the careful review!

z

--000000000000e950670660b80919
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPMn
W0OwsrA3c+frpPAomFNZcG/4YYQqEFPwLBcgnXiLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEyMDE2NTAxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHKuLdBaXx5PB9XwgCLoDJszdJwf7DHjnmwxyqOp
wwnEMoZz8EXw9PKxN8ZqIlhTWTW3G/NB60LEiIbEoXRib+r7cqLYe7N6KexHrN/csL8y4GZzG37S
aM9mcNba2FeRRIBXDgFoC38wwb/7zwAZ3yOQyVjlfczmXy9rUQgM1vXs6pazNpM82iCTvs3zWGnm
heQONHr6gkUuJ0EtbX85cZu7UTXWpPdUQPORWhzTeXUlWNW82P155dXkjYmi8ryKxLxIjGtz2bXW
rdUbzp9NOkFegGO3FWdzP4XTvV8PWfxN4mCb+evoTSMzVG6be/tETZN0u3kOmC7r3MEmhg1nMBc=
--000000000000e950670660b80919--

