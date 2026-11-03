Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2785606A333
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=znDkTRpo;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnVr8aal
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/tLnPlPXv9G/A5LSRwB4ABldzL7QTmUhIz0U/QfhmpY=; b=znDkTRpojiOu1d/31eSN0ivsbp
	3FRgUCApXWAHQyg8ilauDp0AB3FktPIHtN/2sNxPC4vSKwlzw8+LHfThRORnFikQYbJ514l2zTo96
	KfFUCaGttAQzfedGyA3FUQOfY/IN+BFxaqI9VXCLGundidRRIq+YVjASgyxTjr1ONt11k7b9unxIt
	WVGcnVwT+Sg7wodgpBENcc8AYEhQHFeZpenPqd6jU+vzHQs+RgJgkJ6rRiprJKynTvcbGDgdNQajY
	xFajxTiaDfGhu2rwT0TrCvS7n2qt5wHnuY4fx32fgJAcI7x0jeIASas/9mgDw3FdW5knLKQCGP1JX
	ce7F8qdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnf-00000002kmH-25Fm;
	Tue, 03 Nov 2026 14:47:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOFnd-00000002klQ-43mb
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 14:47:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B548543607;
	Tue,  3 Nov 2026 14:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6A61F00A15;
	Tue,  3 Nov 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717265;
	bh=/tLnPlPXv9G/A5LSRwB4ABldzL7QTmUhIz0U/QfhmpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gnVr8aallzvFHKfX8uMv/E5wuzx/U/e4tluWEOCpd4vxwHOAENFWai+QEj59i2Zbf
	 FueR79cYduQK5Wd5775YLQ1Hnbw6N0rNFl8tFIRymAq3riJru71CWcnQrbOEI+G5dx
	 /PEy6cYs37h8d3VhAVmzYfGRdTRtJZRTHPBg4V0U28aDjF5G7LYmT7YlnuJVVxai7h
	 ASHng6hlOTQ/Rl8NdR8RiigPr1Mf941O/AAQOSUaA9aPrreg56qXg5kiVDOPyVN58u
	 vtE8gdT8BAP9hwnrG5Pw6qYUmibEvlAQY4bRxxSrAdo8QA8keLjhL+hfdLPBx+Wckk
	 ICpm/kdChLz5w==
Message-ID: <sashiko-outbox-195481@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/38] ALSA: info: don't write past the end of a
 data entry
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
In-Reply-To: <20261102-work-procfs-bugfixes-v1-9-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
 <20261102-work-procfs-bugfixes-v1-9-59422ed3e465@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 14:47:43 +0000
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

> snd_info_entry_write() clamps the count to what is left of the entry
> by computing entry->size - pos as a size_t. For a position past the end
> that wraps and the write goes to the driver unclamped, for opl4 into
> sample memory outside of what the entry covers. At the end of the entry
> the driver gets a count of 0 and vmalloc(0) warns. Before the clamp
> moved into the common code the driver ignored such writes. Fail them
> with -ENOSPC instead, like a block device does at the end of the
> device. Returning 0 would make writers that use stdio retry forever.
>=20
> Fixes: d97e1b78239c ("ALSA: info - Check file position validity in common=
 layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-bugfixes-v1-0-59422ed3e465@kernel.org?part=3D9


