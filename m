Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753A606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gxfqnh3L;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUDNKUgw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3is0CbO3NwPfqFRdxfgxQl4YKoG86sWiuHQ8/kCrTX8=; b=gxfqnh3L/vLx4/omXSrWDkWGsk
	wZ3BBnQ4hri28qtHH3Dp9z9+KBjIrvXAQmpr9tD2YvEQLFUnLaJ2IhJUFfB8ioPmeDa0TP58dd3xP
	ElV1RZQLD6AgakdlJIhK1ew5W/z9VueecgaQZqpo6l7P42Kutqbn15B/Ht+XvYs+BwJ8du1JoMmvu
	i4gD27YbIScJZ0Cgtjm635YK8uqcwnAE5HyVXbyj7ewETGvEdeOVHWRFMej1IvH3Yqidzz1QtOdrJ
	UauL9UGRIUKmxkk5tTHmTRW7XcYj1zvUItBJiNzrxPV55GPRlAHHP5dUaOeIISeQnwF+2GTv15FUK
	NAtRdCVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYyL-00000007qjm-2u75;
	Wed, 18 Nov 2026 06:16:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYyK-00000007qjM-2izX
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:16:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 124CD60FA1;
	Wed, 18 Nov 2026 06:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEFD1F000C4;
	Wed, 18 Nov 2026 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982603;
	bh=3is0CbO3NwPfqFRdxfgxQl4YKoG86sWiuHQ8/kCrTX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUDNKUgwrZYHgJ2NQaoyAykoNg886dfxI8lHNyZHmQFprW4B3y7viXG7MyATTIyxJ
	 OSw4NLBFUeafPgHajFN5wS1i1hhYGW1vsvx/6NfvP2Nk5i8g2xcT8jUWALGYoSqtjn
	 yV3N7eD1g48E2SgMunIHYqsBrik54MwCcHGCtMbTt3bolvHkxaN693/l81Lbbw7K27
	 aw9kd66Og2drO+1pOr78tw8IQt8FUxJ7U/UWaVWbQaGmLQ8wJueb5IPZM9LiS48B2o
	 492p9fGNddfkRXbpEPDHAf6HKZiu3zBn/hITEddQ1/M661PtJ2nvllBsO+LFdPuqxX
	 1X7fDtxrFxVWA==
Message-ID: <sashiko-outbox-220232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] panic: Add a platform panic notifier list
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
Cc: "Kees Cook" <kees@kernel.org>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Bo Gan" <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Jonathan Corbet" <corbet@lwn.net>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, x86@kernel.org, "Joel Granados" <joel.granados@kernel.org>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, "Ingo Molnar" <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, "Ajay
 Kaher" <ajay.kaher@broadcom.com>, "Bradley Morgan" <brads@mainlining.org>, "John
 Ogness" <john.ogness@linutronix.de>, virtualization@lists.linux.dev, "Steven
 Rostedt" <rostedt@goodmis.org>, "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>, "Borislav
 Petkov" <bp@alien8.de>, "Shuah Khan" <skhan@linuxfoundation.org>, "Michael
 Kelley" <mhklinux@outlook.com>, "Randy Dunlap" <rdunlap@infradead.org>, kexec@lists.infradead.org, "Ian
 Forbes" <ian.forbes@broadcom.com>, "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:16:41 +0000
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Some platforms set crash_kexec_post_notifiers so their crash handlers
> run before kdump. That also runs every other panic notifier and kmsg
> dumper before the crash kernel.
>=20
> Add panic_notifiers_platform_list for platform callbacks that need to
> run early and are safe while other CPUs are still running. Call it
> from vpanic() before kdump and before stopping the other CPUs,
> independently of crash_kexec_post_notifiers.
>=20
> Also call it from __crash_kexec() if a crash kernel is loaded, since a
> fatal oops can enter kdump without panic(). Call it before taking the
> kexec lock, so a callback that panics can still enter kdump. Run the
> list at most once, including when a callback panics.
>=20
> Add disable_panic_notifiers_platform_list to skip these callbacks
> when debugging panic or kdump failures.
>=20
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794980455.gi=
t.zack.rusin@broadcom.com?part=3D1


