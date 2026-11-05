Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D56077B71
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wfsL0r6E;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/7gvIZC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8iqvj1j0PH0IF6Pq8SLYp4U0CTa0deUsshKxdgFjrSU=; b=wfsL0r6EsqSCG4iOPntqdLMD+1
	K/kqmvsUsrhfXPkN9D8z6xDM1JVvWmWF7C3EYvdxCAmp/qJQSdXceV+sVOCDToh3dsm96y96RE/u+
	CWy9N8saQGyO2A6ZlH4LHGTsyv/W66gnju3NjXtC7715ehGdDKGgbid3O1gm3CqajKKMGShYjvymk
	DbTM4SaqRoGBNg2GFVIw+uYJs3M6k8GNkP0+xYziHmNUHyypN/kTjqGro0z8JLXzf19mWHcnJet6j
	+vXJxAkW5X7r9TeS9JbWbjmw09rTLDZZh/cjbbug7xv/aIIQ9h4Zjg76yYtWMceGH5vwYwuubXGoc
	irVfsFlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3T4-0000000APxp-0Ohg;
	Thu, 05 Nov 2026 19:49:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3Sl-0000000APkN-0JGa
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:49:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 845B66020D;
	Thu,  5 Nov 2026 19:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B731F008BF;
	Thu,  5 Nov 2026 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908170;
	bh=8iqvj1j0PH0IF6Pq8SLYp4U0CTa0deUsshKxdgFjrSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/7gvIZCknBaFzJk1RgkLwVMr4hs78B7PL/oV4FLAzy/Q5FgSU+3GZA7Xlv9b7h97
	 sOkvwq6wF34xuVZKXVh52l/paydNnOxqbPff+W5bbrXpDh4/yvE1F3UShXMByo+45D
	 ZP5FoizEXgCQAv0L5OiypTLx4sSXgSqmby9CzJLA8KHoGb/YLurZBQ1TKSA+yvkM7G
	 bivfF57fAYinyJoezBGyj5X4rL2+oMAJs7h7PIDbP2fQWTmu3frru4bUG5Jijdi1ek
	 fft2l2rYhfa/l4HQMr/2iqtHxa5FQQ/vkF3sjCMJ8uUvc5Kkaof2EtZ21M7Zq1aqf3
	 /fBPNQAhSnZVA==
Message-ID: <sashiko-outbox-199997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 11/26] scsi: core: let procfs copy in writes
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
In-Reply-To: <20261104-work-procfs-drivers-v2-11-245e54e87116@kernel.org>
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org>
 <20261104-work-procfs-drivers-v2-11-245e54e87116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:49:27 +0000
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

> Implement ->proc_write_buf() for /proc/scsi/scsi, /proc/scsi/device_info
> and the host files so procfs copies in what is written before it pins
> the entry, and parse what was written from that copy. /proc/scsi/scsi
> and device_info take up to PAGE_SIZE bytes like before. The host files
> pass the copy to ->write_info(), writes to them that are larger than
> PAGE_SIZE - 1 bytes fail with -EINVAL from procfs instead of -EOVERFLOW.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-drivers-v2-0-245e54e87116@kernel.org?part=3D11


