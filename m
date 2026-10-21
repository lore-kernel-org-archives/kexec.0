Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3B606A31F
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CPNy6d60;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YwpZYh9O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5p/5jt9iegiVPAmcf6ly8kIiH4Hbj87Lj/Peu4xLwI=; b=CPNy6d60s++iURdbjh9sHhawaU
	O8zv7xUq6WvlI+Fxa7/RQw4lUdv7Rg4hSI1yFv2Yl9uqdoVUGgnHY9+CYIPMn40tbVm1EPfctfJwP
	XSClucwupAyFMrJbcyh45d+lg6VFN9orA9FKlD6c+rCq3r7K5YB4/RDIjGsokMNRiHy3oTtoxXoUM
	dsk4H2P4YpdjxmblwOZgZbQ1x4hqFBzi4C1KM+qyFqDHBviEcoIgyfSb95YmutZ10ONGYysR94o3I
	6/jDpwqZIFDX1ZpPPD+B+DPvoXqxNg+//mMvFM90oiJpSzPZSiEeMapPw3UjbIXHBWF9PiRcBVmbO
	/o/j35ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOb8-0000000B4yU-1u0N;
	Wed, 21 Oct 2026 05:10:46 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJOb6-0000000B4y7-01GA
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 05:10:45 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so293669a91.1
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 22:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792559443; x=1793164243;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s5p/5jt9iegiVPAmcf6ly8kIiH4Hbj87Lj/Peu4xLwI=;
        b=celuqx1RXUavGmrhm/yfN4s50CLoeO80AyRVNCGAy7GzxGKr8ZPdZFjXcXmPptmYb6
         4Ar4wjVIyx8ZbLWBPQ3od40i1MawnzjJ44rwjb7jGZ8RqcwO8RA1/oabESj9v0k+L0Cy
         S7UmSRfPIJrG3DpsBY3Y+uHwiM2lxVFdTiWvhrGjV/0pl4YDRyW5zBn4JJDg+O+XWnYg
         r7Q+nlVV1XVTjDJ4dQkpQWy3z2WTnODVZSF+xB/I26VXyR2qAlHorxmGspSHy8rFbi5L
         B4VsyJlCTr5qMY/evxq5IN2QDmIL3Ps8dBRNe2smtyuZFvRWXkh/gbFmVmruW/V8ZS3B
         PtpA==
X-Forwarded-Encrypted: i=1; AKwUvBww4yXuD3m+vcDtCxGXftjQOZuoUFnYaPd94cnGBbqwjSP0mIVxlgb2B2Vp1W18Pzat+HgHdw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLp6FKsQsVxL8veRoOxDsE/otH+Cx+I5+GuWKqp+NSZ1+Re4n6p
	kM3ENqgQUyrc6DlJG+DhTtEUrNTHPn8npAn1z7oRPf8mIONUHSTg3/H/0DUJe8Tx3nfm+P1v7Cf
	C7VT62Pfwoh6A5tCeSIeb1jaUPhON+qy0lid+OTvFspxiFqb4Ck9kxW6PC/rLhRNNWaj0WpOGj6
	oYKcSwwpSpOSB7P7Ta5rg1HIrHQF8b1aZAV56bFw+D5avYHTszj6moFUFCLCjaq7WnMVnISw9hE
	aNnQi2Xruer
X-Gm-Gg: AYBFou1Why37AeJFR7UqS/tBtdy+xugWbJ25Y9107h+lRPDjBNVvitxR6OnOWyG7AKW
	OT2bAngLTmilpdlQNitCL4EOzMqv9YojcuCzlIzYSfV+1UxyvqjTTSWYEJ0YCMDl+sKo/DQ4vuX
	5cCuAeXqNi91wgU+Mi8Ur5ZKj6ojCiSfiYXDhjfebbHhP+gXlLpUXcCEPmSv2XCI7eh2KqiBXU+
	v58UY7S89hd/w1U/hj8NGs+sJw/KQuab6mPB9qFSmYwwFRQeXzwgHaHyLb+I2IPaxuMGuVNVQnd
	zQggF7QlDGlzdaAsSUAz0Rc08KhbwVhbHxnWo1tZbrqw7TpLYPiYxg+T5FMwwXoOlVHe3pS46QO
	gir/xc2s4rJLOa1tH37RmDoxHuCl/R2gZjZ/BA7a8ZdgvnIdrK6qDREGcda3khNz93MTgk63LPM
	/2l8ASoecJ306hjXBkxmX0v3XZR3RLDKR+Z74=
X-Received: by 2002:a17:90b:4483:b0:3ab:be66:ddb7 with SMTP id 98e67ed59e1d1-3ad86f7a6aamr868062a91.47.1792559442667;
        Tue, 20 Oct 2026 22:10:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad815e5f84sm1244534a91.0.2026.10.20.22.10.42
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 22:10:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3ab3ab11921so1562611fa.3
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792559440; x=1793164240; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5p/5jt9iegiVPAmcf6ly8kIiH4Hbj87Lj/Peu4xLwI=;
        b=YwpZYh9OT9tqCFqyG969+pzzWYz4mDYS0jy5VNCS7PgZxSzOhwTzfQDLgJXjGSPMLT
         77TkgMCH8xr0vwuUGwgQKCICXrFwekDJSUEq9Nncr2zHuyPBxr0c44tPX3mPjJVSvJUb
         hQ0Q7EqMcMgmouyQWhvgL3Lgqc5muRvjsdu9w=
