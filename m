Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAA606A323
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S45Nc7mJ;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QD98c7+Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ji+N2UCWOUlma5D+SRQ8WQSLAke0ouvDumRVQuY2Z+c=; b=S45Nc7mJepd9kQiFLXVhqRB70x
	6SSzjJAu1Aiicer80z2Oyc5RI5fdfn37Djr1cR496Hybq1ytzjJwEWjXcp1JonXdcntEwoMVuTE8Y
	NJIY405zhaQHPaqFNIrtnMZwziPZS6H4ljeEBKmgBobKXQ5lByyRgtk4WK6C5P0YRIrcLvcETKh4f
	P2t/fGXGRHFnY+Q2e9KvenSKHGGTuPPQZ+QN5EIbqbo7AVS4LrD5sUqwbHvEJkz5sLLLwmvqdVbOX
	vND1kk3IcgfJOUocD/Gk42OMZmugsyFRFzdbJ3A8FMHPOdbB6yGxkPwO19hI7gvsuu16wsdVDsTbB
	42GPScYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQINf-0000000HTEB-2J40;
	Mon, 09 Nov 2026 05:57:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQINe-0000000HTE3-22qR
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:57:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A647762D64;
	Mon,  9 Nov 2026 05:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE61F008A5;
	Mon,  9 Nov 2026 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203841;
	bh=Ji+N2UCWOUlma5D+SRQ8WQSLAke0ouvDumRVQuY2Z+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QD98c7+ZA1lNMUKOFkGk7LJ8dsDdynROBQEfkSbKIBlupSF41HT80NJYhemdNrI3S
	 MKTnwESO65RErD5EnTgytlpNNm+kssE55ynH6AxlYM2R2z+JSEVM3+P1Uexz9xc5z1
	 PWuT9+gcgc3/y6ZOScC2Q2ADxzpQ+2vdQI1l2tAjD5zDC9YbONkTpJIpfIhTtbArZe
	 3bggyDVpp0OPtE4byymk8h206ghfQbuT8cfORqork37VnPoWY25I3cKRZS4XaSwhlC
	 RLQiIW9t7XhicVcwskHlOc7jH4xv5RY7KsEKQdl1ACJu8i0Vuk4DBYG1oMFcfwthfx
	 6PUjamWE7gYww==
Message-ID: <sashiko-outbox-204466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] x86/vmware: Add a bounded panic log sender
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
In-Reply-To: <b4befd89cc0b5844f499606b7d42f13cdb37046a.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <b4befd89cc0b5844f499606b7d42f13cdb37046a.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:57:19 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> A VMware guest may be unable to save its own logs after a crash. Copy
> the newest kernel log records to the host's vmware.log before kdump,
> so they remain available if the capture kernel fails.
>=20
> Register the sender on the platform panic notifier list and send the
> log through the low-bandwidth register interface. Allocate a fixed
> 8 KiB buffer during early init; 4 KiB can lose useful stack-trace
> context. The callback allocates no memory and emits no printk
> messages. Limit the transfer to the buffer size and make at most three
> attempts, retrying only if a VM checkpoint interrupts the transfer.
>=20
> Enable logging by default only in guests without memory encryption;
> encrypted guests should send their log to the host only when an
> administrator opts in. The copy is best-effort diagnostics; kdump does
> not depend on it succeeding.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN=
6PR02MB4157.namprd02.prod.outlook.com
> Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@=
broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D2


