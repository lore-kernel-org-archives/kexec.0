Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DD606A321
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V1LRl6do;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMirM362
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8kgk2s1BDPoGx8z6VEMyByixhHxqx+/hqI2eAc6Pl/w=; b=V1LRl6doLG4CszI1BTgksnIMgZ
	xb6qlPQBDSIcTURiesl3qhRP+VvqW/aaY/QUG1Rx0pAs7Fkc2ODLr6BzRZyb0ewzUCo583efxJI3u
	vEB1H7vFq5+Z1fw0oFVazG/brHUEuOM3Epj9HZKasHG+zdyNhl8ARSvkYv4w8zde0qXjM0f6lzUT7
	85woc6EIeQym/sXAqkYJ9RX2qNKxUFvMvHdn5bf0K1jTCZZl+uSOpyQJQ6ZptHgnh3F+GbiWqIvep
	ZTx4fTm1CnXxrdExmYAvrp8m3AxED6o9CBWJKl1CbUk+34gwbMFeRB7u6Zh/64rKcfP+mLJW1T9lz
	+4UImUhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIOd-0000000HTK2-3Jwj;
	Mon, 09 Nov 2026 05:58:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIOc-0000000HTJt-0C4b
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:58:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B612B43C13;
	Mon,  9 Nov 2026 05:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13921F0089F;
	Mon,  9 Nov 2026 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203901;
	bh=8kgk2s1BDPoGx8z6VEMyByixhHxqx+/hqI2eAc6Pl/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMirM362rg8bEQb6ceECmalUjTHSJxZ/a9mN4yY3pWdgqvnKcYijxgacd2IvZnJ7g
	 IyhVxl6Ofp1gZgZrdg6jQtSLD7ozBvVzbZsxR/xUR3ikgWI6Oy4DmPHd097FPdMtEw
	 Jsfx2sVhmMG5F3qCygqhlS7gmGmbF4vAY5I7A5wA8sj/Dgiom3bnB30tdF2uIaVbld
	 U9owqHBpWmVeynxGauew3Vg8P6EeMBvczrM0PWOHuDu29dWnfLxksrrKNlfidpORrN
	 E09pT/a5m2/CasmRlZSM9KFlnD67hGokhS7t2kd73+yEbDTtnGhB1Vqi54oCq0iqkd
	 ajjA2iqQH1Vwg==
Message-ID: <sashiko-outbox-204467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] panic: Add a platform panic notifier list
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
In-Reply-To: <42090fa4453561ebc35f35cc563ec79933eebe75.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <42090fa4453561ebc35f35cc563ec79933eebe75.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:58:16 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Michael
 S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Jonathan
 Corbet <corbet@lwn.net>, Brennan
 Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John
 Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah
 Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian
 Forbes <ian.forbes@broadcom.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Thomas
 Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] crash: kexec_trylock() held across panic_notify_platform()
  breaks kdump
--

commit 27b42ef2d74e73a1aad7b08a71b2e46383b32891
Author: Zack Rusin <zack.rusin@broadcom.com>

panic: Add a platform panic notifier list

This commit adds a platform panic notifier list (panic_notifiers_platform_l=
ist)
that runs early in vpanic() and in __crash_kexec(), along with a kernel
parameter to disable it.

Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf8990..10b4384294c2b 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
[ ... ]
> @@ -139,6 +140,8 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
> =20
>  			crash_setup_regs(&fixed_regs, regs);
> +			/* For crash paths that bypass panic() */
> +			panic_notify_platform();
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();

[Severity: Medium]
Can calling panic_notify_platform() while kexec_trylock() is held prevent
kdump from running if a platform notifier callback panics?

panic_notify_platform() sets done =3D true before invoking the notifier
chain so that a callback that panics will not re-run the list when it
enters vpanic().  However, when __crash_kexec() is entered directly on a
crash path that bypasses panic() (such as oops_end() -> crash_kexec()),
__kexec_lock is already held:

  crash_kexec()
    __crash_kexec(regs)
      kexec_trylock()
      panic_notify_platform()
        <callback panics>
          vpanic()
            __crash_kexec(NULL)
              kexec_trylock()  <-- fails, skips kdump

Because vpanic() never returns to the outer __crash_kexec() frame,
machine_kexec() is never reached and the crash dump is lost.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D1