X-Forwarded-Encrypted: i=1; AKwUvBwXlciQzdYAVi5kAf3ZSoo/mHofqBYbM2+i3jtYGUKJvj+Q8zLfafyiidYCG0QZEhpFH7JlIg==@lists.infradead.org
X-Received: by 2002:a05:651c:19a0:b0:3ab:483c:9149 with SMTP id 38308e7fff4ca-3ac4418fec5mr2462901fa.17.1792559440081;
        Tue, 20 Oct 2026 22:10:40 -0700 (PDT)
X-Received: by 2002:a05:651c:19a0:b0:3ab:483c:9149 with SMTP id
 38308e7fff4ca-3ac4418fec5mr2462651fa.17.1792559439547; Tue, 20 Oct 2026
 22:10:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1790014793.git.zack.rusin@broadcom.com> <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com> <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz> <ateYxCu63pRY9EGq@pathway.suse.cz>
 <CABQX2QOKCpoUY_ObhFif7xN7OF-NzcxEM0JABAXo9n9KaacO7A@mail.gmail.com> <atgdwrSbsZD5iWsX@fedora>
In-Reply-To: <atgdwrSbsZD5iWsX@fedora>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 21 Oct 2026 01:10:25 -0400
X-Gm-Features: AclHuK-iY28m6pjHtDyV21Psf6QklV6qAb2sMO3JuJ86CJvhZdVHzSCgHwEVQLc
Message-ID: <CABQX2QO6fwvKZwG34uOYDU_ae4M4_n2SMsYmqoLgOPnWkao02w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump callbacks
To: Baoquan He <baoquan.he@linux.dev>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b21994065e52c4ef"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_221044_108944_B8E4D56B 
X-CRM114-Status: GOOD (  59.85  )
X-Spam-Score: -2.4 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Petr Mladek <pmladek@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b21994065e52c4ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 10:04=E2=80=AFPM Baoquan He <baoquan.he@linux.dev> =
wrote:
>
> On 10/20/26 at 03:23pm, Zack Rusin wrote:
> > Hi, Petr.
> >
> > First of all I really appreciate you going over this. Thanks!
> >
> > On Tue, Oct 20, 2026 at 12:37=E2=80=AFPM Petr Mladek <pmladek@suse.com>=
 wrote:
> > > Approach B: Three lists: platform, smp_safe, and smp_unsafe()
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > It is similar to approach A. We would just add an extra:
> > >
> > >      + panic_notifiers_platform_list
> > >      + disable_panic_notifiers_platform_list
> > >
> > > This list would be used for smp-safe notifiers which are
> > > required be some platform. It would be the notifiers which
> > > are crucial. Which are currently the reason to set
> > > "_crash_kexec_post_notifiers".
> > >
> > > It might be called also when __crash_kexec() is called
> > > outside panic().
> > [...]
> > > This patchset, adding vmware_log_notifier, might implement just
> > > the panic_notifiers_platform_list. The rest might be
> > > added by another volunteer.
> > >
> > > How does this sounds, please?
> >
> > That sounds good to me. For v3 I'd do just the platform list:
> >
> > - One call in vpanic(), right after kgdb_panic() and before the first
> > __crash_kexec(), whatever crash_kexec_post_notifiers is set to. The
> > list runs before kdump and before the other CPUs are stopped.
> > - One call in __crash_kexec(), after it has taken the kexec lock,
> > found a crash image and saved the registers, for paths that enter
> > kdump without panic(), like oops_end() or Hyper-V's hv_crash_handle().
> > Once the early panic call has run the list, the guard makes this one a
> > no-op. That removes the dependence on crash_kexec_post_notifiers you
> > pointed out before.
> > - A once-only guard shared by both, so the list also runs only once
> > when a callback panics.
> > - disable_panic_notifiers_platform_list as a boot and runtime switch,
> > checked in the same helper, replacing panic_pre_kdump_postpone.
> > - Kernel-doc with your definition: smp-safe callbacks a platform
> > needs, which would otherwise be a reason to set
> > crash_kexec_post_notifiers.
> >
> > Roughly:
> >         kgdb_panic(buf);
> >
> >         panic_notify_platform();
> >
> >         if (!_crash_kexec_post_notifiers)
> >                 __crash_kexec(NULL);
> >
> > and in __crash_kexec():
> >
> >         crash_setup_regs(&fixed_regs, regs);
> >         /* Direct entry outside panic() */
> >         panic_notify_platform();
> >         crash_save_vmcoreinfo();
> >
> > I'd keep the second call in __crash_kexec() rather than crash_kexec(),
> > because afaict crash_kexec() can return without a crash image, e.g.
> > from the BPF kfunc, or from oops_end() before it panics. Calling the
> > list there would use up the guard even when no kdump follows.
> >
> > crash_kexec_post_notifiers, the existing list and the kmsg dumpers
> > stay as they are, and moving other platforms over can come later.
> >
> > The VMware log copy would be the only user, and it's still best-effort
> > diagnostics: kdump and the reboot don't depend on it. It copies the
> > log tail into an 8 KiB buffer. On panic() that happens after the panic
> > message and any local backtrace; on direct entry from an oops, after
> > the exception output. With the list enabled throughout, the copy
> > precedes the later panic notifiers, sys_info() and the all-CPU
> > backtrace step. The guest-crash report stays a late kmsg dumper that's
> > skipped while a crash kernel is loaded, because the host can power off
> > the VM inside that call.
> >
> > If that matches what you had in mind, I'll do it that way in v3.
> >
> > Guilherme, Stephen, Baoquan, does that work for you too?
>
> Hi Zack,
>
> Sorry I didn't check this series before, just trying to catch up.
>
> I like the Approach B direction: one panic_notifiers_platform_list for
> platform callbacks that must run before kdump. While I have one concern
> about the long term.
>
> Today the list has only the VMware log sender. Later, more handlers may j=
oin
> (for example pvpanic, Hyper-V, Xen, gsmi, SNP). When the list grows, some=
one
> will want to run only their handler, or to skip some handlers. The easy
> answer is "add a new list for my handler". I think this will be a problem=
 too
