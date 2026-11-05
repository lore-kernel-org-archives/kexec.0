Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27538606EE82
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TYZJJdjr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zhykm1PJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NRKKgBaULAjA+HtCrE2b2BaKHLWg/IWOGmXDRpIt4CQ=; b=TYZJJdjr0HIlJqzDGgo4j5rAdE
	BU2SgrsFTv9VtKL9vTspsms2V/reDq/C8K1vAKA2oCVAyL3PCUchX7IuSf9wI7aYDJcqdM0+7tTPf
	d6OUhYNJDjKA0tqZ0QDVlf1C59RsssI7YtLVWXfAEiiQAhM0/1dapqt/Ybj2r/wmlZlHo6hiqe4p1
	rcBW4OrvucnOI9Xm+Y67GjXUbMztZg8nQYJk0XXRYxV1C9WBXpU8CnU/9F4k/EO2qReWjwsEi+BWA
	BFV9Hg3Rr1r1menHWf9LXb18ZNCGMKrYsQJ4WfJwsUXD3HX6HCiNvvYUy67HN5cAik4+ViODiQSdA
	hloWF7zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3bJ-0000000ASpW-3WRr;
	Thu, 05 Nov 2026 19:58:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3ao-0000000ASX7-1lz5
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:57:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2BE0343BF9;
	Thu,  5 Nov 2026 19:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1571F00904;
	Thu,  5 Nov 2026 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908670;
	bh=NRKKgBaULAjA+HtCrE2b2BaKHLWg/IWOGmXDRpIt4CQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zhykm1PJUY5wvMtL/zZjQkbyq1PyvwZC0EOgbc/mXkTXjW5jEDUFBHmJDkJa40t3l
	 GIpVPB7pCfyT4P5CA6CEZXejqjXrq+ic8kl3YEXNxI1//5Q5Py0E0a8kNnqcjW6hPi
	 K09iDwRpN/qRrfyGrXfrtzedYO2f0xYg0e0CVFZSUsUaxT5QaMI//WK8iMNBQsmWUg
	 QYwurgr8Y9JSYLqma2wGeJtJYAI+2EiMBA6btZmAUfr8ngEY8HBKKYPS4KNStW+JAC
	 Nmg8t5UHwTP7n5VK7s22hm26muMFtPD72IEuPBkcb9I0XmHhmyLKRTBgGvV//TFzuF
	 uHK+79shUVmhw==
Message-ID: <sashiko-outbox-200044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 10/30] genirq/proc: let procfs copy in the
 affinity masks
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>, linux-s390@vger.kernel.org, coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-ext4@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, tytso@mit.edu, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261104-work-procfs-fs-v2-10-319e0f9a8aae@kernel.org>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
 <20261104-work-procfs-fs-v2-10-319e0f9a8aae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:57:48 +0000
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

> Implement ->proc_write_buf() for smp_affinity, smp_affinity_list and
> default_smp_affinity so procfs copies in what is written before it pins
> the entry, and parse the masks from that copy. A list of CPUs can be
> longer than a page on large machines, so the files take as much as
> memdup_user_nul() could copy in before. Anything larger fails with
> -EINVAL instead of -ENOMEM.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-fs-v2-0-319e0f9a8aae@kernel.org?part=3D10


