Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62042606A325
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xDQ/l9FC;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clDNF3tG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k0sRL5gf7qde0RaorBjAxkV83mJn8qf9Qnk0L/FwqTY=; b=xDQ/l9FCMqLVExqRgrDC+0rxPt
	he0hdUXA8tWalwqEFJVNTR6Eym0NX6+ES3YcubVkMtQxjpNqbWM78a3TEr53x69tjiDg2f7fqjKRe
	1CLUlod+3Yc2NK4cv62yoFXc2gF5mJrWaIcSRcHMwW9EhF4QysOWndpJjGNgqcRL3Q2xy2KtgsO4t
	16C6IVi/dqaC9q9R8BwWWtGgLNYYsQL1S3RBVlPTxYfuf1/p/DH5PTOLdviq7wciTIR93CGDqPO+o
	w/94f0C8f+UvyEUbSPHcHW+xbAd2VkGoHja8xV3+TdquJnU/Ii3UsAEXfgkV927t7GVZXI53xrajS
	6edkxVxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZ0F-00000007qxP-0SAS;
	Wed, 18 Nov 2026 06:18:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZ0E-00000007qx3-0YwB
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:18:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46BD1611AE;
	Wed, 18 Nov 2026 06:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572AB1F000C4;
	Wed, 18 Nov 2026 06:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982721;
	bh=k0sRL5gf7qde0RaorBjAxkV83mJn8qf9Qnk0L/FwqTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=clDNF3tGTOTKijrqHGYdDKY0j78Chuws2RC6H4nx9OkB1aR674QV92TBVX+7gZ4Wr
	 7xX0bvaBN+9RcQvn3Ns6gohunj1g2Ig1T6spV0mECiLzm6YjYfsvSKu2/xrm9mmCB/
	 SEPpHYtmqoujqZ2AttpZMdiRTL32wsaG3kqIb0M81uOkthteNplukIITXh8S0hxSGm
	 JUPZ1lqUBukMPi+mRW3iIe0jtH+gb3M9ygYMKfj1NzPcmm/R6EZsKtVE31OZW8Zuec
	 3kvsh12l2g7/l1u6KdnLP5ubV9H1by/oLcGbi9H3iP7YYzsD7tJVVnz7K9xftsJkA4
	 fg0zw67XCjQfg==
Message-ID: <sashiko-outbox-220233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] x86/vmware: Add a bounded panic log sender
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
In-Reply-To: <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:18:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794980455.gi=
t.zack.rusin@broadcom.com?part=3D2