> in the future. Every new list adds a new global ordering rule and a new d=
isable
> switch. Petr already said we should keep the number of lists small.
>
> Currently, atomic_notifier_call_chain() runs all registered callbacks. Th=
ere
> is no per-handler enable/disable and no filter. NOTIFY_STOP_MASK can stop=
 the
> chain, but we must not use it here, because one handler could hide all th=
e
> later handlers. The list-level disable_panic_notifiers_platform_list can
> only disable the whole list.
>
> I have some rough though, just for reference:
>
> 1. Keep one panic_notifiers_platform_list.
>
> 2. Give each handler a small wrapper with a name and an enabled flag:
>
>    struct panic_pre_kdump_notifier {
>            struct notifier_block nb;
>            const char *name;
>            bool enabled;
>    };
>
> 3. In the dispatch, skip a handler when enabled is false. Print the name
>    before calling it. This also helps when a handler hangs and we want to
>    know which one it was.
>
> 4. Add a boot parameter to disable handlers by name, for example:
>
>            panic_pre_kdump.disable=3Dvmware_log,hyperv_crash
>
>    Parse it early. At panic time we only read the flag. We do not parse
>    strings in the panic path.
>
> 5. Keep the list-level disable_panic_notifiers_platform_list. It is still
>    useful to disable the whole list for debugging.
>
> 6. If the list is still too broad later, we can add a reason/class argume=
nt
>    (for example PANIC, OOPS_DIRECT). A handler can then decide if it care=
s.
>    This is better than adding a new list.

Thanks for looking at it. I agree we shouldn't add a separate list for
each handler, and named handlers with their own switch on the one list
sound like the right way to grow it.

For v3 I'd like to keep the series to the list itself. With VMware as
the only callback, the list-wide boot switch already lets us disable
platform logging. The sender also has its own sysctl,
kernel.vmware_record_panic_msg. We can add per-handler selection with
the next user, when there's an actual choice between handlers. I'm
happy to help with that when it comes up.

Two of your points do fit in v3 as documentation. I'll change the
panic_notify_platform() kernel-doc to also say that:
- callbacks must return NOTIFY_DONE, because NOTIFY_STOP would skip
the callbacks after them
- the notifier value is 0.

The VMware callback ignores that value, which leaves room to add
reason information later.

Petr, does keeping v3 to that sound right to you?

z

--000000000000b21994065e52c4ef
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMF6
cfVTMB40S5IF5f7p2IPk3k2lmtUWWZilu1cE/8IdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyMTA1MTA0MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAdUZr8MFWVR5HNKyDuendc1piBPI4f63LMaOTdo
YkFFhHduc7Dr2l9cuykqnyzZTkaLnqrnusWNrmriK1y1HlbIOVaiN1vBQi7Jj2buD2lYwU61KGZb
ts5UNjWEjXk5QoOU7Z7gnVGvd3c2yTGAORla+Z2kxEh1Mq5KzsdW6YCMX3M9KaBIGzj7Nkdk/qsH
x++Qfxq2yO1IEKVKfAqGkLVdzGLnq4qaxVWFHZmE6xIfLfl5oZWZI2C9peCazcTScJtjJAhDYSsK
AdEQdcHear7WeyQWfvc7m/Aml4kXdh/QK1oTwQMT4gvTFjCLdaE6mfofNmzeOI/gI2zm1tH6FdM=
--000000000000b21994065e52c4ef--

